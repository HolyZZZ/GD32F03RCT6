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