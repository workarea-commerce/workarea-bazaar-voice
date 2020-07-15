require 'test_helper'

module Workarea
  module Export
    class XmlBuilderTest < Workarea::TestCase
      include Storefront::Engine.routes.url_helpers

      setup :create_catalog

      def create_catalog
        create_product(
          name: "Product & Name",
          description: 'test & description'
        )
        create_category(
          name: "Category - Test & Encoding"
        )
      end

      def full_products
        Workarea::Catalog::Product.all.select(&:active?)
      end

      def full_categories
        Workarea::Catalog::Category.all.select(&:active?)
      end

      def incremental_products
        Workarea::Catalog::Product.bazaar_voice_exportable
      end

      def incremental_categories
        Workarea::Catalog::Category.bazaar_voice_exportable
      end

      def test_creates_incremental_or_full_feed
        incremental_xml = BazaarVoice::Export::XmlBuilder.create_feed({ incremental: true })
        assert_includes(incremental_xml, 'incremental="true"')

        full_xml = BazaarVoice::Export::XmlBuilder.create_feed({ incremental: false })
        assert_includes(full_xml, 'incremental="false"')
      end

      def test_adds_product_to_xml_feed
        product = Storefront::ProductViewModel.wrap(full_products.first)

        Dir.mktmpdir do |dir|
          path = "#{dir}/test_bazaar_voice_feed.xml"
          File.write(path, BazaarVoice::Export::XmlBuilder.create_feed({ incremental: false }))
          document = File.open(path) { |f| Nokogiri::XML(f) }

          builder = BazaarVoice::Export::XmlBuilder.new(document)
          xml = builder.add_product(product).to_xml

          assert_includes(xml, '<Product>')
          assert_includes(xml, product.bv_product_id)
          assert_includes(xml, "<Name>Product &amp; Name</Name>")
          assert_includes(xml, "<Description>test &amp; description</Description>")
          assert_includes(xml, product.variants.first.sku)
          assert_includes(xml, product.slug)
        end
      end

      def test_adds_category_to_xml_feed
        category = Storefront::CategoryViewModel.wrap(full_categories.first)

        Dir.mktmpdir do |dir|
          path = "#{dir}/test_bazaar_voice_feed.xml"
          File.write(path, BazaarVoice::Export::XmlBuilder.create_feed({ incremental: false }))
          document = File.open(path) { |f| Nokogiri::XML(f) }

          builder = BazaarVoice::Export::XmlBuilder.new(document)
          xml = builder.add_category(category).to_xml

          assert_includes(xml, '<Category>')
          assert_includes(xml, category.id.to_s)
          assert_includes(xml, '<Name>Category - Test &amp; Encoding</Name>')
        end
      end

      def test_adds_brand_to_xml_feed
        brand = {
          external_id: 'test_brand',
          name: 'Test Brand'
        }

        Dir.mktmpdir do |dir|
          path = "#{dir}/test_bazaar_voice_feed.xml"
          File.write(path, BazaarVoice::Export::XmlBuilder.create_feed({ incremental: false }))
          document = File.open(path) { |f| Nokogiri::XML(f) }

          builder = BazaarVoice::Export::XmlBuilder.new(document)
          xml = builder.add_brand(brand).to_xml

          assert_includes(xml, '<Brand>')
          assert_includes(xml, '<ExternalId>test_brand</ExternalId>')
          assert_includes(xml, '<Name>Test Brand</Name>')
        end
      end
    end
  end
end
