#   BAREOS® - Backup Archiving REcovery Open Sourced
#
#   Copyright (C) 2017-2020 Bareos GmbH & Co. KG
#
#   This program is Free Software; you can redistribute it and/or
#   modify it under the terms of version three of the GNU Affero General Public
#   License as published by the Free Software Foundation and included
#   in the file LICENSE.
#
#   This program is distributed in the hope that it will be useful, but
#   WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
#   Affero General Public License for more details.
#
#   You should have received a copy of the GNU Affero General Public License
#   along with this program; if not, write to the Free Software
#   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
#   02110-1301, USA.

include(systemdservice)
if(${SYSTEMD_FOUND})
  set(HAVE_SYSTEMD 1)
endif()

if(NOT ${CMAKE_SYSTEM_NAME} MATCHES "Windows")
  #find_package (Python COMPONENTS Interpreter Development)
  find_package (Python2 COMPONENTS Interpreter Development)
  find_package (Python3 COMPONENTS Interpreter Development)
  if(${Python2_FOUND} OR ${Python3_FOUND})
    set(HAVE_PYTHON 1)
  endif()
endif()




if(NOT ${CMAKE_SYSTEM_NAME} MATCHES "Windows")
  include(FindPostgreSQL)
endif()

include(CMakeUserFindMySQL)

if(${CMAKE_SYSTEM_NAME} MATCHES "Darwin")
  set(OPENSSL_USE_STATIC_LIBS 1)
endif()
include(FindOpenSSL)

if(${OPENSSL_FOUND})
  set(HAVE_OPENSSL 1)
endif()

include(BareosFindLibraryAndHeaders)

bareosfindlibraryandheaders("jansson" "jansson.h")
bareosfindlibraryandheaders("rados" "rados/librados.h")
bareosfindlibraryandheaders("radosstriper" "radosstriper/libradosstriper.h")
bareosfindlibraryandheaders("cephfs" "cephfs/libcephfs.h")
bareosfindlibraryandheaders("pthread" "pthread.h")
bareosfindlibraryandheaders("cap" "sys/capability.h")
bareosfindlibraryandheaders("gfapi" "glusterfs/api/glfs.h")
bareosfindlibraryandheaders("droplet" "droplet.h")

bareosfindlibraryandheaders("pam" "security/pam_appl.h")

bareosfindlibraryandheaders("lzo2" "lzo/lzoconf.h")
if(${LZO2_FOUND})
  set(HAVE_LZO 1)
  if(${CMAKE_SYSTEM_NAME} MATCHES "Darwin")
    set(LZO2_LIBRARIES "/usr/local/opt/lzo/lib/liblzo2.a")
  endif()
endif()

# MESSAGE(FATAL_ERROR "exit")
include(BareosFindLibrary)

bareosfindlibrary("tirpc")
bareosfindlibrary("util")
bareosfindlibrary("dl")
bareosfindlibrary("acl")
# BareosFindLibrary("wrap")
if (NOT ${CMAKE_CXX_COMPILER_ID} MATCHES SunPro)
  bareosfindlibrary("gtest")
  bareosfindlibrary("gtest_main")
  bareosfindlibrary("gmock")
endif()

bareosfindlibrary("pam_wrapper")

if(${HAVE_CAP})
  set(HAVE_LIBCAP 1)
endif()

find_package(ZLIB)
if(${ZLIB_FOUND})
  set(HAVE_LIBZ 1)
endif()

find_package(Readline)
include(thread)
