find_package(Perl REQUIRED)

set (MACROS_FILE "${PROJECT_SOURCE_DIR}/macros/macros.pl")

set (MACRO_FILES
    "${PROJECT_BINARY_DIR}/version.mac"
    "${PROJECT_SOURCE_DIR}/macros/altreg.mac"
    "${PROJECT_SOURCE_DIR}/macros/fp.mac"
    "${PROJECT_SOURCE_DIR}/macros/ifunc.mac"
    "${PROJECT_SOURCE_DIR}/macros/smartalign.mac"
    "${PROJECT_SOURCE_DIR}/macros/standard.mac"
    "${PROJECT_SOURCE_DIR}/output/outaout.mac"
    "${PROJECT_SOURCE_DIR}/output/outas86.mac"
    "${PROJECT_SOURCE_DIR}/output/outbin.mac"
    "${PROJECT_SOURCE_DIR}/output/outcoff.mac"
    "${PROJECT_SOURCE_DIR}/output/outdbg.mac"
    "${PROJECT_SOURCE_DIR}/output/outelf.mac"
    "${PROJECT_SOURCE_DIR}/output/outmacho.mac"
    "${PROJECT_SOURCE_DIR}/output/outobj.mac"
    "${PROJECT_SOURCE_DIR}/output/outrdf2.mac"
    "${PROJECT_SOURCE_DIR}/output/outrdf.mac")

function (MACROS)

    if (NOT IS_ABSOLUTE "${OUT}")
        set (OUT "${CMAKE_CURRENT_BINARY_DIR}/${OUT}")
    endif (NOT IS_ABSOLUTE "${OUT}")

    add_custom_command(OUTPUT "${PROJECT_SOURCE_DIR}/macros/macros.c"
        COMMAND "${PERL_EXECUTABLE}" -I "${PROJECT_SOURCE_DIR}/perllib" -I "${PROJECT_SOURCE_DIR}" "${MACROS_FILE}" ${MACRO_FILES}
        DEPENDS "${PROJECT_SOURCE_DIR}/asm/pptok.ph"
                "${MACRO_FILES}"
                "${MACROS_FILE}"
        WORKING_DIRECTORY "${PROJECT_SOURCE_DIR}")

endfunction (MACROS)
