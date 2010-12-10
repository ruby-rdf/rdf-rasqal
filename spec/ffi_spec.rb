require File.join(File.dirname(__FILE__), 'spec_helper')

describe RDF::Rasqal::FFI do
  context "FFI.version" do
    it "returns a String" do
      RDF::Rasqal::FFI.version.should be_a String
    end

    it "returns a String of the form 'x.y.z'" do
      RDF::Rasqal::FFI.version.should match /^(\d+)\.(\d+)\.(\d+)$/
    end

    it "freezes the returned value" do
      RDF::Rasqal::FFI.version.should be_frozen
    end
  end
end
