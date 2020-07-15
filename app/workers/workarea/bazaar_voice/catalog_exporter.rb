module Workarea
  module BazaarVoice
    class CatalogExporter
      include Sidekiq::Worker

      def perform
        categories = Workarea::Catalog::Category.bazaar_voice_exportable
        products = Workarea::Catalog::Product.bazaar_voice_exportable
        options = { incremental: true }

        Dir.mktmpdir do |dir|
          file = "bazaar_voice_feed.xml"
          path = "#{dir}/#{file}"
          File.new(path, 'w+')
          export = Workarea::BazaarVoice::Export::Catalog.new(path, categories, products, options).build

          return if export.nil?

          Workarea::BazaarVoice::Export.upload_file(file, path)
        end
      end
    end
  end
end
