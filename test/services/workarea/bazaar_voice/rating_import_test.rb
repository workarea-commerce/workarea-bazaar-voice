require "test_helper"

module Workarea
  module BazaarVoice
    class RatingImportTest < Workarea::TestCase
      def test_product_rating_is_imported
        product = create_product(id: "34659193")

        Workarea::BazaarVoice::RatingImporter.new(product_details_hash).import

        product.reload

        assert_equal(3.0, product.rating)
      end

      def test_syndicated_product_rating_is_imported
        Workarea.config.bazaar_voice_syndicated = true
        product = create_product(id: "34659193")

        Workarea::BazaarVoice::RatingImporter.new(product_details_hash).import

        product.reload

        assert_equal(4.0, product.rating)
      end

      private

      def product_details_hash
        {
          "xmlns" => "http://www.bazaarvoice.com/xs/PRR/SyndicationFeed/5.6",
          "removed" => "false",
          "id" => "34659193",
          "ImageUrl" => "http://s7d1.scene7.com/is/image/BHLDN/34659193_011_a?$2$",
          "Name" => "Yvie Gown",
          "ExternalId" => "34659193",
          "Source" => "BHLDN",
          "ProductPageUrl" => "http://www.bhldn.com/SHOP-Sale/Yvie-Gown/",
          "NativeReviewStatistics" => {
            "AverageOverallRating" => "3.0",
            "OverallRatingRange" => "5",
            "RatingsOnlyReviewCount" => "0",
            "RecommendedCount" => "0",
            "TotalReviewCount" => "1",
            "AverageRatingValues" => {
              "AverageRatingValue" => {
                "id" => "Fit",
                "AverageRating" => "2.0",
                "RatingDimension" => {
                  "displayType" => "SLIDER",
                  "selectedValueInDisplayEnabled" => "false",
                  "id" => "Fit",
                  "ExternalId" => "Fit",
                  "Label" => "Overall Fit",
                  "Label1" => "Small",
                  "Label2" => "Large",
                  "RatingRange" => "5" } } },
            "RatingDistribution" => { "RatingDistributionItem" => { "RatingValue" => "3", "Count" => "1" } } },
          "NumReviews" => "1",
          "ProductReviewsUrl" =>
          "http://reviews.bhldn.com/bvstaging/4501/product/34659193/reviews.htm",
          "ReviewStatistics" => {
            "AverageOverallRating" => "4.0",
            "OverallRatingRange" => "5",
            "RatingsOnlyReviewCount" => "0",
            "RecommendedCount" => "0",
            "TotalReviewCount" => "1",
            "AverageRatingValues" => {
              "AverageRatingValue" => {
                "id" => "Fit",
                "AverageRating" => "2.0",
                "RatingDimension" => {
                  "displayType" => "SLIDER",
                  "selectedValueInDisplayEnabled" => "false",
                  "id" => "Fit",
                  "ExternalId" => "Fit",
                  "Label" => "Overall Fit",
                  "Label1" => "Small",
                  "Label2" => "Large",
                  "RatingRange" => "5" } } } }
        }
      end
    end
  end
end
