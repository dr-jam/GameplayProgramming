cmake_minimum_required(VERSION 3.10)
project(node-engine-demo CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

# Enable warnings
if(MSVC)
    add_compile_options(/W4 /WX)
else()
    add_compile_options(-Wall -Wextra -Wpedantic -Werror)
endif()

add_executable(node-engine-demo
    src/main.cpp
    src/node.cpp
    src/scene_tree.cpp
    src/enemy.cpp
)

# Include directories
target_include_directories(node-engine-demo PRIVATE src)
