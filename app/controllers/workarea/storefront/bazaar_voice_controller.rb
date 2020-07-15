module Workarea
  module Storefront
    class BazaarVoiceController < Storefront::ApplicationController
      before_action :require_login, if: :requires_login?

      layout "workarea/bazaar_voice/container_page"

      def show
        product = Catalog::Product.find(params[:id])
        @product = Storefront::ProductViewModel.wrap(product)
        if requires_login?
          @bv_user = BazaarVoice::TokenizeUser.new(current_user)
        end
      end

      private

      def requires_login?
        Workarea::BazaarVoice.requires_login?
      end
    end
  end
end
