module Workarea
  module BazaarVoice
    module Export
      def self.host
        Workarea::BazaarVoice.sftp_host
      end

      def self.username
        Workarea::BazaarVoice.sftp_username
      end

      def self.password
        Workarea::BazaarVoice.sftp_password
      end

      def self.upload_file(file, file_path)
        return unless enabled?

        Net::SFTP.start(host, username, password: password) do |sftp|
          sftp.upload!(file_path, "/import-inbox/#{file}")
        end
      end

      # Test whether to auto-enable cron jobs. We disable them by
      # default unless on production, or
      # +BazaarVoice.config.export_enabled]+ is set to +true.
      #
      # @return [Boolean]
      def self.enabled?
        return BazaarVoice.config.export_enabled if BazaarVoice.config.export_enabled.present?
        Rails.env.production?
      end
    end
  end
end
