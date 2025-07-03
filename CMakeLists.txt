cmake_minimum_required(VERSION 3.10)
project(GD32_Project C)

set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

include_directories(
  ./15.USART/CMSIS
  ./15.USART/Library/Include
  ./15.USART/User
  ./DB_MyCode/dbcode_app/inc
  ./DB_MyCode/dbcode_component/inc
  ./DB_MyCode/dbcode_kernel/inc
  ./DB_MyCode/dbcode_tools/inc
  ./DB_MyCode/dbcode_lib
)

file(GLOB SOURCES
  ./15.USART/User/*.c
  ./15.USART/CMSIS/*.c
  ./15.USART/Library/Source/*.c
  ./DB_MyCode/dbcode_app/src/*.c
  ./DB_MyCode/dbcode_component/src/*.c
  ./DB_MyCode/dbcode_kernel/src/*.c
  ./DB_MyCode/dbcode_tools/src/*.c
)

add_executable(${PROJECT_NAME} ${SOURCES})