find_package(Perl REQUIRED)

set (REGS_FILE "${PROJECT_SOURCE_DIR}/x86/regs.pl")

function (REGS OPT IN OUT)

    if (NOT IS_ABSOLUTE "${IN}")
        set (IN "${CMAKE_CURRENT_SOURCE_DIR}/${IN}")
    endif (NOT IS_ABSOLUTE "${IN}")

    if (NOT IS_ABSOLUTE "${OUT}")
        set (OUT "${CMAKE_CURRENT_BINARY_DIR}/${OUT}")
    endif (NOT IS_ABSOLUTE "${OUT}")

    add_custom_command(OUTPUT "${OUT}"
        COMMAND "${PERL_EXECUTABLE}" -I "${PROJECT_SOURCE_DIR}/perllib" -I "${PROJECT_SOURCE_DIR}" "${REGS_FILE}" ${OPT} "${IN}" > "${OUT}"
        DEPENDS "${IN}"
                "${REGS_FILE}")

endfunction (REGS OPT IN OUT)
