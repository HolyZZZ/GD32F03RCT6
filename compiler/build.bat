@echo off
setlocal EnableDelayedExpansion

:: 设置控制台编码为UTF-8，解决中文乱码问题
chcp 65001 > nul

:: 设置项目路径
set PROJECT_PATH=..\15.USART\project

echo 进入项目目录: %PROJECT_PATH%
cd /d %~dp0\%PROJECT_PATH% || (
    echo 错误: 无法进入项目目录 %PROJECT_PATH%
    exit /b 1
)

echo 清理构建目录...
if exist build (
    rd /s /q build
)

echo 创建构建目录...
md build 2>nul

echo 开始编译...

:: 检查make命令

where mingw32-make >nul 2>nul
if %ERRORLEVEL% neq 0 (
    echo 错误: 未找到make命令。请确保已安装make工具并添加到PATH环境变量中。
    exit /b 1
) else (
    mingw32-make
)

if errorlevel 1 (
    echo 编译失败！
    exit /b 1
)

echo 复制输出文件...
if not exist ..\out md ..\out 2>nul

:: 复制文件并显示进度
echo 复制HEX文件...
copy build\*.hex %~dp0\..\out\ >nul
echo 复制BIN文件...
copy build\*.bin %~dp0\..\out\ >nul
echo 复制MAP文件...
copy build\*.map %~dp0\..\out\ >nul 2>nul

echo.
echo 编译完成！
echo 输出文件位置: %~dp0\..\out

:: 返回原目录
cd /d %~dp0

endlocal