module Workarea
  module BazaarVoice
    class RatingsImporter
      include Sidekiq::Worker
      sidekiq_options unique: :until_and_while_executing

      class BazaarVoiceSFTPError < StandardError; end


      def perform
        raise BazaarVoiceSFTPError unless Workarea::BazaarVoice.sftp_username.present?

        file = "bv_#{username}_ratings.xml.gz"

        Dir.mktmpdir do |dir|
          # extract into the tmp dir
          Net::SFTP.start(host, username, password: password) do |sftp|
            sftp.download!("/feeds/#{file}", "#{dir}/#{file}")
          end

          Workarea::BazaarVoice::XmlReader.new(file_path: "#{dir}/#{file}", node: "Product").each do | product_hash|
            Workarea::BazaarVoice::RatingImporter.new(product_hash).import
          end
        end
      end

      private

        def host
          Workarea::BazaarVoice.sftp_host
        end

        def username
          Workarea::BazaarVoice.sftp_username
        end

        def password
          Workarea::BazaarVoice.sftp_password
        end
    end
  end
end
