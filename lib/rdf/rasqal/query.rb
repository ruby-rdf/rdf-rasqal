module RDF::Rasqal
  ##
  # An FFI wrapper for the `rasqal_query` struct.
  class Query < FFI::Struct
    include FFI
    layout :world, :pointer # the actual layout is non-public

    ##
    # @param  [FFI::Pointer] ptr
    def initialize(ptr = nil)
      case ptr
        when FFI::Pointer
          super(ptr)
        when nil
          ptr = rasqal_new_query(World.initialize!, 'sparql', nil)
          super(AutoPointer.new(ptr, self.class.method(:release)))
        else
          raise ArgumentError, "invalid argument: #{ptr.inspect}"
      end
    end

    ##
    # @param  [FFI::Pointer] ptr
    # @return [void]
    def self.release(ptr)
      rasqal_free_query(ptr)
    end

    ##
    # @return [Symbol]
    def name
      rasqal_query_get_name(self).to_sym
    end

    ##
    # @return [String]
    def label
      rasqal_query_get_name(self)
    end

    ##
    # @param  [Proc, #to_proc] handler
    #   the new fatal error handler callback
    # @return [void]
    def fatal_error_handler=(handler)
      rasqal_query_set_fatal_error_handler(self, self, handler.to_proc)
    end

    ##
    # @param  [Proc, #to_proc] handler
    #   the new error handler callback
    # @return [void]
    def error_handler=(handler)
      rasqal_query_set_error_handler(self, self, handler.to_proc)
    end

    ##
    # @param  [Proc, #to_proc] handler
    #   the new warning handler callback
    # @return [void]
    def warning_handler=(handler)
      rasqal_query_set_warning_handler(self, self, handler.to_proc)
    end

    ##
    # @return [Boolean] `true` or `false`
    def distinct?
      !(distinct.zero?)
    end

    ##
    # @return [Integer] `0`, `1`, or `2`
    def distinct
      rasqal_query_get_distinct(self)
    end

    ##
    # @param  [Integer, #to_i] mode
    # @return [void]
    def distinct=(mode)
      rasqal_query_set_distinct(self, mode.to_i) # FIXME: support booleans
    end

    ##
    # @return [Boolean] `true` or `false`
    def limit?
      limit >= 0
    end

    ##
    # @return [Integer]
    def limit
      rasqal_query_get_limit(self)
    end

    ##
    # @param  [Integer, #to_i] limit
    # @return [void]
    def limit=(limit)
      rasqal_query_set_limit(self, limit.to_i)
    end

    ##
    # @return [Boolean] `true` or `false`
    def offset?
      offset >= 0
    end

    ##
    # @return [Integer]
    def offset
      rasqal_query_get_offset(self)
    end

    ##
    # @param  [Integer, #to_i] offset
    # @return [void]
    def offset=(offset)
      rasqal_query_set_offset(self, offset.to_i)
    end

    ##
    # @param  [Symbol, #to_sym] var
    # @return [Boolean] `true` or `false`
    def has_variable?(var)
      !(rasqal_query_has_variable(self, var.to_sym.to_s).zero?)
    end

    ##
    # @param  [String, #to_s] query_string
    # @param  [Hash{Symbol => Object}] options
    # @option options [String, #to_s] :base_uri (nil)
    # @return [void] `self`
    def prepare(query_string, options = {})
      base_uri = options[:base_uri] ? RDF::Raptor::FFI::V1_4::URI.new(options[:base_uri].to_s) : nil
      result = rasqal_query_prepare(self, query_string.to_s, base_uri)
      # TODO: raise an error if result.nonzero?
      return self
    end

    ##
    # @return [QueryResults]
    def execute(&block)
      results = rasqal_query_execute(self)
      results = !(results.null?) ? QueryResults.new(results) : nil
      block_given? ? block.call(results) : results
    end

    ##
    # @return [FFI::Pointer]
    def user_data
      rasqal_query_get_user_data(self)
    end

    ##
    # @param  [FFI::Pointer] ptr
    # @return [void]
    def user_data=(ptr)
      rasqal_query_set_user_data(self, ptr.to_ptr)
    end

    ##
    # @return [Symbol]
    def verb
      rasqal_query_get_verb(self)
    end

    ##
    # @return [String]
    def verb_as_string
      rasqal_query_verb_as_string(verb)
    end

    ##
    # @return [Boolean] `true` or `false`
    def wildcard?
      !(rasqal_query_get_wildcard(self).zero?)
    end

    ##
    # @return [Boolean] `true` or `false`
    def explain?
      !(rasqal_query_get_explain(self).zero?)
    end
  end # Query
end # RDF::Rasqal
