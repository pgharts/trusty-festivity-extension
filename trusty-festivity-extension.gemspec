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

  s.add_dependency "trusty-cms"                   , '>= 2.0.20'
  s.add_dependency "trusty-clipped-extension"     , "~> 2.0.13"
  s.add_dependency "trusty-snippets-extension"    , "~> 2.0.7"
  s.add_dependency "trusty-reorder-extension"     , "~> 2.0.6"
  s.add_dependency "trusty-layouts-extension"     , "~> 2.0.4"
  s.add_dependency "trusty-rad-social-extension"  , "~> 2.2.3"
  s.add_dependency "trusty-multi-site-extension"  , "~> 2.0.11"
  s.add_dependency 'actionpack-action_caching'    , '~> 1.1.1'
  s.add_dependency 'dalli-elasticache'            ,'~> 0.1.2'
  s.add_dependency 'instagram'                    , '~> 1.1'
  s.add_dependency 'twitter'                      , '~> 5.15'
  s.add_dependency 'immutable-struct'             , '~> 2.1'
  s.add_dependency 'chronic'                      , '~> 0.10.2'

  s.add_dependency 'trusty_google_custom_search'
  s.add_dependency 'fog'                          , "~> 1.26"

end
