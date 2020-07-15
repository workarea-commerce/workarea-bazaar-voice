module Workarea
  module BazaarVoice
    class TokenizeUser
      require 'digest'

      def initialize(current_user)
        @user = current_user
      end

      def token
        Digest::MD5.hexdigest(Workarea::BazaarVoice.config.shared_key + userStr).concat(bin_to_hex(userStr))
      end

      private

      def userStr
        "date=#{Time.now.strftime("%Y-%m-%d")}&userid=#{@user.id}"
      end

      def bin_to_hex(s)
        s.each_byte.map { |b| b.to_s(16) }.join
      end
    end
  end
end
