$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "fassets_core/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "fassets_core"
  s.version     = FassetsCore::VERSION
  s.authors     = ["Julian Bäume"]
  s.email       = ["julian@svg4all.de"]
  s.homepage    = "https://github.com/fassets/"
  s.summary     = "A facetted classification framework for digital assets."
  s.description = "A facetted classification framework for digital assets."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 3.1.1"
  s.add_dependency "jquery-rails"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "devise"
  s.add_development_dependency "haml"
end
