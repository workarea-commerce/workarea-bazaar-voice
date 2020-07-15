require "test_helper"

module Workarea
  module Storefront
    class BazaarVoiceIntegrationTest < Workarea::IntegrationTest
      setup :setup_product

      def test_container_page_requires_login
        delete storefront.logout_path

        get storefront.bazaar_voice_container_page_path(id: @product.id)
        assert_redirected_to(storefront.login_path)
      end

      def test_container_page
        set_current_user(create_user)

        get storefront.bazaar_voice_container_page_path(id: @product.id)

        test_js_url = "https://apps.bazaarvoice.com/deployments/test/Test/staging/en_US/bv.js"

        assert_includes(response.body, "<link href='http://www.example.com/bazaar_voice/product/#{@product.id}' rel='canonical'>")
        assert_includes(response.body, "<meta content='noindex, nofollow' property='robots'>")
        assert_includes(response.body, test_js_url)
      end

      private

      def setup_product
        @product = Storefront::ProductViewModel.wrap(create_product)
      end
    end
  end
end
