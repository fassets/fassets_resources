$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "fassets_resources/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "fassets_resources"
  s.version     = FassetsResources::VERSION
  s.authors     = ["Julian Bäume", "Christopher Sharp"]
  s.email       = ["julian@svg4all.de", "cdsharp@gmail.com"]
  s.homepage    = "https://github.com/fassets/"
  s.summary     = "Resources plugin for a facetted classification framework for digital assets."
  s.description = "Resources plugin for a facetted classification framework for digital assets."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.md"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 3.1.1"
  s.add_dependency "fassets_core", "~> 0.3.1"
  s.add_dependency "jquery-rails"
  s.add_dependency "haml"
  s.add_dependency "sqlite3"
  s.add_dependency "mime-types"
  s.add_dependency "carrierwave"
  s.add_dependency "mini_magick"
  s.add_dependency "streamio-ffmpeg"
  s.add_dependency "fancybox-rails"
  s.add_dependency "wikipedia-client"
  s.add_dependency "jquery-fileupload-rails"

  s.add_development_dependency "devise"
  s.add_development_dependency "guard-rspec"
  s.add_development_dependency "guard-spork"
  s.add_development_dependency "rspec-rails"
end
