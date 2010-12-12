require 'ffi'        # @see http://rubygems.org/gems/ffi
require 'rdf'        # @see http://rubygems.org/gems/rdf
require 'rdf/raptor' # @see http://rubygems.org/gems/rdf-raptor

module RDF
  module Rasqal
    autoload :VERSION,        'rdf/rasqal/version'
    autoload :FFI,            'rdf/rasqal/ffi'
    autoload :Query,          'rdf/rasqal/query'
    autoload :QueryResults,   'rdf/rasqal/query_results'
    autoload :Variable,       'rdf/rasqal/variable'
    autoload :VariablesTable, 'rdf/rasqal/variables_table'
    autoload :World,          'rdf/rasqal/world'
  end # Rasqal
end # RDF
