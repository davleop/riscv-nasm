cmake_minimum_required(VERSION 2.6)

project("NASM" C)

find_package(Perl REQUIRED)

include ("cmake/generate-version.cmake")

generate_version("h" "version.h")

add_custom_target("version" ALL DEPENDS "version.h")

include(CheckIncludeFiles)
check_include_files("unistd.h" HAVE_UNISTD_H)
check_include_files("sys/mman.h" HAVE_SYS_MMAN_H)
check_include_files("sys/param.h" HAVE_SYS_PARAM_H)
check_include_files("sys/stat.h" HAVE_SYS_STAT_H)
check_include_files("sys/types.h" HAVE_SYS_TYPES_H)

configure_file("config/config.h.cmake" "config.h")

include_directories("${CMAKE_CURRENT_BINARY_DIR}")
include_directories("include")

if (CMAKE_COMPILER_IS_GNUCC)
    set (CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -Wall -Wextra -Werror -Wfatal-errors -Wpedantic")
    set (CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -Wno-unused-parameter -Wno-unused-function")
endif (CMAKE_COMPILER_IS_GNUCC)

add_definitions("-DHAVE_CMAKE_CONFIG_H")

add_subdirectory("nasmlib")
