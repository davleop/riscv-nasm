find_package(Perl REQUIRED)

function (GENERATE_VERSION TYPE OUTPUT_FILE)

    if (NOT IS_ABSOLUTE "${OUTPUT_FILE}")
        set (OUTPUT_FILE "${CMAKE_CURRENT_BINARY_DIR}/${OUTPUT_FILE}")
    endif (NOT IS_ABSOLUTE "${OUTPUT_FILE}")

    set (VER_CMD)
    set (VER_CMD "${PERL_EXECUTABLE}" "${PROJECT_SOURCE_DIR}/version.pl")
    set (VER_CMD ${VER_CMD} ${TYPE})
    set (VER_CMD ${VER_CMD} < "${PROJECT_SOURCE_DIR}/version")
    set (VER_CMD ${VER_CMD} > "${OUTPUT_FILE}")

    add_custom_command(OUTPUT "${OUTPUT_FILE}" COMMAND ${VER_CMD})

endfunction (GENERATE_VERSION TYPE OUTPUT_FILE)
