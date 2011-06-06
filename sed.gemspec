# -*- encoding: utf-8 -*-
require File.expand_path("../lib/sed/version", __FILE__)

Gem::Specification.new do |s|
  s.name        = "sed"
  s.version     = Sed::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Fernando Guillen (http://fernandoguillen.info)"]
  s.email       = ["fguillen.mail@gmail.com"]
  s.homepage    = "https://github.com/fguillen/SedWrapper"
  s.summary     = "Wrapper for the Unix shell command `sed`"
  s.description = "Use the `sed` command from Ruby code"

  s.required_rubygems_version = ">= 1.3.6"
  s.rubyforge_project         = "sed"

  s.add_development_dependency "bundler", ">= 1.0.0.rc.6"

  s.files        = `git ls-files`.split("\n")
  s.executables  = `git ls-files`.split("\n").map{|f| f =~ /^bin\/(.*)/ ? $1 : nil}.compact
  s.require_path = 'lib'
end
