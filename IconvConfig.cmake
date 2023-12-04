if (Iconv_FOUND) # Early exit if the library was already found
    return()
endif()

message(STATUS "CONAN_INCLUDE_DIRS_ICONV: ${CONAN_INCLUDE_DIRS_LIBICONV}")
message(STATUS "CONAN_LIB_DIRS_ICONV: ${CONAN_LIB_DIRS_LIBICONV}")

# Find the include dir and library
find_path(ICONV_INCLUDE_DIR NAMES iconv.h PATHS ${CONAN_INCLUDE_DIRS_LIBICONV} NO_DEFAULT_PATH)
# Note: it is possible to use a list of known library names instead of CONAN_LIBS_MYLIB
find_library(ICONV_LIBRARY NAMES "iconv" PATHS ${CONAN_LIB_DIRS_LIBICONV} NO_DEFAULT_PATH)
find_library(CHARSET_LIBRARY NAMES "charset" PATHS ${CONAN_LIB_DIRS_LIBICONV} NO_DEFAULT_PATH)

# Validate that include dirs and library have valid paths. Sets MYLIB_FOUND and MyLib_FOUND. Stops running the finder if the library was not found
include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(Iconv DEFAULT_MSG ICONV_INCLUDE_DIR ICONV_LIBRARY)
mark_as_advanced(ICONV_LIBRARY ICONV_INCLUDE_DIR)

# Declare target
add_library(Iconv::Iconv UNKNOWN IMPORTED)

# Declare usage requirements
set_target_properties(Iconv::Iconv PROPERTIES
    IMPORTED_LOCATION "${ICONV_LIBRARY}"
    INTERFACE_INCLUDE_DIRECTORIES "${ICONV_INCLUDE_DIR}"
    INTERFACE_LINK_LIBRARIES "${CHARSET_LIBRARY}"
)
