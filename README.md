# Workarea Bazaar Voice

Bazaar Voice plugin for the Workarea platform.

This Workarea plugin uses the hosted javascript solution provided by BazaarVoice.
The UI for displaying and submitting reviews will be rendered by javascript
provided by BazaarVoice. This allows the platform to make use of the various UI
form elements provided by BazaarVoice.

The plugin is intended to work with both legacy(PRR) and Conversations APIs.
Some additional configuration is required for this to work.

Workarea will generate a new product feed for BazaarVoice to consume every day.
This feed is submitted to BazaarVoice via sFTP. See **secrets configuration** in
this readme for how to add credentials for the upload process.

## Included Features

* Reviews
  * Write reviews
  * Display reviews on PDP
  * Display rating aggregate on PDP
  * Display review highlights on PDP
  * Display inline reviews on product summary
* Question & Answer
  * Display questions UI on PDP
* BV Pixel
* XML Product Feed

## Getting Started

This gem contains a rails engine that must be mounted onto a host Rails application.

To install, add the following to your Gemfile:

```ruby
gem 'workarea-bazaar_voice'
```

Then, run:

```bash
$ bundle
```

You'll then have to configure secrets with your provided production
credentials:

```yaml
  bazaar_voice:
    :export:
      :host: # production: 'sftp.bazaarvoice.com' staging: 'sftp-stg.bazaarvoice.com'
      :username: 'your BV Username'
      :password: 'your BV SFTP Password'
```

And finally, the application. You can either the following configuration settings
in an initializer:

```ruby
Workarea.configure do |config|
  config.bazaar_voice_client_name = <string>
  config.bazaar_voice_site_id = <string>
  config.bazaar_voice_shared_key = <string>
  config.bazaar_voice_integration_type = 'Conversations'
  config.bazaar_voice_export_interval = 2.days, # Products and categories updated within this timeframe will be exported.
  config.bazaar_voice_export_enabled = false # Setting this to true will enable sFTP export of your product catalog to Bazaarvoice
  config.bazaar_voice_requires_login = true # Requires user to login to write a review (recommended)
end
```

Or, you can allow admins to configure them in the application UI.

See below for what all these configuration settings mean:

## Configuration

All configuration on Bazaar Voice can be edited by administrators as
well as developers, so devs aren't always responsible for knowing the
following information. But it's here if you need it.

### site_id

Use the 'deployment zone' found in the bazaarvoice workbench under
**Settings >> Manage Applications**, by default this is `main_site` more info here:
<https://knowledge.bazaarvoice.com/wp-content/conversations/en_US/Learn/config_hub_overview.html#deployment-zones>

### Configuration values for legacy PRR implementations

If you are on the BazaarVoice PRR implementation you will also need to specify
the following configurations:

```ruby
  config.bazaar_voice_integration_type = 'PRR'
  config.bazaar_voice_display_code = 'xxxx-en_us'
  config.bazaar_voice_hostname = 'xxx.ugc.bazaarvoice.com'
```

You may need to contact Bazaar Voice support to get the correct display_code and
hostname for your client.

### Feature configuration

Some configuration is required for the following bazaarvoice display modules:

* Rating Summary <https://knowledge.bazaarvoice.com/wp-content/conversations/en_US/Display/display_integration.html#rating-summary>
* Inline Ratings <https://knowledge.bazaarvoice.com/wp-content/conversations/en_US/Display/inline_ratings.html>
* Review highlights <https://knowledge.bazaarvoice.com/wp-content/conversations/en_US/Display/display_integration.html#review-highlights>
* Question & Answer <https://knowledge.bazaarvoice.com/wp-content/conversations/en_US/Collect/q_and_a.html#enable-and-configure-questions-and-answers>

These modules must first be enabled on your client's bazaarvoice site, otherwise
they will not work.

These display modules are configured to be enabled by default, to disable any of
these features in your application set the corresponding configuration to `false`

Example settings in configuration block:

```ruby
  config.bazaar_voice_display_rating_summary = false
  config.bazaar_voice_display_inline_ratings = false
  config.bazaar_voice_display_review_highlights = false
  config.bazaar_voice_display_questions = false
```

### Syndication

You may choose to load ratings from syndicated sources, rather than just
your website, depending on your business rules. This will load rating
data from the `ReviewStatistics` data point rather than the
default `NativeReviewStatistics` data point. To configure this option,
add the following to your Workarea initializer:

```ruby
  config.bazaar_voice_syndicated = true
```

## BV catalog feed

The Bazaar Voice catalog feed is configured to run daily at 1am. This feed is
incremental, sending products and categories that have been updated in the last
2 days. This allows for 1 day of overlap in feed data, incase the feed fails.

All feeds are uploaded to the Bazaar Voice FTP via SFTP, the Secrets configuration
section of this readme details required configuration for the upload.

To enable the feed you must set the following configruation in the enviornment.
Providing you have a staging sandbox with BV we recommend enabling this in
staging and production.

```ruby
  config.bazaar_voice_export_enabled = true
```

### Exporting Brands

Bazaar Voice feeds require a brand to be set for every product. Since Workarea
does not have a concept of brands out of the box a configuration for default brand
is available with this plugin. If your application has been customized to include
brands per product you will need to decorate the `Workarea::BazaarVoice::Export::Catalog`
class and `XmlBuilder#build_product` to pass the appropriate data in the feed. To
use the default brand set the following configuration:

```ruby
  config.bazaar_voice_default_brand_id = 'brand_id'
  config.bazaar_voice_default_brand_name = 'Brand Name'
```

### Excluding product types from export

You may want to exclude certain types of products, like packages, gift cards, or
other custom types from your product feed. The plugin provides a configuration
which accepts an array of product templates to be excluded. This logic can be
further extended by decorating `Workarea::BazaarVoice::Export::Catalog#product_excluded`
example configuration for package products:

```ruby
  config.bazaar_voice_excluded_product_templates = ['family', 'package']
```

### Initial Catalog Feed

When first setting up Bazaar Voice you will need to upload a complete feed, this
is done using a rake task. To upload your complete product feed run

```bash
bundle exec rake bazaar_voice:full_export
```

## Domain configuration

The BV Loader JS expects requests to come from a pre-defined set of domains.
You may be able to request Bazaar Voice customer service to add your development
URL to the list of allowed domains. Alternatively you can use `rails server` and
`localhost:3000` for development, which seems to be an allowed domain by default.

You will need to instruct Bazaar Voice customer service to configure your QA,
Staging, and production domains for use with your client's account.

## Roadmap

* Ingest feed from BV and store reviews in-app
* Include brands in the product feed
* Configuration option to put writing a review behind a login.

## Workarea Platform Documentation

See http://developer.workarea.com for Workarea platform documentation.

## Copyright & Licensing

Copyright Workarea 2018-2020. All rights reserved.

For licensing, contact sales@workarea.com.
