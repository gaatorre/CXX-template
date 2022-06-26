# Almost all CMake files should start with this
# You should always specify a range with the newest
# and oldest tested versions of CMake. This will ensure
# you pick up the best policies.
cmake_minimum_required(VERSION 3.1...3.23)

# Environmental variables
set(proj $ENV{PROJ})
set(build $ENV{BUILD})

# This is your project statement. You should always list languages;
# Listing the version is nice here since it sets lots of useful variables
project(
  ${proj}
  VERSION 1.0
  LANGUAGES CXX)

# Only do these if this is the main project, and not if it is included through add_subdirectory
if(CMAKE_PROJECT_NAME STREQUAL PROJECT_NAME)

  # Set build mode
  set(CMAKE_BUILD_TYPE ${build})

  # Add cmake helpers
  set(CMAKE_MODULE_PATH "${PROJECT_SOURCE_DIR}/cmake" ${CMAKE_MODULE_PATH})

  # Set the include dir
  include_directories("${CMAKE_SOURCE_DIR}/include")

  # Optionally set things like CMAKE_CXX_STANDARD, CMAKE_POSITION_INDEPENDENT_CODE here

  # Let's ensure -std=c++xx instead of -std=g++xx
  set(CMAKE_CXX_EXTENSIONS OFF)

  # Let's nicely support folders in IDEs
  set_property(GLOBAL PROPERTY USE_FOLDERS ON)

  # Testing only available if this is the main app
  # Note this needs to be done in the main CMakeLists
  # since it calls enable_testing, which must be in the
  # main CMakeLists.
  # include(CTest)

  # Docs only available if this is the main app
  # find_package(Doxygen)
  # if(Doxygen_FOUND)
  #  add_subdirectory(docs)
  # else()
  #  message(STATUS "Doxygen not found, not building docs")
  #endif()
endif()

# Setting where our binaries get build
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin)

# including helpers
# Git must remain at the top since it checks out all the submodules
include("${CMAKE_MODULE_PATH}/findGit.cmake")
include("${CMAKE_MODULE_PATH}/findCatch2.cmake")

# Find packages go here


# The compiled library code is here
add_subdirectory(src)
add_subdirectory(tests)
