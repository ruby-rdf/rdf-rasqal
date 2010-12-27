require 'rdf/rasqal'
require 'rdf/spec'

RSpec.configure do |config|
  config.include(RDF::Spec::Matchers)
  config.exclusion_filter = {:ruby => lambda { |version|
    RUBY_VERSION.to_s !~ /^#{version}/
  }}
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
