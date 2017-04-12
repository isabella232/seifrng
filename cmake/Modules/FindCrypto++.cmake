# - Find Crypto++

if(CRYPTO++_INCLUDE_DIR AND CRYPTO++_LIBRARIES)
   set(CRYPTO++_FOUND TRUE)

else(CRYPTO++_INCLUDE_DIR AND CRYPTO++_LIBRARIES)
  find_path(CRYPTO++_INCLUDE_DIR
  	NAMES
  		cryptlib.h
  	PATHS
		/usr/local/include/cryptopp
  )


  find_library(CRYPTO++_LIBRARIES
  	NAMES
  		libcryptopp.a
    PATHS
      	/usr/local/lib
  )

  if(CRYPTO++_INCLUDE_DIR AND CRYPTO++_LIBRARIES)

    SET (_CRYPTOPP_VERSION_HEADER ${CRYPTO++_INCLUDE_DIR}/config.h)
    IF (EXISTS ${_CRYPTOPP_VERSION_HEADER})
      FILE (STRINGS ${_CRYPTOPP_VERSION_HEADER} _CRYPTOPP_VERSION_TMP REGEX
        "^#define CRYPTOPP_VERSION[ \t]+[0-9]+$")

      STRING (REGEX REPLACE
        "^#define CRYPTOPP_VERSION[ \t]+([0-9]+)" "\\1" _CRYPTOPP_VERSION_TMP
        ${_CRYPTOPP_VERSION_TMP})

      STRING (REGEX REPLACE "([0-9]+)[0-9][0-9]" "\\1" CRYPTOPP_VERSION_MAJOR
        ${_CRYPTOPP_VERSION_TMP})
      STRING (REGEX REPLACE "[0-9]([0-9])[0-9]" "\\1" CRYPTOPP_VERSION_MINOR
        ${_CRYPTOPP_VERSION_TMP})
      STRING (REGEX REPLACE "[0-9][0-9]([0-9])" "\\1" CRYPTOPP_VERSION_PATCH
        ${_CRYPTOPP_VERSION_TMP})

      SET (CRYPTOPP_VERSION_COUNT 3)
      SET (CRYPTO++_VERSION
        ${CRYPTOPP_VERSION_MAJOR}.${CRYPTOPP_VERSION_MINOR}.${CRYPTOPP_VERSION_PATCH})

      MESSAGE(STATUS "Found Crypto++ with this version ${CRYPTO++_VERSION}.")
      set(CRYPTO++_FOUND TRUE)
      message(STATUS "Found Crypto++: ${CRYPTO++_INCLUDE_DIR}, ${CRYPTO++_LIBRARIES}")

    ELSE (EXISTS ${_CRYPTOPP_VERSION_HEADER})
      set(CRYPTO++_FOUND FALSE)
      message(STATUS "Crypto++ with required version information not found.")
    ENDIF (EXISTS ${_CRYPTOPP_VERSION_HEADER})

  else(CRYPTO++_INCLUDE_DIR AND CRYPTO++_LIBRARIES)
    message(STATUS "Found: ${CRYPTO++_INCLUDE_DIR}")
    set(CRYPTO++_FOUND FALSE)
    message(STATUS "Crypto++ not found.")
  endif(CRYPTO++_INCLUDE_DIR AND CRYPTO++_LIBRARIES)

  mark_as_advanced(CRYPTO++_INCLUDE_DIR CRYPTO++_LIBRARIES)

endif(CRYPTO++_INCLUDE_DIR AND CRYPTO++_LIBRARIES)
