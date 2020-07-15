module Workarea
  module Storefront
    module BazaarVoiceAnalyticsHelper
      def order_analytics_data(order)
        super.merge(currency: order.total_price.currency.iso_code)
      end
    end
  end
end
