find_package(Perl REQUIRED)

set (TOKHASH_FILE "${PROJECT_SOURCE_DIR}/asm/tokhash.pl")

set (PERLLIB "${PROJECT_SOURCE_DIR}/perllib")

set (INSNS_DAT "${PROJECT_SOURCE_DIR}/x86/insns.dat")
set (REGS_DAT "${PROJECT_SOURCE_DIR}/x86/regs.dat")
set (TOKENS_DAT "${PROJECT_SOURCE_DIR}/asm/tokens.dat")

function (TOKHASH OPT OUT)

    if (NOT IS_ABSOLUTE "${IN}")
        set (IN "${CMAKE_CURRENT_SOURCE_DIR}/${IN}")
    endif (NOT IS_ABSOLUTE "${IN}")

    if (NOT IS_ABSOLUTE "${OUT}")
        set (OUT "${CMAKE_CURRENT_BINARY_DIR}/${OUT}")
    endif (NOT IS_ABSOLUTE "${OUT}")

    add_custom_command(OUTPUT "${OUT}"
        COMMAND "${PERL_EXECUTABLE}" -I "${PERLLIB}" -I "${PROJECT_SOURCE_DIR}" "${TOKHASH_FILE}" ${OPT} "${INSNS_DAT}" "${REGS_DAT}" "${TOKENS_DAT}" > "${OUT}"
        DEPENDS "${INSNS_DAT}" "${REGS_DAT}" "${TOKENS_DAT}" "${TOKHASH_FILE}")

endfunction (TOKHASH OPT OUT)
