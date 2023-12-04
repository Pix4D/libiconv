if (Iconv_FOUND) # Early exit if the library was already found
    return()
endif()

# Find the include dir and library
find_path(Iconv_INCLUDE_DIRS NAMES iconv.h PATHS ${CONAN_INCLUDE_DIRS_LIBICONV} NO_DEFAULT_PATH)
# Note: it is possible to use a list of known library names instead of CONAN_LIBS_MYLIB
find_library(Iconv_LIBRARIES NAMES "iconv" PATHS ${CONAN_LIB_DIRS_LIBICONV} NO_DEFAULT_PATH)
find_library(CHARSET_LIBRARY NAMES "charset" PATHS ${CONAN_LIB_DIRS_LIBICONV} NO_DEFAULT_PATH)

# Validate that include dirs and library have valid paths. Sets MYLIB_FOUND and MyLib_FOUND. Stops running the finder if the library was not found
include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(Iconv DEFAULT_MSG Iconv_INCLUDE_DIRS Iconv_LIBRARIES)
mark_as_advanced(Iconv_LIBRARIES Iconv_INCLUDE_DIRS)

# Declare target
add_library(Iconv::Iconv UNKNOWN IMPORTED)

# Declare usage requirements
set_target_properties(Iconv::Iconv PROPERTIES
    IMPORTED_LOCATION "${Iconv_LIBRARIES}"
    INTERFACE_INCLUDE_DIRECTORIES "${Iconv_INCLUDE_DIRS}"
    INTERFACE_LINK_LIBRARIES "${CHARSET_LIBRARY}"
)
