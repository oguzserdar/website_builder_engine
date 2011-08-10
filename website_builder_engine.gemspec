# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require File.dirname(__FILE__) + "/version"

Gem::Specification.new do |s|
  s.name        = "website_builder_engine"
  s.version     = WebsiteBuilderEngine::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Daniel Kehoe"]
  s.email       = ["daniel@danielkehoe.com"]
  s.homepage    = "https://github.com/DanielKehoe/website_builder_engine"
  s.summary     = "Rails 3.1 engine generates static HTML5 webpages."
  s.description = "Add this engine to any Rails 3.1 app and create static webpages from data added through a form."
  
  s.rubyforge_project = "website_builder_engine"
  
  s.add_dependency "haml"
  s.add_dependency "bson_ext"
  s.add_dependency "mongoid"
  s.add_dependency "RedCloth"
  s.add_dependency "bourbon"
  s.add_dependency "html2textile"
  s.add_dependency "frontend-helpers"
  
  s.add_development_dependency "rspec", "~> 2.6"
  
  s.files         = `git ls-files`.split("\n")
  s.test_files    = Dir["spec/**/*"] 
  s.executables   = `git ls-files`.split("\n").map{|f| f =~ /^bin\/(.*)/ ? $1 : nil}.compact
  s.require_path  = 'lib'
end