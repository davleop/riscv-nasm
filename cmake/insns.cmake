find_package(Perl REQUIRED)

set (INSNS_FILE "${PROJECT_SOURCE_DIR}/x86/insns.pl")

function (INSNS OPT IN OUT)

    if (NOT IS_ABSOLUTE "${IN}")
        set (IN "${CMAKE_CURRENT_SOURCE_DIR}/${IN}")
    endif (NOT IS_ABSOLUTE "${IN}")

    if (NOT IS_ABSOLUTE "${OUT}")
        set (OUT "${CMAKE_CURRENT_BINARY_DIR}/${OUT}")
    endif (NOT IS_ABSOLUTE "${OUT}")

    add_custom_command(OUTPUT "${OUT}"
        COMMAND "${PERL_EXECUTABLE}" -I "${PROJECT_SOURCE_DIR}/perllib" -I "${PROJECT_SOURCE_DIR}" "${INSNS_FILE}" ${OPT} "${IN}" "${OUT}"
        DEPENDS "${PROJECT_SOURCE_DIR}/x86/insns-iflags.ph"
                "${IN}"
                "${INSNS_FILE}")

endfunction (INSNS OPT IN OUT)
