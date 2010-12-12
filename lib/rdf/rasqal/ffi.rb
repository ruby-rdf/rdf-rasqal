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

    include RDF::Raptor::FFI::V1
    # TODO: these should be inherited from `RDF::Raptor::FFI::V1`
    typedef :pointer, :raptor_sequence
    typedef :pointer, :raptor_uri
    typedef :pointer, :raptor_iostream
    typedef :pointer, :raptor_locator
    typedef :pointer, :raptor_statement
    callback :raptor_message_handler, [:pointer, :raptor_locator, :string], :void

    typedef :pointer, :rasqal_world
    typedef :pointer, :rasqal_query
    typedef :pointer, :rasqal_query_results
    typedef :pointer, :rasqal_variables_table
    typedef :pointer, :rasqal_row
    typedef :pointer, :rasqal_prefix
    typedef :pointer, :rasqal_variable
    typedef :pointer, :rasqal_literal
    typedef :pointer, :rasqal_triple
    typedef :pointer, :rasqal_graph_pattern
    typedef :pointer, :rasqal_data_graph
    typedef :pointer, :rasqal_expression
    enum :rasqal_query_verb, [:unknown, :select, :construct, :describe, :ask, :delete, :insert, :update]
    enum :rasqal_query_results_type, [:bindings, :boolean, :graph, :syntax]
    enum :rasqal_variable_type, [:unknown, :normal, :anonymous]
    callback :rasqal_generate_bnodeid_handler, [:rasqal_query, :pointer, :string], :string
    callback :rasqal_generate_bnodeid_handler2, [:rasqal_world, :pointer, :string], :string # librasqal 0.9.20+

    attach_function :rasqal_new_world, [], :rasqal_world
    attach_function :rasqal_free_world, [:rasqal_world], :void
    attach_function :rasqal_world_set_raptor, [:rasqal_world, :pointer], :void
    attach_function :rasqal_world_get_raptor, [:rasqal_world] , :pointer
    attach_function :rasqal_world_open, [:rasqal_world], :int
    attach_function :rasqal_world_set_default_generate_bnodeid_parameters, [:rasqal_world, :string, :int], :void                    # librasqal 0.9.20+
    attach_function :rasqal_world_set_generate_bnodeid_handler, [:rasqal_world, :pointer, :rasqal_generate_bnodeid_handler2], :void # librasqal 0.9.20+

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
    attach_function :rasqal_query_get_having_conditions_sequence, [:rasqal_query], :raptor_sequence # librasqal 0.9.20+
    attach_function :rasqal_query_get_having_condition, [:rasqal_query, :int], :rasqal_expression   # librasqal 0.9.20+

    attach_function :rasqal_new_query_results, [:rasqal_world, :rasqal_query, :rasqal_query_results_type, :rasqal_variables_table], :rasqal_query_results
    attach_function :rasqal_free_query_results, [:rasqal_query_results], :void
    attach_function :rasqal_query_results_get_query, [:rasqal_query_results], :rasqal_query
    attach_function :rasqal_query_results_is_bindings, [:rasqal_query_results], :int
    attach_function :rasqal_query_results_is_boolean, [:rasqal_query_results], :int
    attach_function :rasqal_query_results_is_graph, [:rasqal_query_results], :int
    attach_function :rasqal_query_results_is_syntax, [:rasqal_query_results], :int
    attach_function :rasqal_query_results_get_count, [:rasqal_query_results], :int
    attach_function :rasqal_query_results_next, [:rasqal_query_results], :int
    attach_function :rasqal_query_results_finished, [:rasqal_query_results], :int
    attach_function :rasqal_query_results_get_bindings, [:rasqal_query_results, :pointer, :pointer], :int
    attach_function :rasqal_query_results_get_binding_value, [:rasqal_query_results, :int], :rasqal_literal
    attach_function :rasqal_query_results_get_binding_name, [:rasqal_query_results, :int], :string
    attach_function :rasqal_query_results_get_binding_value_by_name, [:rasqal_query_results, :string], :rasqal_literal
    attach_function :rasqal_query_results_get_bindings_count, [:rasqal_query_results], :int
    attach_function :rasqal_query_results_get_triple, [:rasqal_query_results], :raptor_statement
    attach_function :rasqal_query_results_next_triple, [:rasqal_query_results], :int
    attach_function :rasqal_query_results_get_boolean, [:rasqal_query_results], :int
    attach_function :rasqal_query_results_write2, [:raptor_iostream, :rasqal_query_results, :string, :string, :raptor_uri, :raptor_uri], :int
    attach_function :rasqal_query_results_write, [:raptor_iostream, :rasqal_query_results, :raptor_uri, :raptor_uri], :int
    attach_function :rasqal_query_results_read2, [:raptor_iostream, :rasqal_query_results, :string, :string, :raptor_uri, :raptor_uri], :int
    attach_function :rasqal_query_results_read, [:raptor_iostream, :rasqal_query_results, :raptor_uri, :raptor_uri], :int
    attach_function :rasqal_query_results_add_row, [:rasqal_query_results, :rasqal_row], :int
    attach_function :rasqal_query_results_remove_query_reference, [:rasqal_query_results], :void
    attach_function :rasqal_query_results_get_variables_table, [:rasqal_query_results], :rasqal_variables_table
    attach_function :rasqal_query_results_get_world, [:rasqal_query_results], :rasqal_world

    attach_function :rasqal_new_variables_table, [:rasqal_world], :rasqal_variables_table
    attach_function :rasqal_new_variables_table_from_variables_table, [:rasqal_variables_table], :rasqal_variables_table
    attach_function :rasqal_free_variables_table, [:rasqal_variables_table], :void
    attach_function :rasqal_variables_table_add, [:rasqal_variables_table, :rasqal_variable_type, :string, :rasqal_literal], :rasqal_variable
    attach_function :rasqal_variables_table_get, [:rasqal_variables_table, :int], :rasqal_variable
    attach_function :rasqal_variables_table_get_value, [:rasqal_variables_table, :int], :rasqal_literal
    attach_function :rasqal_variables_table_get_by_name, [:rasqal_variables_table, :string], :rasqal_variable
    attach_function :rasqal_variables_table_has, [:rasqal_variables_table, :string], :int
    attach_function :rasqal_variables_table_set, [:rasqal_variables_table, :string, :rasqal_literal], :int
    attach_function :rasqal_variables_table_get_named_variables_count, [:rasqal_variables_table], :int
    attach_function :rasqal_variables_table_get_anonymous_variables_count, [:rasqal_variables_table], :int
    attach_function :rasqal_variables_table_get_total_variables_count, [:rasqal_variables_table], :int
    attach_function :rasqal_variables_table_get_named_variables_sequence, [:rasqal_variables_table], :raptor_sequence
    attach_function :rasqal_variables_table_get_anonymous_variables_sequence, [:rasqal_variables_table], :raptor_sequence
    attach_function :rasqal_variables_table_get_names, [:rasqal_variables_table], :pointer

    attach_function :rasqal_new_variable_typed, [:rasqal_query, :rasqal_variable_type, :string, :rasqal_literal], :rasqal_variable
    attach_function :rasqal_new_variable, [:rasqal_query, :string, :rasqal_literal], :rasqal_variable
    attach_function :rasqal_new_variable_from_variable, [:rasqal_variable], :rasqal_variable
    attach_function :rasqal_free_variable, [:rasqal_variable], :void
    attach_function :rasqal_variable_write, [:rasqal_variable, :raptor_iostream], :void
    attach_function :rasqal_variable_print, [:rasqal_variable, :pointer], :int
    attach_function :rasqal_variable_set_value, [:rasqal_variable, :rasqal_literal], :void
  end # FFI
end # RDF::Rasqal
