module Workarea
  module Storefront
    module BazaarVoiceHelper
      def bazaar_voice_js_url
        return "" if BazaarVoice.config.client_name.empty?
        [
          "https://apps.bazaarvoice.com/deployments",
          BazaarVoice.config.client_name.downcase,
          BazaarVoice.config.site_id,
          Rails.env.production? ? "production" : "staging",
          bv_locale,
          "bv.js"
        ].join("/")
      end

      def bazaar_voice_cannonical_url
        request.url
      end

      private

      def bv_locale
        return 'en_US' if I18n.locale == :en
        I18n.locale
      end
    end
  end
end
