require "test_helper"

module Workarea
  module BazaarVoice
    class TokenizeUserTest < Workarea::TestCase
      def test_returns_valid_user_token
        travel_to Time.new(2018, 11, 9) do
          user = create_user(id: '12345')
          tokenizer = BazaarVoice::TokenizeUser.new(user)

          expected_token = '5d954c05d441105519bf1ced6afa8888646174653d323031382d31312d3039267573657269643d3132333435'

          assert_equal(expected_token, tokenizer.token)
        end
      end
    end
  end
end
