cmake_minimum_required(VERSION 3.16)
project(LoopUnrollAdvisor)

# ── Locate LLVM ───────────────────────────────────────────────────────────────
find_package(LLVM REQUIRED CONFIG
  HINTS /usr/lib/llvm-18/lib/cmake/llvm
        /usr/lib/llvm-17/lib/cmake/llvm
        /usr/lib/llvm-16/lib/cmake/llvm)

message(STATUS "Found LLVM ${LLVM_PACKAGE_VERSION} at ${LLVM_DIR}")

list(APPEND CMAKE_MODULE_PATH "${LLVM_CMAKE_DIR}")
include(HandleLLVMOptions)
add_definitions(${LLVM_DEFINITIONS})
include_directories(${LLVM_INCLUDE_DIRS})

# ── Pass shared library ───────────────────────────────────────────────────────
add_library(LoopUnrollAdvisor MODULE src/LoopUnrollAdvisor.cpp)

set_target_properties(LoopUnrollAdvisor PROPERTIES
  CXX_STANDARD 17
  CXX_STANDARD_REQUIRED ON
  PREFIX ""
  OUTPUT_NAME "LoopUnrollAdvisor"
  LIBRARY_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}")

# LLVM passes must NOT link against libLLVM — they're loaded into opt at runtime
target_compile_options(LoopUnrollAdvisor PRIVATE
  -fno-rtti -fPIC ${LLVM_COMPILE_FLAGS})