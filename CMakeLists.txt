cmake_minimum_required(VERSION 2.6)

project("NASM")

include_directories("include")
include_directories("asm")
include_directories(".")
include_directories("x86")

if (CMAKE_COMPILER_IS_GNUCC)
	set (CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -Wall -W -Wpedantic")
	set (CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -Wno-unused-parameter -Wno-unused-function")
endif (CMAKE_COMPILER_IS_GNUCC)

add_subdirectory("nasmlib")
