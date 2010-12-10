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

    extend ::FFI::Library
    ffi_lib 'librasqal'

    attach_variable :rasqal_version_major, :int
    attach_variable :rasqal_version_minor, :int
    attach_variable :rasqal_version_release, :int
    attach_variable :rasqal_version_decimal, :int
  end # FFI
end # RDF::Rasqal
