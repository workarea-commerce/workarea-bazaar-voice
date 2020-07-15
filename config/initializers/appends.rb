module Workarea
  Plugin.append_partials(
    'storefront.document_head',
    'workarea/storefront/bazaar_voice/scripts/bv_loader'
  )

  Plugin.append_javascripts(
    'storefront.modules',
    'workarea/storefront/bazaar_voice/modules/bv_pixel_adapter',
  )

  Plugin.append_partials(
    'storefront.product_show',
    'workarea/storefront/bazaar_voice/reviews/review_highlights',
  )

  Plugin.append_partials(
    'storefront.product_show',
    'workarea/storefront/bazaar_voice/questions_answers/show'
  )

  Plugin.append_partials(
    'storefront.product_show',
    'workarea/storefront/bazaar_voice/reviews/reviews',
    'workarea/storefront/bazaar_voice/reviews/review_submission_container_configuration'
  )

  Plugin.append_partials(
    'storefront.product_details',
    'workarea/storefront/bazaar_voice/reviews/rating_summary'
  )

  Plugin.append_partials(
    'storefront.product_summary',
    'workarea/storefront/bazaar_voice/reviews/inline_rating'
  )
end
