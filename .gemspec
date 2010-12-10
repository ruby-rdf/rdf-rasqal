#!/usr/bin/env ruby -rubygems
# -*- encoding: utf-8 -*-

Gem::Specification.new do |gem|
  gem.version            = File.read('VERSION').chomp
  gem.date               = File.mtime('VERSION').strftime('%Y-%m-%d')

  gem.name               = 'rdf-rasqal'
  gem.homepage           = 'http://rdf.rubyforge.org/rasqal/'
  gem.license            = 'Public Domain' if gem.respond_to?(:license=)
  gem.summary            = 'Rasqal RDF Query Library plugin for RDF.rb.'
  gem.description        = 'RDF.rb plugin for SPARQL query evaluation using the Rasqal RDF Query Library.'
  gem.rubyforge_project  = 'rdf'

  gem.author             = 'Arto Bendiken'
  gem.email              = 'public-rdf-ruby@w3.org'

  gem.platform           = Gem::Platform::RUBY
  gem.files              = %w(AUTHORS CREDITS README UNLICENSE VERSION) + Dir.glob('lib/**/*.rb')
  gem.bindir             = %q(bin)
  gem.executables        = %w()
  gem.default_executable = gem.executables.first
  gem.require_paths      = %w(lib)
  gem.extensions         = %w()
  gem.test_files         = %w()
  gem.has_rdoc           = false

  gem.required_ruby_version      = '>= 1.8.1'
  gem.requirements               = ['librasqal (>= 0.9.20)', 'libraptor (>= 1.4.19)']
  gem.add_runtime_dependency     'ffi',        '>= 1.0'
  gem.add_runtime_dependency     'rdf-raptor', '>= 0.3.0'
  gem.add_runtime_dependency     'rdf',        '>= 0.2.3' # FIXME
  gem.add_development_dependency 'yard' ,      '>= 0.6.0'
  gem.add_development_dependency 'rspec',      '>= 1.3.0'
  gem.add_development_dependency 'rdf-spec',   '>= 0.2.3' # FIXME
  gem.post_install_message       = nil
end
