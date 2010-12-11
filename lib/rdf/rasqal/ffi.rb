module RDF::Rasqal
  ##
  # A foreign-function interface (FFI) to `librasqal`.
  #
  # @see http://librdf.org/rasqal/api/
  # @see http://librdf.org/rasqal/librasqal.html
  module FFI
    ##
    # Returns the installed `librasqal` version number, or `nil` if
    # `librasqal` is not available.
    #
    # @example
    #   RDF::Rasqal::FFI.version  #=> "0.9.20"
    #
    # @return [String] an "x.y.z" version string
    def version
      [FFI.rasqal_version_major,
       FFI.rasqal_version_minor,
       FFI.rasqal_version_release].join('.').freeze
    end
    module_function :version

    include ::FFI
    extend Library
    ffi_lib 'librasqal'

    attach_variable :rasqal_version_major, :int
    attach_variable :rasqal_version_minor, :int
    attach_variable :rasqal_version_release, :int
    attach_variable :rasqal_version_decimal, :int

    # TODO: these should be inherited from `RDF::Raptor::FFI::V1`
    typedef :pointer, :raptor_sequence
    typedef :pointer, :raptor_uri
    typedef :pointer, :raptor_iostream
    typedef :pointer, :raptor_locator
    callback :raptor_message_handler, [:pointer, :raptor_locator, :string], :void

    typedef :pointer, :rasqal_world
    typedef :pointer, :rasqal_query
    typedef :pointer, :rasqal_query_results
    typedef :pointer, :rasqal_prefix
    typedef :pointer, :rasqal_variable
    typedef :pointer, :rasqal_literal
    typedef :pointer, :rasqal_triple
    typedef :pointer, :rasqal_graph_pattern
    typedef :pointer, :rasqal_data_graph
    typedef :pointer, :rasqal_expression
    enum :rasqal_query_verb, [:unknown, :select, :construct, :describe, :ask, :delete, :insert, :update]
    callback :rasqal_generate_bnodeid_handler, [:rasqal_query, :pointer, :string], :string
    callback :rasqal_generate_bnodeid_handler2, [:rasqal_world, :pointer, :string], :string # librasqal 0.9.20+

    attach_function :rasqal_new_world, [], :rasqal_world
    attach_function :rasqal_free_world, [:rasqal_world], :void
    attach_function :rasqal_world_set_raptor, [:rasqal_world, :pointer], :void
    attach_function :rasqal_world_get_raptor, [:rasqal_world] , :pointer
    attach_function :rasqal_world_open, [:rasqal_world], :int
    begin
      attach_function :rasqal_world_set_default_generate_bnodeid_parameters, [:rasqal_world, :string, :int], :void                    # librasqal 0.9.20+
      attach_function :rasqal_world_set_generate_bnodeid_handler, [:rasqal_world, :pointer, :rasqal_generate_bnodeid_handler2], :void # librasqal 0.9.20+
    rescue FFI::NotFoundError
    end

    attach_function :rasqal_new_query, [:rasqal_world, :string, :pointer], :rasqal_query
    attach_function :rasqal_free_query, [:rasqal_query], :void
    attach_function :rasqal_query_get_name, [:rasqal_query], :string
    attach_function :rasqal_query_get_label, [:rasqal_query], :string
    attach_function :rasqal_query_set_fatal_error_handler, [:rasqal_query, :pointer, :raptor_message_handler], :void
    attach_function :rasqal_query_set_error_handler, [:rasqal_query, :pointer, :raptor_message_handler], :void
    attach_function :rasqal_query_set_warning_handler, [:rasqal_query, :pointer, :raptor_message_handler], :void
    attach_function :rasqal_query_get_distinct, [:rasqal_query], :int
    attach_function :rasqal_query_set_distinct, [:rasqal_query, :int], :void
    attach_function :rasqal_query_get_limit, [:rasqal_query], :int
    attach_function :rasqal_query_set_limit, [:rasqal_query, :int], :void
    attach_function :rasqal_query_get_offset, [:rasqal_query], :int
    attach_function :rasqal_query_set_offset, [:rasqal_query, :int], :void
    attach_function :rasqal_query_add_variable, [:rasqal_query, :rasqal_variable], :int
    attach_function :rasqal_query_get_bound_variable_sequence, [:rasqal_query], :raptor_sequence
    attach_function :rasqal_query_get_all_variable_sequence, [:rasqal_query], :raptor_sequence
    attach_function :rasqal_query_get_variable, [:rasqal_query, :int], :rasqal_variable
    attach_function :rasqal_query_get_anonymous_variable_sequence, [:rasqal_query], :raptor_sequence
    attach_function :rasqal_query_has_variable, [:rasqal_query, :string], :int
    attach_function :rasqal_query_set_variable, [:rasqal_query, :string, :rasqal_literal], :int
    attach_function :rasqal_query_get_triple_sequence, [:rasqal_query], :raptor_sequence
    attach_function :rasqal_query_get_triple, [:rasqal_query, :int], :rasqal_triple
    attach_function :rasqal_query_add_prefix, [:rasqal_query, :rasqal_prefix], :int
    attach_function :rasqal_query_get_prefix_sequence, [:rasqal_query], :raptor_sequence
    attach_function :rasqal_query_get_prefix, [:rasqal_query, :int], :rasqal_prefix
    attach_function :rasqal_query_get_graph_pattern_sequence, [:rasqal_query], :raptor_sequence
    attach_function :rasqal_query_get_graph_pattern, [:rasqal_query, :int], :rasqal_graph_pattern
    attach_function :rasqal_query_print, [:rasqal_query, :pointer], :void
    attach_function :rasqal_query_prepare, [:rasqal_query, :string, :raptor_uri], :int
    attach_function :rasqal_query_execute, [:rasqal_query], :rasqal_query_results
    attach_function :rasqal_query_set_user_data, [:rasqal_query, :pointer], :void
    attach_function :rasqal_query_get_user_data, [:rasqal_query], :pointer
    attach_function :rasqal_query_add_data_graph, [:rasqal_query, :raptor_uri, :raptor_uri, :int], :int
    attach_function :rasqal_query_get_data_graph_sequence, [:rasqal_query], :raptor_sequence
    attach_function :rasqal_query_get_data_graph, [:rasqal_query, :int], :rasqal_data_graph
    attach_function :rasqal_query_get_order_conditions_sequence, [:rasqal_query], :raptor_sequence
    attach_function :rasqal_query_get_order_condition, [:rasqal_query, :int], :rasqal_expression
    attach_function :rasqal_query_get_verb, [:rasqal_query], :rasqal_query_verb
    attach_function :rasqal_query_get_wildcard, [:rasqal_query], :int
    attach_function :rasqal_query_get_query_graph_pattern, [:rasqal_query], :rasqal_graph_pattern
    attach_function :rasqal_query_set_default_generate_bnodeid_parameters, [:rasqal_query, :string, :int], :void # @deprecated
    attach_function :rasqal_query_set_generate_bnodeid_handler, [:rasqal_query, :pointer, :rasqal_generate_bnodeid_handler], :void # @deprecated
    attach_function :rasqal_query_verb_as_string, [:rasqal_query_verb], :string
    attach_function :rasqal_query_get_construct_triples_sequence, [:rasqal_query], :raptor_sequence
    attach_function :rasqal_query_get_construct_triple, [:rasqal_query, :int], :rasqal_triple
    attach_function :rasqal_query_get_explain, [:rasqal_query], :int
    attach_function :rasqal_query_get_group_conditions_sequence, [:rasqal_query], :raptor_sequence
    attach_function :rasqal_query_get_group_condition, [:rasqal_query, :int], :rasqal_expression
    attach_function :rasqal_query_write, [:raptor_iostream, :rasqal_query, :raptor_uri, :raptor_uri], :int
    attach_function :rasqal_query_iostream_write_escaped_counted_string, [:rasqal_query, :raptor_iostream, :string, :size_t], :int
    attach_function :rasqal_query_escape_counted_string, [:rasqal_query, :string, :size_t, :pointer], :string
    begin
      attach_function :rasqal_query_get_having_conditions_sequence, [:rasqal_query], :raptor_sequence # librasqal 0.9.20+
      attach_function :rasqal_query_get_having_condition, [:rasqal_query, :int], :rasqal_expression   # librasqal 0.9.20+
    rescue FFI::NotFoundError
    end
  end # FFI
end # RDF::Rasqal
