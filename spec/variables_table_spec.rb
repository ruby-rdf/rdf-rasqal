require File.join(File.dirname(__FILE__), 'spec_helper')

describe RDF::Rasqal::VariablesTable do
  before(:all) { World.initialize! }
  after(:all)  { World.release }

  context "VariablesTable.new" do
    it "returns a new VariablesTable instance" do
      VariablesTable.new.should be_a VariablesTable
    end
  end

  before :each do
    @vars = VariablesTable.new
  end

  context "VariablesTable#clone" do
    it "returns a new VariablesTable copy" do
      copy = @vars.clone
      copy.should be_a VariablesTable
      copy.should_not equal @vars
    end
  end

  context "VariablesTable#dup" do
    it "returns a new VariablesTable copy" do
      copy = @vars.dup
      copy.should be_a VariablesTable
      copy.should_not equal @vars
    end
  end

  context "VariablesTable#add" do
    it "returns a Variable" do
      @vars.add(:anonymous, :foobar, nil).should be_a Variable
    end
  end

  context "VariablesTable#get" do
    it "returns a Variable" do
      @vars.add(:anonymous, :foobar, nil)
      @vars.get(0).should be_a Variable
    end
  end

  context "VariablesTable#get_value" do
    it "returns a Literal" do
      @vars.add(:anonymous, :foobar, nil)
      @vars.get_value(0) # TODO
    end
  end

  context "VariablesTable#get_by_name" do
    it "returns a Variable" do
      @vars.add(:anonymous, :foobar, nil)
      @vars.get_by_name(:foobar).should be_a Variable
    end
  end

  context "VariablesTable#has?" do
    it "returns a Boolean" do
      @vars.has?(:foobar).should be_a_boolean
    end
  end

  context "VariablesTable#set" do
    it "returns nothing" do
      @vars.set(:foobar, nil) # TODO
    end
  end

  context "VariablesTable#named_variables_count" do
    it "returns an Integer" do
      @vars.named_variables_count.should be_an Integer
    end
  end

  context "VariablesTable#anonymous_variables_count" do
    it "returns an Integer" do
      @vars.anonymous_variables_count.should be_an Integer
    end
  end

  context "VariablesTable#total_variables_count" do
    it "returns an Integer" do
      @vars.total_variables_count.should be_an Integer
    end
  end

  context "VariablesTable#named_variables_sequence" do
    it "returns a Sequence" do
      # TODO
    end
  end

  context "VariablesTable#anonymous_variables_sequence" do
    it "returns a Sequence" do
      # TODO
    end
  end
end
