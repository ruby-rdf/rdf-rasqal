module RDF::Rasqal
  ##
  # An FFI wrapper for the `rasqal_world` struct.
  class World < FFI::ManagedStruct
    layout :opened, :int,
           :raptor_world, :pointer

    ##
    # @return [Boolean]
    def self.initialized?
      !(Thread.current[:rasqal_world].nil?)
    end

    ##
    # @return [World]
    def self.initialize!
      Thread.current[:rasqal_world] ||= self.new
    end

    ##
    # @param  [FFI::Pointer] ptr
    def initialize(ptr = nil)
      super(ptr || FFI.rasqal_new_world())
    end

    ##
    # @param  [FFI::Pointer] ptr
    # @return [void]
    def self.release(ptr)
      FFI.rasqal_free_world(self)
    end

    ##
    # @param  [FFI::Pointer] ptr
    #   a pointer to a `raptor_world` struct
    def raptor=(ptr)
      FFI.rasqal_world_set_raptor(self, ptr)
    end

    ##
    # @return [FFI::Pointer]
    #   a pointer to a `raptor_world` struct
    def raptor
      FFI.rasqal_world_get_raptor(self) # TODO: return an RDF::Raptor::World instance
    end

    ##
    # @return [void] `self`
    def open!
      FFI.rasqal_world_open(self)
      return self
    end
  end # World
end # RDF::Rasqal
