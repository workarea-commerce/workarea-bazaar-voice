require 'workarea/bazaar_voice'

module Workarea
  module BazaarVoice
    class Engine < ::Rails::Engine
      include Workarea::Plugin
      isolate_namespace Workarea::BazaarVoice

      config.to_prepare do
        Storefront::ApplicationController.helper(Storefront::BazaarVoiceHelper)
        Storefront::ApplicationController.helper(Storefront::BazaarVoiceAnalyticsHelper)
      end
    end
  end
end
