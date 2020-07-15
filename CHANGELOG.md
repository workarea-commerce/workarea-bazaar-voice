Workarea Bazaar Voice 1.0.2 (2020-07-02)
--------------------------------------------------------------------------------

*   move test file to workarea directory


    Luis Mercado



Workarea Bazaar Voice 1.0.1 (2019-03-19)
--------------------------------------------------------------------------------

*   Update integration test to use DELETE verb for logout_path

    BV-17
    Jake Beresford

*   Update CI scripts for v3.4 compatibility

    BV-17
    Jake Beresford



Workarea Bazaar Voice 1.0.0 (2019-02-05)
--------------------------------------------------------------------------------

*   Release v1.0.0

    no changes from v1.0.0.beta.6
    Eric Pigeon



Workarea Bazaar Voice 1.0.0.beta.6 (2019-01-22)
--------------------------------------------------------------------------------

*   Add all product variants from model to feed

    Product feed UPCs should contain all variants, not just active ones which are filtered by the view model.

    * Excludes products without any variants from the BV feed

    BV-16
    Jake Beresford



Workarea Bazaar Voice 1.0.0.beta.5 (2019-01-21)
--------------------------------------------------------------------------------

*   Combine catalog create brand methods

    BV-16
    Jake Beresford

*   * Add configuration and method for excluding products from feed

    BV-16
    Jake Beresford

*   Add default brand functionality

    Bazaar Voice product feeds require a brand field to be present, since Workarea does not have a concept of Brand a default brand can be set via configuration.

    * Add configuration for default brand to BazaarVoice class methods
    * Add methods to xml builder to allow for adding brands
    * Update add_product method to use default brand external ID if the configuration is set
    * Refactor Export::Catalog to make decoration easier and improve code structure
    * Skip package products in catalog export
    * Join UPCs array for valid XML
    * Add instructions for default brand to Readme

    BV-16
    Jake Beresford



Workarea Bazaar Voice 1.0.0.beta.4 (2019-01-15)
--------------------------------------------------------------------------------

*   Update XML builder to escape HTML characters

    Previously Nokogiri was detecting unescaped characters and handling the
    encoding. This caused the tag name to be downcased, which fials BazaarVoice
    feed validation. All tag names must be PascalCase.

    * Also remove a redundant TODO comment

    BV-16
    Jake Beresford



Workarea Bazaar Voice 1.0.0.beta.3 (2019-01-10)
--------------------------------------------------------------------------------

*   Bump version for beta3 release

    Jake Beresford

*   Update product feed XML based on BV validation

    BV-16
    Jake Beresford

*   Bump version for beta.2 release no changelog

    Jake Beresford

*   Decorate ProductViewModel with new bv_product_id method

    This change allows developers to easily change which field should be used as the product ID for BazaarVoice.

    BV-14
    Jake Beresford

*   Invert logic for configuring container page URL for PRR

    BV-13
    Jake Beresford

*   Move test configuration into test/support to prevent test failures when running in app

    BV-11
    Jake Beresford

*   Correct Klass name in cron configuration

    BV-12
    Jake Beresford

*   Update README with instructions for BV catalog feed

    * Removed redundant api_key configuration instructions and class method, this was unused in the end as we implemented the plugin not to use the API directly.

    BV-10
    Jake Beresford



Workarea Bazaar Voice 1.0.0.beta.2 (2018-12-12)
--------------------------------------------------------------------------------

*   Bump version for beta.2 release no changelog

    Jake Beresford

*   Decorate ProductViewModel with new bv_product_id method

    This change allows developers to easily change which field should be used as the product ID for BazaarVoice.

    BV-14
    Jake Beresford

*   Invert logic for configuring container page URL for PRR

    BV-13
    Jake Beresford

*   Move test configuration into test/support to prevent test failures when running in app

    BV-11
    Jake Beresford

*   Correct Klass name in cron configuration

    BV-12
    Jake Beresford

*   Update README with instructions for BV catalog feed

    * Removed redundant api_key configuration instructions and class method, this was unused in the end as we implemented the plugin not to use the API directly.

    BV-10
    Jake Beresford



Workarea Bazaar Voice 1.0.0.beta.1 (2018-11-20)
--------------------------------------------------------------------------------

*   Bump version for beta-1 release

    Jake Beresford

*   Implement user authentication for write review access

    * Redirect user to login screen unless they are logged in
    * Add class BazaarVoice::TokenizeUser to create signed user tokens
    * Output user token on container page if login is required
    * Move $BV configure for container page URL to it's own partial

    BV-8
    Jake Beresford

*   Implement write review

    * Update BV loader implementation to work with PRR and Conversations
    * Get container page configured for PRR and make it work

    BV-4
    Jake Beresford

*   Download and consume average ratings from the BV sftp file

    BV-7
    Jeff Yucis

*   Fix issues with catalog export

    Commit fixes issues with sFTP connection and upload. Also fixes issues
    with non secret values being stored in the secrets

    BV-1
    Jeff Yucis

*   Rename analytics helper

    BV-5
    Jake Beresford

*   Implement BV Pixel integration

    * Add new analytics adapter for BV pixel including transaction and conversion tracking
    * Tracks add to cart, email signup, product view, and order placed events
    * Add currency to the order_analytics_data via a new helper method
    * Updates to README

    BV-5
    Jake Beresford

*   Implement reviews display

    * Add view partials for all BV display modules
    * Add view partial for bv.js script to be appended to head
    * Add view partial for questions & answers
    * Update bv url helper to use en_us locale for en, downcase client name
    * Conditionally render optional display modules based on configuration
    * Add hostname and display_code configuration to BV Loader script tag
    * Add some useful information to the README

    BV-3
    Jake Beresford

*   Update all product feed tests to pass and fix some buggos

    BV-1
    Jake Beresford

*   Remove unused file variable

    BV-1
    Jake Beresford

*   * Refactor XML builder to incrementally write each category or product to file rather than storing the full XML doc in memory

    BV-1
    Jake Beresford

*   rubocop nochangelog

    Jake Beresford

*   Implement BazaarVoice container page

    * Add BazaarVoiceController
    * Add route to bazaar_voice#show
    * Add container_page layout for bazaar_voice#show
    * Use a helper to build out bazaarvoice js URL and connonical URL on container page
    * Implemented based on BV documentation

    BV-6
    Jake Beresford

*   Implement BazaarVoice catalog feed

    Export catalog to BazaarVoice via XML and SFTP. Full and incremental export
    possible. Full export should be used to init the product catalog, run via
    rake task. Incremental export runs nightly at 1am and sends any products that
    have changed in the last 2 days.

    Additionally this PR:
    * Sets up configuration for BV via secrets
    * Fixes the test/dummy environment for CI

    BV-1
    Jake Beresford

*   Remove references to active_storage from test app

    Jake Beresford



