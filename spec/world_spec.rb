require File.join(File.dirname(__FILE__), 'spec_helper')

describe RDF::Rasqal::World do
  context "World.initialized?" do
    it "returns a Boolean" do
      World.initialized?.should be_a_boolean
    end
  end

  context "World.initialize!" do
    it "initializes a thread-local World instance" do
      Thread.current[:rasqal_world].should be_nil
      World.initialize!
      Thread.current[:rasqal_world].should_not be_nil
    end

    it "returns the thread-local World instance" do
      World.initialize!.should be_a World
    end
  end

  context "World.new" do
    it "returns a new World instance" do
      World.new.should be_a World
    end
  end

  context "World#open!" do
    it "returns self" do
      @world = World.initialize!
      @world.open!.should equal @world
    end
  end

  context "World#raptor=" do
    # TODO
  end

  context "World#raptor" do
    it "returns a Pointer" do
      @world = World.initialize!
      @world.raptor.should be_an FFI::Pointer
    end
  end
end
