require_relative "lib/rails_upgrade_assistant/version"

Gem::Specification.new do |spec|
  spec.name        = "rails_upgrade_assistant"
  spec.version     = RailsUpgradeAssistant::VERSION
  spec.authors     = ["Ariel Juodziukynas"]
  spec.email       = ["arieljuod@gmail.com"]
  spec.homepage    = "https://example.com"
  spec.summary     = "Summary of RailsUpgradeAssistant."
  spec.description = "Description of RailsUpgradeAssistant."
  spec.license     = "MIT"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/some/repo"
  spec.metadata["changelog_uri"] = "https://github.com/some/repo/CHANGELOG.md"

  spec.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  spec.add_dependency "rails"
end
