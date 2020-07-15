require 'test_helper'

module Workarea
  module Export
    class CatalogTest < Workarea::TestCase
      include Storefront::Engine.routes.url_helpers

      setup :create_catalog

      def create_catalog
        create_product()
        create_category()
      end

      def test_creates_incremental_feed
        categories = Workarea::Catalog::Category.bazaar_voice_exportable
        products = Workarea::Catalog::Product.bazaar_voice_exportable
        options = { incremental: true }

        Dir.mktmpdir do |dir|
          path = "#{dir}/test_bazaar_voice_feed.xml"
          BazaarVoice::Export::Catalog.new(path, categories, products, options).build
          xml = File.read(path)
          assert_includes(xml, 'incremental="true"')
        end
      end

      def test_creates_full_feed
        categories = Workarea::Catalog::Category.all
        products = Workarea::Catalog::Product.all
        options = { incremental: false }

        Dir.mktmpdir do |dir|
          path = "#{dir}/test_bazaar_voice_feed.xml"
          BazaarVoice::Export::Catalog.new(path, categories, products, options).build
          xml = File.read(path)
          assert_includes(xml, 'incremental="false"')
        end
      end

      def test_feed_includes_default_brand_from_config
        categories = Workarea::Catalog::Category.all
        products = Workarea::Catalog::Product.all
        options = { incremental: false }

        Dir.mktmpdir do |dir|
          path = "#{dir}/test_bazaar_voice_feed.xml"
          BazaarVoice::Export::Catalog.new(path, categories, products, options).build
          xml = File.read(path)
          assert_includes(xml, '<Brand>')
          assert_includes(xml, Workarea.config.bazaar_voice_default_brand_id)
          assert_includes(xml, Workarea.config.bazaar_voice_default_brand_name)
        end
      end

      def test_does_not_create_an_incremental_feed_if_models_are_unchanged
        # clear out catalog data from the before action
        Workarea::Catalog::Product.delete_all
        Workarea::Catalog::Category.delete_all

        travel_to 2.weeks.ago
        create_product()
        create_category()
        travel_back

        incremental_categories = Workarea::Catalog::Category.bazaar_voice_exportable
        incremental_products = Workarea::Catalog::Product.bazaar_voice_exportable
        options = { incremental: true }

        Dir.mktmpdir do |dir|
          path = "#{dir}/test_bazaar_voice_feed.xml"
          export = BazaarVoice::Export::Catalog.new(path, incremental_categories, incremental_products, options).build

          assert(export.nil?)
        end
      end
    end
  end
end
