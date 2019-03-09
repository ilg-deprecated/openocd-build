# -----------------------------------------------------------------------------

# Helper script used in the second edition of the GNU MCU Eclipse build 
# scripts. As the name implies, it should contain only functions and 
# should be included with 'source' by the build scripts (both native
# and container).

# -----------------------------------------------------------------------------

function prepare_extras()
{
  # ---------------------------------------------------------------------------

  EXTRA_CPPFLAGS=""

  EXTRA_CFLAGS="-ffunction-sections -fdata-sections -pipe"
  EXTRA_CXXFLAGS="-ffunction-sections -fdata-sections -pipe"

  EXTRA_LDFLAGS_LIB=""
  EXTRA_LDFLAGS="${EXTRA_LDFLAGS_LIB}"
  EXTRA_LDFLAGS_APP=""

  if [ "${IS_DEBUG}" == "y" ]
  then
    EXTRA_CFLAGS+=" -g -O0"
    EXTRA_CXXFLAGS+=" -g -O0"
    EXTRA_LDFLAGS+=" -g -O0"
  else
    EXTRA_CFLAGS+=" -O2"
    EXTRA_CXXFLAGS+=" -O2"
    EXTRA_LDFLAGS+=" -O2"
  fi

  if [ "${TARGET_PLATFORM}" == "linux" ]
  then
    local which_gcc_7="$(xbb_activate; which "g++-7")"
    if [ ! -z "${which_gcc_7}" ]
    then
      export CC="gcc-7"
      export CXX="g++-7"
    else
      export CC="gcc"
      export CXX="g++"
    fi
    # Do not add -static here, it fails.
    # Do not try to link pthread statically, it must match the system glibc.
    EXTRA_LDFLAGS_APP="${EXTRA_LDFLAGS} -static-libstdc++ -Wl,--gc-sections"
  elif [ "${TARGET_PLATFORM}" == "darwin" ]
  then
    export CC="gcc-7"
    export CXX="g++-7"
    # Note: macOS linker ignores -static-libstdc++, so 
    # libstdc++.6.dylib should be handled.
    EXTRA_LDFLAGS_APP="${EXTRA_LDFLAGS} -Wl,-dead_strip"
  elif [ "${TARGET_PLATFORM}" == "win32" ]
  then
    # CRT_glob is from ARM script
    # -static avoids libwinpthread-1.dll 
    # -static-libgcc avoids libgcc_s_sjlj-1.dll 
    EXTRA_LDFLAGS_APP="${EXTRA_LDFLAGS} -static -static-libgcc -static-libstdc++ -Wl,--gc-sections"
  fi

  set +u
  if [ ! -z "${XBB_FOLDER}" -a -x "${XBB_FOLDER}"/bin/pkg-config-verbose ]
  then
    export PKG_CONFIG="${XBB_FOLDER}"/bin/pkg-config-verbose
  fi
  set -u

  PKG_CONFIG_PATH=${PKG_CONFIG_PATH:-""}

  set +u
  echo
  echo "CC=${CC}"
  echo "CXX=${CXX}"
  echo "EXTRA_CPPFLAGS=${EXTRA_CPPFLAGS}"
  echo "EXTRA_CFLAGS=${EXTRA_CFLAGS}"
  echo "EXTRA_CXXFLAGS=${EXTRA_CXXFLAGS}"
  echo "EXTRA_LDFLAGS=${EXTRA_LDFLAGS}"

  echo "EXTRA_LDFLAGS_APP=${EXTRA_LDFLAGS_APP}"

  echo "PKG_CONFIG=${PKG_CONFIG}"
  set -u

  set +u
  if [ "${TARGET_PLATFORM}" == "win32" -a ! -z "${CC}" -a ! -z  "${CXX}" ]
  then
    echo "CC and CXX must not be set for cross builds."
    exit 1
  fi
  set -u

  # ---------------------------------------------------------------------------

  APP_PREFIX="${INSTALL_FOLDER_PATH}/${APP_LC_NAME}"
  if [ "${TARGET_PLATFORM}" == "win32" ]
  then
    APP_PREFIX_DOC="${APP_PREFIX}/doc"
  else
    # For POSIX platforms, keep the tradition.
    APP_PREFIX_DOC="${APP_PREFIX}/share/doc"
  fi

  # ---------------------------------------------------------------------------

  SOURCES_FOLDER_PATH=${SOURCES_FOLDER_PATH:-"${WORK_FOLDER_PATH}/sources"}
  mkdir -p "${SOURCES_FOLDER_PATH}"

  # ---------------------------------------------------------------------------

  HAS_NAME_ARCH=${HAS_NAME_ARCH:-""}

  # ---------------------------------------------------------------------------

  # libtool fails with the Ubuntu /bin/sh.
  export SHELL="/bin/bash"
  export CONFIG_SHELL="/bin/bash"
}

# -----------------------------------------------------------------------------

function download_openocd() 
{
  if [ ! -d "${WORK_FOLDER_PATH}/${OPENOCD_SRC_FOLDER_NAME}" ]
  then
    (
      xbb_activate

      cd "${WORK_FOLDER_PATH}"
      git_clone "${OPENOCD_GIT_URL}" "${OPENOCD_GIT_BRANCH}" \
          "${OPENOCD_GIT_COMMIT}" "${OPENOCD_SRC_FOLDER_NAME}"
      cd "${WORK_FOLDER_PATH}/${OPENOCD_SRC_FOLDER_NAME}"
      git submodule update --init --recursive --remote
    )
  fi
}

# -----------------------------------------------------------------------------
