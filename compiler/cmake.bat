@echo off
setlocal EnableDelayedExpansion

:: 设置控制台编码为UTF-8，解决中文乱码问题
chcp 65001 > nul

:: 设置项目路径
set "PROJECT_PATH=..\15.USART\project"

echo 进入项目目录: %PROJECT_PATH%
cd /d "%~dp0%PROJECT_PATH%" || (
    echo 错误: 无法进入项目目录 %PROJECT_PATH%
    exit /b 1
)

:: ===================================================
:: 步骤1: 创建CMakeLists.txt文件（如果不存在）
:: ===================================================
if not exist CMakeLists.txt (
    echo 创建CMakeLists.txt文件...
    
    (
        echo cmake_minimum_required(VERSION 3.10^)
        echo project(GD32_Project C^)
        echo.
        echo set(CMAKE_EXPORT_COMPILE_COMMANDS ON^)
        echo.
        echo include_directories^(
        echo     ../15.USART/CMSIS
        echo     ../15.USART/Library/Include
        echo     ../15.USART/User
        echo     ../DB_MyCode/dbcode_app/inc
        echo     ../DB_MyCode/dbcode_component/inc
        echo     ../DB_MyCode/dbcode_kernel/inc
        echo     ../DB_MyCode/dbcode_tool/inc
        echo     ../DB_MyCode/dbcode_lib
        echo ^)
        echo.
        echo file(GLOB SOURCES
        echo     "../15.USART/User/*.c"
        echo     "../15.USART/CMSIS/*.c"
        echo     "../15.USART/Library/Source/*.c"
        echo     "../DB_MyCode/dbcode_app/src/*.c"
        echo     "../DB_MyCode/dbcode_component/src/*.c"
        echo     "../DB_MyCode/dbcode_kernel/src/*.c"
        echo     "../DB_MyCode/dbcode_tool/src/*.c"
        echo ^)
        echo.
        echo add_executable($${PROJECT_NAME} $${SOURCES}^)
    ) > CMakeLists.txt
)
:: ===================================================
:: 步骤2: 生成编译数据库 (compile_commands.json)
:: ===================================================
echo 生成编译数据库...

:: 检查cmake命令
where cmake >nul 2>nul || (
    echo 警告: 未找到cmake命令，跳过编译数据库生成
    echo 若要生成VSCode智能感知数据库，请安装CMake并添加到PATH
    echo 下载地址: https://cmake.org/download/
    goto :skip_cmake
)

:: 创建CMake构建目录
if not exist cmake-build (
    mkdir cmake-build
)

:: 运行CMake生成编译数据库
cd cmake-build
cmake -DCMAKE_C_COMPILER=arm-none-eabi-gcc -G "MinGW Makefiles" .. || (
    echo 警告: CMake生成编译数据库失败
    cd ..
    goto :skip_cmake
)
cd ..

:: 复制编译数据库到项目根目录
if exist cmake-build\compile_commands.json (
    copy /y cmake-build\compile_commands.json . >nul
    echo 已生成编译数据库: compile_commands.json
)

:skip_cmake

:: ===================================================
:: 步骤3: 清理和构建项目
:: ===================================================
echo 清理构建目录...
if exist build (
    rd /s /q build
)

echo 创建构建目录...
mkdir build 2>nul || (
    echo 错误: 无法创建构建目录
    exit /b 1
)

echo 开始编译...

:: 检查make命令 (支持多种名称)
set MAKE_CMD=
where mingw32-make >nul 2>nul && set MAKE_CMD=mingw32-make
where make >nul 2>nul && set MAKE_CMD=make

if "%MAKE_CMD%"=="" (
    echo 错误: 未找到make命令。请确保已安装make工具并添加到PATH环境变量中。
    echo 可用的make工具名称: make 或 mingw32-make
    exit /b 1
)

echo 使用make工具: %MAKE_CMD%
%MAKE_CMD% all || (
    echo 编译失败！
    exit /b 1
)

:: ===================================================
:: 步骤4: 复制输出文件
:: ===================================================
echo 复制输出文件...
set "OUTPUT_DIR=%~dp0..\out"

:: 确保输出目录存在
if not exist "%OUTPUT_DIR%" (
    mkdir "%OUTPUT_DIR%" || (
        echo 错误: 无法创建输出目录 %OUTPUT_DIR%
        exit /b 1
    )
)

:: 复制文件并检查是否成功
set COPY_FAILED=0

if exist build\*.hex (
    copy /y build\*.hex "%OUTPUT_DIR%\" >nul || set COPY_FAILED=1
) else (
    echo 警告: 未找到HEX文件
    set COPY_FAILED=1
)

if exist build\*.bin (
    copy /y build\*.bin "%OUTPUT_DIR%\" >nul || set COPY_FAILED=1
) else (
    echo 警告: 未找到BIN文件
    set COPY_FAILED=1
)

if exist build\*.map (
    copy /y build\*.map "%OUTPUT_DIR%\" >nul || set COPY_FAILED=1
) else (
    echo 警告: 未找到MAP文件
    set COPY_FAILED=1
)

if %COPY_FAILED% equ 1 (
    echo 警告: 部分文件复制失败
)

echo.
echo 编译完成！
echo 输出文件位置: %OUTPUT_DIR%

:: 返回原目录
cd /d %~dp0

endlocal