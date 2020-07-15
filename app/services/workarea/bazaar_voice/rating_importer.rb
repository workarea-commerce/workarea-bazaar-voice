module Workarea
  module BazaarVoice
    class RatingImporter
      attr_accessor :rating_details

      def initialize(rating_details)
        @rating_details = rating_details
      end

      def import
        product = Workarea::Catalog::Product.where(id: rating_details["id"]).first
        return unless product.present?

        product.update_attributes!(
          rating: rating_details[rating_key]["AverageOverallRating"]
        )
      end

      private

      def rating_key
        if BazaarVoice.config.syndicated
          "ReviewStatistics"
        else
          "NativeReviewStatistics"
        end
      end
    end
  end
end
