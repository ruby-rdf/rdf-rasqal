require File.join(File.dirname(__FILE__), 'spec_helper')

describe RDF::Rasqal::VariablesTable do
  before :all do
    World.initialize!
  end

  after :all do
    World.release
  end

  context "VariablesTable.new" do
    it "returns a new VariablesTable instance" do
      VariablesTable.new.should be_a VariablesTable
    end
  end

  before :each do
    @table = VariablesTable.new
  end

  context "VariablesTable#add" do
    it "returns a Variable" do
      @table.add(:anonymous, :foobar, nil) # TODO
    end
  end

  context "VariablesTable#get" do
    it "returns a Variable" do
      @table.get(0) # TODO
    end
  end

  context "VariablesTable#get_value" do
    it "returns a Literal" do
      @table.get_value(0) # TODO
    end
  end

  context "VariablesTable#get_by_name" do
    it "returns a Variable" do
      @table.get_by_name(:foobar) # TODO
    end
  end

  context "VariablesTable#has?" do
    it "returns a Boolean" do
      @table.has?(:foobar) # TODO
    end
  end

  context "VariablesTable#set" do
    it "returns nothing" do
      @table.set(:foobar, nil) # TODO
    end
  end

  context "VariablesTable#named_variables_count" do
    it "returns an Integer" do
      @table.named_variables_count.should be_an Integer
    end
  end

  context "VariablesTable#anonymous_variables_count" do
    it "returns an Integer" do
      @table.anonymous_variables_count.should be_an Integer
    end
  end

  context "VariablesTable#total_variables_count" do
    it "returns an Integer" do
      @table.total_variables_count.should be_an Integer
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
