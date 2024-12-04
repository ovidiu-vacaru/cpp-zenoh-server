cmake_minimum_required(VERSION 3.10)
project(MyProject)


set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED True)

find_package(zenohc) #if using zenoh-c backend
find_package(zenohcxx)


add_executable(main main.cpp)


target_link_libraries(main PUBLIC zenohcxx::zenohc) 