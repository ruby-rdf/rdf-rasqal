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

    typedef :pointer, :rasqal_world
    attach_function :rasqal_new_world, [], :rasqal_world
    attach_function :rasqal_free_world, [:rasqal_world], :void
    attach_function :rasqal_world_set_raptor, [:rasqal_world, :pointer], :void
    attach_function :rasqal_world_get_raptor, [:rasqal_world] , :pointer
    attach_function :rasqal_world_open, [:rasqal_world], :int
  end # FFI
end # RDF::Rasqal
