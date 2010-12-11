module RDF::Rasqal
  ##
  # An FFI wrapper for the `rasqal_world` struct.
  class World < FFI::Struct
    include FFI
    layout :opened, :int, # the actual layout is non-public
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
      case ptr
        when FFI::Pointer
          super(ptr)
        when nil
          ptr = rasqal_new_world()
          super(AutoPointer.new(ptr, self.class.method(:release)))
        else
          raise ArgumentError, "invalid argument: #{ptr.inspect}"
      end
    end

    ##
    # @param  [FFI::Pointer] ptr
    # @return [void]
    def self.release(ptr = false)
      if ptr.eql?(false)
        Thread.current[:rasqal_world] = nil
      else
        rasqal_free_world(ptr)
      end
    end

    ##
    # @param  [FFI::Pointer] ptr
    #   a pointer to a `raptor_world` struct
    def raptor=(ptr)
      rasqal_world_set_raptor(self, ptr)
    end

    ##
    # @return [FFI::Pointer]
    #   a pointer to a `raptor_world` struct
    def raptor
      rasqal_world_get_raptor(self) # TODO: return an RDF::Raptor::World instance
    end

    ##
    # @return [void] `self`
    def open!
      rasqal_world_open(self)
      return self
    end
  end # World
end # RDF::Rasqal
