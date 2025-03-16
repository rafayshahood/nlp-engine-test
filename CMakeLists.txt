cmake_minimum_required(VERSION 3.22.1)
project(nlp VERSION 0.1.0)
set(CMAKE_CXX_STANDARD 17)

include(CTest)
enable_testing()

# Ensure pkg-config is used for dependency resolution
find_package(PkgConfig REQUIRED)

# Find ICU package explicitly, ensuring compatibility with Ubuntu 22.04
find_package(ICU REQUIRED COMPONENTS i18n uc data io)

set(CMAKE_POSITION_INDEPENDENT_CODE ON)

set(NLP_ROOT ${CMAKE_CURRENT_SOURCE_DIR})
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_SOURCE_DIR}/bin)
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_SOURCE_DIR}/lib)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_SOURCE_DIR}/lib)

include_directories(cs/include)
include_directories(include)
include_directories(include/Api)
include_directories(include/Api/lite)
include_directories(${ICU_INCLUDE_DIR})

add_subdirectory(cs)
add_subdirectory(src)
add_subdirectory(lite)
add_subdirectory(nlp)
add_subdirectory(test)

set(CPACK_PROJECT_NAME ${PROJECT_NAME})
set(CPACK_PROJECT_VERSION ${PROJECT_VERSION})
include(CPack)