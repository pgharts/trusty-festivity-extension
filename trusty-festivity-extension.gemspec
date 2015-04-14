# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "trusty-festivity-extension"

Gem::Specification.new do |s|
  s.name        = "trusty-festivity-extension"
  s.version     = TrustyFestivityExtension::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = TrustyFestivityExtension::AUTHORS
  s.email       = TrustyFestivityExtension::EMAIL
  s.homepage    = TrustyFestivityExtension::URL
  s.summary     = TrustyFestivityExtension::SUMMARY
  s.description = TrustyFestivityExtension::DESCRIPTION

  ignores = if File.exist?('.gitignore')
    File.read('.gitignore').split("\n").inject([]) {|a,p| a + Dir[p] }
  else
    []
  end
  s.files         = Dir['**/*'] - ignores
  s.test_files    = Dir['test/**/*','spec/**/*','features/**/*'] - ignores
  # s.executables   = Dir['bin/*'] - ignores
  s.require_paths = ["lib"]

  s.add_dependency "trusty-cms"                   , "~> 1.2"
  s.add_dependency "trusty-clipped-extension"     , "~> 1.1"
  s.add_dependency "trusty-snippets-extension"    , "~> 1.1"
  s.add_dependency "trusty-reorder-extension"     , "~> 1.1"
  s.add_dependency "trusty-layouts-extension"     , "~> 1.1"
  s.add_dependency "trusty-rad-social-extension"  , "~> 1.1"
  s.add_dependency "trusty-multi-site-extension"  , "~> 1.2"
  s.add_dependency 'dalli-elasticache'            ,'~> 0.1.2'

  s.add_dependency 'trusty_google_custom_search'
  s.add_dependency 'fog'                          , "~> 1.26"

end
