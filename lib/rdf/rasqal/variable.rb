module RDF::Rasqal
  ##
  # An FFI wrapper for the `rasqal_variable` struct.
  class Variable < FFI::Struct
    include FFI
    layout :vars_table, :pointer,
           :name, :string,
           :value, :pointer

    ##
    # @param  [FFI::Pointer] ptr
    def initialize(*args)
      case args.length
        when 1 then case ptr = args.first
          when FFI::Pointer
            ptr
          else
            raise ArgumentError, "invalid argument: #{ptr.inspect}"
        end
        when 2
          query, name = args
          ptr = rasqal_new_variable(query.to_ptr, name.to_s, nil)
          super(AutoPointer.new(ptr, self.class.method(:release)))
        when 3
          query, name, value = args
          ptr = rasqal_new_variable(query.to_ptr, name.to_s, value ? value.to_ptr : nil)
          super(AutoPointer.new(ptr, self.class.method(:release)))
        else
          raise ArgumentError, "wrong number of arguments (#{args.length} for 3)"
      end
    end

    ##
    # @param  [FFI::Pointer] ptr
    # @return [void]
    def self.release(ptr)
      rasqal_free_variable(ptr)
    end

    ##
    # @return [Variable] a copy of `self`
    def clone
      copy = self.class.new(rasqal_new_variable_from_variable(self))
      copy.taint  if tainted?
      copy.freeze if frozen?
      copy
    end

    ##
    # @return [Variable] a copy of `self`
    def dup
      copy = self.class.new(rasqal_new_variable_from_variable(self))
      copy.taint if tainted?
      copy
    end

    ##
    # @return [VariablesTable]
    attr_reader :variables_table
    def variables_table
      vars = self[:vars_table]
      vars ? VariablesTable.new(vars) : nil
    end
    alias_method :vars_table, :variables_table

    ##
    # @return [Symbol]
    attr_reader :name
    def name
      name = self[:name]
      name ? name.to_sym : nil
    end

    ##
    # @return [Literal]
    attr_reader :value
    def value
      value = self[:value]
      !(value.null?) ? value : nil # TODO: wrap the result
    end

    ##
    # @param  [Literal, #to_ptr] literal
    # @return [void]
    def value=(literal)
      rasqal_variable_set_value(self, literal ? literal.to_ptr : nil)
    end
  end # Variable
end # RDF::Rasqal
