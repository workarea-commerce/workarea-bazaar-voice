module Workarea
  module BazaarVoice
    module Export
      class XmlBuilder
        include ActionView::Helpers::AssetUrlHelper
        include Workarea::I18n::DefaultUrlOptions
        include Storefront::Engine.routes.url_helpers

        def initialize(document)
          @document = document
        end

        def self.create_feed(options)
          Nokogiri::XML::Builder.new(encoding: 'UTF-8') do |xml|
            xml.Feed(
              name: BazaarVoice.config.client_name.downcase,
              extractDate: Time.now.strftime('%Y-%m-%dT%H:%M:%S'),
              incremental: options[:incremental],
              xmlns: 'http://www.bazaarvoice.com/xs/PRR/ProductFeed/14.7'
            ) do
                xml.Brands {}
                xml.Categories {}
                xml.Products {}
            end
          end.to_xml
        end

        def add_category(category)
          category_xml = build_category(category)
          @document.search("Categories").first.add_child(category_xml)
          @document
        end

        def add_product(product)
          return @document if product.model.variants.empty?
          product_xml = build_product(product)
          @document.search("Products").first.add_child(product_xml)
          @document
        end

        def add_brand(brand)
          brand_xml = build_brand(brand)
          @document.search("Brands").first.add_child(brand_xml)
          @document
        end

        private

        def build_category(category)
          category_node = Nokogiri::XML::Node.new("Category", @document)
          category_node.add_child("<ExternalId>#{category.id.to_s}</ExternalId>\n")
          category_node.add_child("<Name>#{CGI.escapeHTML(category.name)}</Name>\n")

          category_node
        end

        def build_brand(brand)
          brand_node = Nokogiri::XML::Node.new("Brand", @document)
          brand_node.add_child("<ExternalId>#{brand[:external_id]}</ExternalId>\n")
          brand_node.add_child("<Name>#{CGI.escapeHTML(brand[:name])}</Name>\n")

          brand_node
        end

        def build_product(product)
          product_node = Nokogiri::XML::Node.new("Product", @document)
          product_node.add_child("<ExternalId>#{product.bv_product_id}</ExternalId>\n")
          product_node.add_child("<Name>#{CGI.escapeHTML(product.name)}</Name>\n")
          product_node.add_child("<Description>#{product_description(product)}</Description>\n")
          add_product_brand(product_node)
          product_node.add_child("<CategoryExternalId>#{default_category_id(product)}</CategoryExternalId>\n")
          product_node.add_child("<ProductPageUrl>#{product_url(product, host: Workarea.config.host)}</ProductPageUrl>\n")
          product_node.add_child("<ImageUrl>#{product_image_url(product)}</ImageUrl>\n")
          upcs = product.model.variants.map { |v| "<UPC>#{v.sku}</UPC>\n" }
          product_node.add_child("<UPCs>#{upcs.join('')}</UPCs>\n")

          product_node
        end

        def add_product_brand(product_node)
          if Workarea::BazaarVoice.default_brand.present?
            product_node.add_child("<BrandExternalId>#{Workarea::BazaarVoice.default_brand[:external_id]}</BrandExternalId>\n")
          end
        end

        def product_description(product)
          if product.description.present?
            CGI.escapeHTML(product.description)
          else
            ''
          end
        end

        def default_category_id(product)
          categorization(product).default_model.try(:id)
        end

        def categorization(product)
          Workarea::Categorization.new(product.model)
        end

        def product_image_url(product)
          job = :detail
          image =
            if product.primary_image.option.present?
              Core::Engine.routes.url_helpers.dynamic_product_image_url(
                product,
                product.primary_image.option,
                product.primary_image.id,
                job,
                only_path: true,
                c: product.primary_image.updated_at.to_i
              )
            else
              Core::Engine.routes.url_helpers.dynamic_product_image_url(
                product,
                image_id: product.primary_image.id,
                option: nil,
                job: job,
                only_path: true,
                c: product.primary_image.updated_at.to_i
              )
            end

          image_url(
            image,
            host: Rails.application.config.action_controller.asset_host
          )
        end
      end
    end
  end
end
