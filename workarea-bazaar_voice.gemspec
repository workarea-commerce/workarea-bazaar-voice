$:.push File.expand_path("lib", __dir__)

# Maintain your gem's version:
require "workarea/bazaar_voice/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "workarea-bazaar_voice"
  s.version     = Workarea::BazaarVoice::VERSION
  s.authors     = ["Jake Beresford"]
  s.email       = ["jberesford@weblinc.com"]
  s.homepage    = "https://stash.tools.weblinc.com/projects/WP/repos/workarea-bazaar-voice/browse"
  s.summary     = "BazaarVoice integration for the Workarea ecommerce platform."
  s.description = "BazaarVoice is a 3rd party Reviews system"

  s.files = `git ls-files`.split("\n")

  s.add_dependency "workarea", ">= 3.5.0"
end
