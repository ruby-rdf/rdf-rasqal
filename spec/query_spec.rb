require File.join(File.dirname(__FILE__), 'spec_helper')

describe RDF::Rasqal::Query do
  before :all do
    World.initialize!
  end

  after :all do
    World.release
  end

  context "Query.new" do
    it "returns a new Query instance" do
      Query.new.should be_a Query
    end
  end

  before :each do
    @query = Query.new
  end

  context "Query#name" do
    it "returns a Symbol" do
      @query.name.should be_a Symbol
    end
  end

  context "Query#label" do
    it "returns a String" do
      @query.label.should be_a String
    end
  end

  context "Query#fatal_error_handler=" do
    it "returns nothing" do
      (@query.fatal_error_handler = Proc.new {}) # TODO
    end
  end

  context "Query#error_handler=" do
    it "returns nothing" do
      (@query.error_handler = Proc.new {}) # TODO
    end
  end

  context "Query#warning_handler=" do
    it "returns nothing" do
      (@query.warning_handler = Proc.new {}) # TODO
    end
  end

  context "Query#distinct?" do
    it "returns a Boolean" do
      @query.distinct?.should be_a_boolean
    end
  end

  context "Query#distinct" do
    it "returns an Integer" do
      @query.distinct.should be_an Integer
    end
  end

  context "Query#distinct=" do
    it "returns nothing" do
      # TODO
    end
  end

  context "Query#limit?" do
    it "returns a Boolean" do
      @query.limit?.should be_a_boolean
    end
  end

  context "Query#limit" do
    it "returns an Integer" do
      @query.limit.should be_an Integer
    end
  end

  context "Query#limit=" do
    it "returns nothing" do
      # TODO
    end
  end

  context "Query#offset?" do
    it "returns a Boolean" do
      @query.offset?.should be_a_boolean
    end
  end

  context "Query#offset" do
    it "returns an Integer" do
      @query.offset.should be_an Integer
    end
  end

  context "Query#offset=" do
    it "returns nothing" do
      # TODO
    end
  end

  context "Query#has_variable?" do
    it "returns a Boolean" do
      @query.has_variable?(:foobar).should be_a_boolean
    end
  end

  context "Query#prepare" do
    it "returns self" do
      @query.prepare("SELECT * WHERE { ?s ?p ?o }").should equal @query
    end
  end

  context "Query#execute" do
    it "returns a QueryResults" do
      #@query.prepare("SELECT * WHERE { ?s ?p ?o }")
      #@query.execute.should be_a QueryResults # TODO
    end
  end

  context "Query#user_data" do
    it "returns a Pointer" do
      @query.user_data.should be_an FFI::Pointer
    end
  end

  context "Query#user_data=" do
    it "returns nothing" do
      # TODO
    end
  end

  context "Query#verb" do
    it "returns a Symbol" do
      @query.verb.should be_a Symbol
    end
  end

  context "Query#verb_as_string" do
    it "returns a String" do
      @query.verb_as_string.should be_a String
    end
  end

  context "Query#wildcard?" do
    it "returns a Boolean" do
      @query.wildcard?.should be_a_boolean
    end
  end

  context "Query#explain?" do
    it "returns a Boolean" do
      @query.explain?.should be_a_boolean
    end
  end
end
