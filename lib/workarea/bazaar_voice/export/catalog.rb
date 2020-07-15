module Workarea
  module BazaarVoice
    module Export
      class Catalog
        def initialize(path, categories, products, options = {})
          @path = path
          @categories = categories
          @products = products

          File.write(@path, BazaarVoice::Export::XmlBuilder.create_feed(options))

          document = File.open(@path) { |f| Nokogiri::XML(f) }
          @builder = BazaarVoice::Export::XmlBuilder.new(document)
        end

        def build
          return unless @categories.present? || @products.present?
          build_categories
          build_brands
          build_products
        end

        def build_categories
          @categories.each_by(100) do |category|
            next unless category.active?

            c = Storefront::CategoryViewModel.wrap(category)
            File.write(@path, @builder.add_category(c))
          end
        end

        def build_brands
          if Workarea::BazaarVoice.default_brand.present?
            brand = Workarea::BazaarVoice.default_brand
            File.write(@path, @builder.add_brand(brand))
          end
        end

        def build_products
          @products.each_by(100) do |product|
            next if product.template.in?(['package', 'family']) || !product.active?

            p = Storefront::ProductViewModel.wrap(product)
            File.write(@path, @builder.add_product(p))
          end
        end

        private

        def product_excluded(product)
          if Workarea::BazaarVoice.excluded_product_templates.present?
            product.template.in?(Workarea::BazaarVoice.excluded_product_templates)
          else
            false
          end
        end
      end
    end
  end
end
