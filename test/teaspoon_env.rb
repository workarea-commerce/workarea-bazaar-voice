require "workarea/testing/teaspoon"

Teaspoon.configure do |config|
  config.root = Workarea::BazaarVoice::Engine.root
  Workarea::Teaspoon.apply(config)
end
