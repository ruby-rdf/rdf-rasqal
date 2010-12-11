require 'rdf/rasqal'
require 'rdf/spec'

Spec::Runner.configure do |config|
  config.include(RDF::Spec::Matchers)
end

include RDF::Rasqal

class Object
  def boolean?() false end
end

class TrueClass
  def boolean?() true end
end

class FalseClass
  def boolean?() true end
end
