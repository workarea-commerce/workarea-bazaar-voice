namespace :bazaar_voice do
  desc 'Export full catalog to BazaarVoice'
  task full_export: :environment do
    puts 'Creating Feed...'
    categories = Workarea::Catalog::Category.active
    products = Workarea::Catalog::Product.active
    options = { incremental: false }

    Dir.mktmpdir do |dir|
      file_name = "bazaar_voice_full_feed.xml"
      path = "#{dir}/#{file_name}"
      file = File.new(path, 'w+')

      Workarea::BazaarVoice::Export::Catalog.new(path, categories, products, options).build

      puts 'Uploading feed to BazaarVoice...'
      Workarea::BazaarVoice::Export.upload_file(file_name, path)
    end
  end
end
