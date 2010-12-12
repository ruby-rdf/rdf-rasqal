module RDF::Rasqal
  ##
  # An FFI wrapper for the `rasqal_variables_table` struct.
  class VariablesTable < FFI::Struct
    include FFI
    layout :world, :pointer # the actual layout is non-public

    ##
    # @param  [FFI::Pointer] ptr
    def initialize(ptr = nil)
      case ptr
        when FFI::Pointer
          ptr
        when nil
          ptr = rasqal_new_variables_table(World.initialize!)
          super(AutoPointer.new(ptr, self.class.method(:release)))
        else
          raise ArgumentError, "invalid argument: #{ptr.inspect}"
      end
    end

    ##
    # @param  [FFI::Pointer] ptr
    # @return [void]
    def self.release(ptr)
      rasqal_free_variables_table(ptr)
    end

    ##
    # @return [VariablesTable] a copy of `self`
    def clone
      copy = self.class.new(rasqal_new_variables_table_from_variables_table(self))
      copy.taint  if tainted?
      copy.freeze if frozen?
      copy
    end

    ##
    # @return [VariablesTable] a copy of `self`
    def dup
      copy = self.class.new(rasqal_new_variables_table_from_variables_table(self))
      copy.taint if tainted?
      copy
    end

    ##
    # @param  [Symbol, #to_sym] type
    # @param  [Symbol, #to_sym] name
    # @param  [Literal, #to_ptr] value
    # @return [Variable]
    def add(type, name, value)
      var = rasqal_variables_table_add(self, type.to_sym, name.to_sym.to_s, value ? value.to_ptr : nil)
      !(var.null?) ? Variable.new(var) : nil
    end

    ##
    # @param  [Integer, #to_i] index
    # @return [Variable]
    def get(index)
      var = rasqal_variables_table_get(self, index.to_i)
      !(var.null?) ? Variable.new(var) : nil
    end
    alias_method :[], :get

    ##
    # @param  [Integer, #to_i] index
    # @return [Literal]
    def get_value(index)
      literal = rasqal_variables_table_get_value(self, index.to_i)
      !(literal.null?) ? literal : nil # TODO: wrap the result
    end

    ##
    # @param  [Symbol, #to_sym] name
    # @return [Variable]
    def get_by_name(name)
      var = rasqal_variables_table_get_by_name(self, name.to_sym.to_s)
      !(var.null?) ? Variable.new(var) : nil
    end

    ##
    # @param  [Symbol, #to_sym] name
    # @return [Boolean] `true` or `false`
    def has?(name)
      !(rasqal_variables_table_has(self, name.to_sym.to_s).zero?)
    end

    ##
    # @param  [Symbol, #to_sym] name
    # @param  [Literal, #to_ptr] value
    # @return [void]
    def set(name, value)
      rasqal_variables_table_set(self, name.to_sym.to_s, value ? value.to_ptr : nil)
    end
    alias_method :[]=, :set

    ##
    # @return [Integer]
    def named_variables_count
      rasqal_variables_table_get_named_variables_count(self)
    end

    ##
    # @return [Integer]
    def anonymous_variables_count
      rasqal_variables_table_get_anonymous_variables_count(self)
    end

    ##
    # @return [Integer]
    def total_variables_count
      rasqal_variables_table_get_total_variables_count(self)
    end

    ##
    # @return [Sequence]
    def named_variables_sequence
      seq = rasqal_variables_table_get_named_variables_sequence(self)
      !(seq.null?) ? seq : nil # TODO: wrap the result
    end

    ##
    # @return [Sequence]
    def anonymous_variables_sequence
      rasqal_variables_table_get_anonymous_variables_sequence(self)
      !(seq.null?) ? seq : nil # TODO: wrap the result
    end
  end # VariablesTable
end # RDF::Rasqal
