Workarea::Configuration.define_fields do
  fieldset 'Bazaar Voice' do
    field 'Client Name',
      type: :string,
      description: 'Client Name provided to you by Bazaar Voice'

    field 'Site ID',
      type: :string,
      description: %(
        Site ID provided to you by Bazaar Voice. This can be found in
        the Bazaar Voice Workbench, under "Settings >> Manage Applications".
      ).squish

    field 'Shared Key',
      type: :string,
      description: 'A shared secret for tokenizing users on Bazaar Voice.'

    field 'Integration Type',
      type: :string,
      default: 'Conversations',
      description: %(
        Type of integration to use, this is where you choose the newer
        "Conversations" or legacy "PRR" implementation. This value must
        be set to "PRR" or "Conversations".
      ).squish

    field 'Display Code',
      type: :string,
      description: %(
        Display Code provided to you by Bazaar Voice. This is for Legacy
        PRR implementations.
      ).squish

    field 'Hostname',
      type: :string,
      description: %(
        API hostname to connect to. This is for Legacy PRR
        implementations.
      ).squish

    field 'Requires Login',
      type: :boolean,
      description: 'Require login to post reviews and ratings'

    field 'Display Rating Summary',
      type: :boolean,
      default: true,
      description: %(
        Render the "Rating Summary" display module from Bazaar Voice on
        the product detail page.
      ).squish

    field 'Display Review Highlights',
      type: :boolean,
      default: true,
      description: %(
        Render the "Review Highlights" display module from Bazaar Voice
        on the product detail page.
      ).squish

    field 'Display Questions',
      type: :boolean,
      default: true,
      description: %(
        Render the "Questions & Answers" display module from Bazaar
        Voice on the product detail page.
      ).squish

    field 'Excluded Product Templates',
      type: :array,
      default: [],
      description: %(
        Prevent showing Bazaar Voice display modules on these templates.
      ).squish

    field 'Export Enabled',
      type: :boolean,
      default: false,
      description: %(
        Send exports back to Bazaar Voice if your site supports review
        entry.
      ).squish

    field 'Export Interval',
      type: :duration,
      default: 2.days,
      description: %(
        Length of time between when data will be exported to Bazaar
        Voice.
      ).squish

    field 'Include Syndicated Ratings',
      type: :boolean,
      default: false,
      description: %(
        Whether to import syndicated ratings/reviews from all
        of your retail channels, or limit to just from the website.
        This decides whether to use the "NativeReviewStatistics" or
        "ReviewStatistics" data point from the API.
      ).squish
  end
end
