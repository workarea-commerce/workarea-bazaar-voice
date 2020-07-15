unless Workarea.config.skip_service_connections
  Sidekiq::Cron::Job.create(
    name: 'Workarea::BazaarVoice::CatalogExporter',
    klass: 'Workarea::BazaarVoice::CatalogExporter',
    cron: "0 1 * * * #{Time.zone.tzinfo.identifier}",
    queue: 'low'
  )


  Sidekiq::Cron::Job.create(
    name: 'Workarea::BazaarVoice::RatingsImporter',
    klass: 'Workarea::BazaarVoice::RatingsImporter',
    cron: "0 4 * * * #{Time.zone.tzinfo.identifier}",
    queue: 'low'
  )
end
