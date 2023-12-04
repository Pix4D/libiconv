cmake_minimum_required(VERSION 3.11)
project(TestPackage)

include(${CMAKE_BINARY_DIR}/conanbuildinfo.cmake)
conan_set_find_paths()

set(CMAKE_CXX_STANDARD 11)
set(CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

if (UNIX)
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wall -Wextra")
    if (APPLE)
        set(CMAKE_INSTALL_RPATH "@executable_path/../lib")
    else()
        set(CMAKE_INSTALL_RPATH "$ORIGIN/../lib")
    endif()
endif()

find_package(Iconv REQUIRED CONFIG)

add_executable(testApp test_package.c)
target_link_libraries(testApp Iconv::Iconv)
install(TARGETS testApp RUNTIME DESTINATION "bin")
