require "workarea"
require "workarea/storefront"
require "workarea/admin"

require "workarea/bazaar_voice/engine"
require "workarea/bazaar_voice/version"
require "workarea/bazaar_voice/export"
require "workarea/bazaar_voice/tokenize_user"
require "workarea/bazaar_voice/xml_reader"
require "workarea/bazaar_voice/export/catalog"
require "workarea/bazaar_voice/export/xml_builder"

module Workarea
  module BazaarVoice
    def self.using_conversations?
      if config.integration_type.present?
        config.integration_type.downcase == 'conversations'
      else
        false
      end
    end

    def self.default_brand
      return nil unless Workarea.config.bazaar_voice_default_brand_id

      {
        external_id: Workarea.config.bazaar_voice_default_brand_id,
        name: Workarea.config.bazaar_voice_default_brand_name
      }
    end

    def self.excluded_product_templates
      Workarea.config.bazaar_voice_excluded_product_templates.presence || []
    end

    def self.requires_login?
      Workarea.config.bazaar_voice_requires_login
    end

    def self.credentials
      (Rails.application.secrets.bazaar_voice || {}).deep_symbolize_keys
    end

    def self.config
      ActiveSupport::InheritableOptions.new(
        client_name: Workarea.config.bazaar_voice_client_name,
        site_id: Workarea.config.bazaar_voice_site_id,
        display_rating_summary: Workarea.config.bazaar_voice_display_rating_summary,
        display_inline_ratinsgs: Workarea.config.bazaar_voice_display_inline_ratings,
        display_review_highlights: Workarea.config.bazaar_voice_display_review_highlights,
        display_questions: Workarea.config.bazaar_voice_display_questions,
        export_interval: Workarea.config.bazaar_voice_export_interval,
        export_enabled: Workarea.config.bazaar_voice_export_enabled,
        syndicated: Workarea.config.bazaar_voice_syndicated,
        excluded_product_templates: Workarea.config.bazaar_voice_excluded_product_templates,
        shared_key: Workarea.config.bazaar_voice_shared_key
      )
    end

    def self.sftp_credentials
      credentials[:export]
    end

    def self.sftp_host
      sftp_credentials[:host]
    end

    def self.sftp_username
      sftp_credentials[:username]
    end

    def self.sftp_password
      sftp_credentials[:password]
    end
  end
end
