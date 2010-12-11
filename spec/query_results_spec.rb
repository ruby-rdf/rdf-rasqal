require File.join(File.dirname(__FILE__), 'spec_helper')

describe RDF::Rasqal::QueryResults do
  before :all do
    World.initialize!
  end

  after :all do
    World.release
  end

  context "QueryResults.new" do
    it "returns a new QueryResults instance" do
      QueryResults.new.should be_a QueryResults
    end
  end

  before :each do
    @results = QueryResults.new
  end

  context "QueryResults#world" do
    it "returns a World" do
      @results.world.should be_a World
    end
  end

  context "QueryResults#query" do
    it "returns a Query" do
      @results.query.should be_a Query
    end
  end

  context "QueryResults#variables_table" do
    it "returns a VariablesTable" do
      @results.variables_table.should be_a VariablesTable
    end
  end

  context "QueryResults#bindings?" do
    it "returns a Boolean" do
      @results.bindings?.should be_a_boolean
    end
  end

  context "QueryResults#boolean?" do
    it "returns a Boolean" do
      @results.boolean?.should be_a_boolean
    end
  end

  context "QueryResults#graph?" do
    it "returns a Boolean" do
      @results.graph?.should be_a_boolean
    end
  end

  context "QueryResults#syntax?" do
    it "returns a Boolean" do
      @results.syntax?.should be_a_boolean
    end
  end

  context "QueryResults#count" do
    it "returns an Integer" do
      @results.count.should be_an Integer
    end
  end

  context "QueryResults#next!" do
    it "returns self" do
      @results.next!.should equal @results
    end
  end

  context "QueryResults#finished?" do
    it "returns a Boolean" do
      @results.finished?.should be_a_boolean
    end
  end

  context "QueryResults#binding_value" do
    it "returns a Literal" do
      @results.binding_value(0) # TODO
    end
  end

  context "QueryResults#binding_name" do
    it "returns a Symbol" do
      @results.binding_name(0) # TODO
    end
  end

  context "QueryResults#binding_value_by_name" do
    it "returns a Literal" do
      @results.binding_value_by_name(:foobar) # TODO
    end
  end

  context "QueryResults#bindings_count" do
    it "returns an Integer" do
      @results.bindings_count.should be_an Integer
    end
  end

  context "QueryResults#triple" do
    it "returns a Statement" do
      @results.triple # TODO
    end
  end

  context "QueryResults#next_triple!" do
    it "returns self" do
      @results.next_triple! # TODO
    end
  end

  context "QueryResults#true?" do
    it "returns a Boolean" do
      @results.true?.should be_a_boolean
    end
  end

  context "QueryResults#false?" do
    it "returns a Boolean" do
      @results.false?.should be_a_boolean
    end
  end

  context "QueryResults#boolean" do
    it "returns a Boolean" do
      @results.boolean.should be_a_boolean
    end
  end

  context "QueryResults#add_row" do
    it "returns self" do
      # TODO
    end
  end
end
