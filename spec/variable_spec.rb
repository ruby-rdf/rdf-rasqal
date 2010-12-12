require File.join(File.dirname(__FILE__), 'spec_helper')

describe RDF::Rasqal::Variable do
  before(:all) { World.initialize! }
  after(:all)  { World.release }

  context "Variable.new" do
    it "returns a new Variable instance" do
      Variable.new(Query.new, :foobar).should be_a Variable
    end
  end

  before :each do
    @var = Variable.new(Query.new, :foobar)
  end

  context "Variable#clone" do
    it "returns a new Variable copy" do
      copy = @var.clone
      copy.should be_a Variable
      copy.should_not equal @var
    end
  end

  context "Variable#dup" do
    it "returns a new Variable copy" do
      copy = @var.dup
      copy.should be_a Variable
      copy.should_not equal @var
    end
  end

  context "Variable#variables_table" do
    it "returns a VariablesTable" do
      @var.variables_table.should be_a VariablesTable
    end
  end

  context "Variable#name" do
    it "returns a Symbol" do
      @var.name.should be_a Symbol
    end

    it "returns the variable name" do
      @var.name.should eql :foobar
    end
  end

  context "Variable#value" do
    it "returns a Literal" do
      #@var.value.should be_a Literal # TODO
    end

    it "returns the variable value" do
      @var.value.should be_nil
    end
  end

  context "Variable#value=" do
    it "returns nothing" do; end
  end
end
