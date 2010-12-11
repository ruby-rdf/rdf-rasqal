module RDF::Rasqal
  ##
  # An FFI wrapper for the `rasqal_query_results` struct.
  class QueryResults < FFI::ManagedStruct
    include FFI
    layout :world, :pointer # the actual layout is non-public

    ##
    # @param  [FFI::Pointer] ptr
    def initialize(ptr = nil)
      world = World.initialize!
      ptr = case ptr
        when FFI::Pointer
          ptr
        when Query
          rasqal_new_query_results(world, ptr, :bindings, rasqal_new_variables_table(world))
        when nil
          rasqal_new_query_results(world, nil, :bindings, rasqal_new_variables_table(world))
        else nil
      end
      raise ArgumentError, "invalid argument: #{ptr.inspect}" if ptr.nil? || ptr.null?
      super(ptr)
    end

    ##
    # @param  [FFI::Pointer] ptr
    # @return [void]
    def self.release(ptr)
      rasqal_free_query_results(ptr)
    end

    ##
    # @return [FFI::Pointer]
    def world
      rasqal_query_results_get_world(self)
    end

    ##
    # @return [Query]
    def query
      Query.new(rasqal_query_results_get_query(self))
    end

    ##
    # @return [VariablesTable]
    def variables_table
      rasqal_query_results_get_variables_table(self) # TODO: wrap the result
    end

    ##
    # @return [Boolean] `true` or `false`
    def bindings?
      !(rasqal_query_results_is_bindings(self).zero?)
    end

    ##
    # @return [Boolean] `true` or `false`
    def boolean?
      !(rasqal_query_results_is_boolean(self).zero?)
    end

    ##  
    # @return [Boolean] `true` or `false`
    def graph?
      !(rasqal_query_results_is_graph(self).zero?)
    end

    ##
    # @return [Boolean] `true` or `false`
    def syntax?
      !(rasqal_query_results_is_syntax(self).zero?)
    end

    ##
    # @return [Integer]
    def count
      rasqal_query_results_get_count(self)
    end

    ##
    # @return [void] `self`
    def next!
      rasqal_query_results_next(self)
      return self
    end

    ##
    # @return [Boolean] `true` or `false`
    def finished?
      !(rasqal_query_results_finished(self).zero?)
    end

    ##
    # @param  [Integer, #to_i] index
    # @return [Literal]
    def binding_value(index)
      rasqal_query_results_get_binding_value(self, index.to_i) # TODO: wrap the result
    end

    ##
    # @param  [Integer, #to_i] index
    # @return [Symbol]
    def binding_name(index)
      name = rasqal_query_results_get_binding_name(self, index.to_i)
      name ? name.to_sym : nil
    end

    ##
    # @param  [Symbol, #to_sym]
    # @return [Literal]
    def binding_value_by_name(name)
      rasqal_query_results_get_binding_value_by_name(self, name.to_sym.to_s) # TODO: wrap the result
    end

    ##
    # @return [Integer]
    def bindings_count
      rasqal_query_results_get_bindings_count(self)
    end

    ##
    # @return [Statement]
    def triple
      statement = rasqal_query_results_get_triple(self)
      !(statement.null?) ? Statement.new(statement) : nil
    end

    ##
    # @return [void] `self`
    def next_triple!
      rasqal_query_results_next_triple(self)
      return self
    end

    ##
    # @return [Boolean] `true` or `false`
    def true?
      boolean.equal?(true)
    end

    ##
    # @return [Boolean] `true` or `false`
    def false?
      boolean.equal?(false)
    end

    ##
    # @return [Boolean] `true` or `false`
    def boolean
      !(rasqal_query_results_get_boolean(self).zero?)
    end

    ##
    # @param  [Row, #to_ptr] row
    # @return [void] `self`
    def add_row(row)
      rasqal_query_results_add_row(self, row.to_ptr)
      return self
    end
  end # QueryResults
end # RDF::Rasqal
