cmake_minimum_required(VERSION 2.6)

cmake_policy(SET CMP0048 NEW)

project("NASM" VERSION 2.13.90 LANGUAGES C)

find_package(Perl REQUIRED)

include ("cmake/generate-version.cmake")

generate_version("h" "version.h")
generate_version("mac" "version.mac")

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
include_directories("asm")
include_directories("output")

if (CMAKE_COMPILER_IS_GNUCC)
    set (CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -Wall -W -pedantic")
    set (CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -Wno-unused-parameter -Wno-unused-function -Werror=implicit")
endif (CMAKE_COMPILER_IS_GNUCC)

add_definitions("-DHAVE_CMAKE_CONFIG_H")

add_library("nasmlib"
    "version.h"
    "nasmlib/badenum.c"
    "nasmlib/bsi.c"
    "nasmlib/crc64.c"
    "nasmlib/file.c"
    "nasmlib/filename.c"
    "nasmlib/hashtbl.c"
    "nasmlib/ilog2.c"
    "nasmlib/malloc.c"
    "nasmlib/md5c.c"
    "nasmlib/mmap.c"
    "nasmlib/path.c"
    "nasmlib/perfhash.c"
    "nasmlib/raa.c"
    "nasmlib/rbtree.c"
    "nasmlib/readnum.c"
    "nasmlib/realpath.c"
    "nasmlib/saa.c"
    "nasmlib/srcfile.c"
    "nasmlib/string.c"
    "nasmlib/strlist.c"
    "nasmlib/ver.c"
    "nasmlib/zerobuf.c")

set_target_properties("nasmlib" PROPERTIES OUTPUT_NAME "nasm")

include("cmake/perfhash.cmake")
perfhash("h" "asm/directiv.dat" "directiv.h")
perfhash("c" "asm/directiv.dat" "directbl.c")

include("cmake/pptok.cmake")
pptok("h" "asm/pptok.dat" "pptok.h")
pptok("c" "asm/pptok.dat" "pptok.c")
pptok("ph" "asm/pptok.dat" "${PROJECT_SOURCE_DIR}/asm/pptok.ph")

include("cmake/tokhash.cmake")
tokhash("h" "tokens.h")
tokhash("c" "tokhash.c")

include("cmake/regs.cmake")
regs("c" "x86/regs.dat" "regs.c")
regs("fc" "x86/regs.dat" "regflags.c")
regs("dc" "x86/regs.dat" "regdis.c")
regs("dh" "x86/regs.dat" "regdis.h")
regs("vc" "x86/regs.dat" "regvals.c")
regs("h" "x86/regs.dat" "regs.h")

include("cmake/insns.cmake")
insns("-fc" "x86/insns.dat" "iflag.c")
insns("-fh" "x86/insns.dat" "iflaggen.h")
insns("-b" "x86/insns.dat" "insnsb.c")
insns("-a" "x86/insns.dat" "insnsa.c")
insns("-d" "x86/insns.dat" "insnsd.c")
insns("-i" "x86/insns.dat" "insnsi.h")
insns("-n" "x86/insns.dat" "insnsn.c")

include("cmake/macros.cmake")
macros()

add_executable("nasm"
    "macros/macros.c"
    "pptok.h"
    "pptok.c"
    "directiv.h"
    "directbl.c"
    "insnsb.c"
    "insnsa.c"
    "insnsd.c"
    "insnsi.h"
    "insnsn.c"
    "regs.h"
    "regs.c"
    "regdis.h"
    "regdis.c"
    "regvals.c"
    "regflags.c"
    "tokens.h"
    "tokhash.c"
    "iflag.c"
    "iflaggen.h"
    "asm/nasm.c"
    "asm/assemble.h"
    "asm/assemble.c"
    "asm/directiv.c"
    "asm/error.c"
    "asm/eval.h"
    "asm/eval.c"
    "asm/exprdump.c"
    "asm/exprlib.c"
    "asm/float.h"
    "asm/float.c"
    "asm/labels.c"
    "asm/listing.h"
    "asm/listing.c"
    "asm/parser.h"
    "asm/parser.c"
    "asm/pragma.c"
    "asm/preproc.h"
    "asm/preproc.c"
    "asm/preproc-nop.c"
    "asm/quote.h"
    "asm/quote.c"
    "asm/rdstrnum.c"
    "asm/segalloc.c"
    "asm/stdscan.h"
    "asm/stdscan.c"
    "asm/strfunc.c"
    "common/common.c"
    "output/codeview.c"
    "output/legacy.c"
    "output/nulldbg.c"
    "output/nullout.c"
    "output/outaout.c"
    "output/outas86.c"
    "output/outbin.c"
    "output/outcoff.c"
    "output/outdbg.c"
    "output/outelf.c"
    "output/outform.c"
    "output/outieee.c"
    "output/outlib.c"
    "output/outmacho.c"
    "output/outobj.c"
    "output/outrdf2.c"
    "output/strtbl.c"
    "stdlib/snprintf.c"
    "stdlib/vsnprintf.c"
    "stdlib/strlcpy.c"
    "stdlib/strnlen.c"
    "stdlib/strrchrnul.c"
    "x86/disp8.c")

target_link_libraries("nasm" "nasmlib")

install(TARGETS "nasm"
    RUNTIME DESTINATION "bin")

set (CPACK_PACKAGE_NAME "NASM")
set (CPACK_PACKAGE_DESCRIPTION_SUMMARY "The netwide assembler.")
set (CPACK_PACKAGE_VENDOR "The NASM Authors")
set (CPACK_PACKAGE_VERSION_MAJOR ${NASM_VERSION_MAJOR})
set (CPACK_PACKAGE_VERSION_MINOR ${NASM_VERSION_MINOR})
set (CPACK_PACKAGE_VERSION_PATCH ${NASM_VERSION_PATCH})
set (CPACK_RESOURCE_FILE_LICENSE "${CMAKE_CURRENT_SOURCE_DIR}/LICENSE")
set (CPACK_PACKAGE_CONTACT "taylorcholberton@gmail.com")

include(CPack)

