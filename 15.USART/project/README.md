# GD32F103RC USART通信项目 - GCC编译指南

## 项目概述

这是一个基于GD32F103RC微控制器的USART串口通信示例项目。本项目原本使用Keil MDK开发环境，现已添加Makefile和链接脚本，以支持使用GCC工具链进行编译。

## 硬件要求

- GD32F103RC微控制器开发板
- USB转串口模块（用于与PC通信）
- 连接线缆

## 软件要求

- ARM GCC工具链（arm-none-eabi-gcc）
- Make工具
- 串口终端软件（如PuTTY、串口助手等）

## 目录结构

- `CMSIS/`: Cortex微控制器软件接口标准文件
- `Library/`: GD32F10x标准外设库
  - `Include/`: 头文件
  - `Source/`: 源文件
- `Startup/`: 启动文件
- `User/`: 用户代码
  - `main.c`: 主程序
  - `gd32f10x_it.c`: 中断处理
  - `systick.c`: 系统滴答定时器
- `project/`: 项目文件
  - `Makefile`: GCC编译配置
  - `gd32f10x_flash.ld`: 链接脚本

## 编译指南

1. 确保已安装ARM GCC工具链和Make工具
2. 打开命令行终端，进入项目的`project`目录
3. 执行以下命令进行编译：

```bash
make
```

4. 编译成功后，在`build`目录下会生成以下文件：
   - `usart_communication.elf`: ELF格式的可执行文件
   - `usart_communication.hex`: HEX格式，用于烧录
   - `usart_communication.bin`: 二进制格式，用于烧录

## 烧录指南

可以使用ST-Link、J-Link等烧录工具将生成的`.hex`或`.bin`文件烧录到GD32F103RC微控制器中。

例如，使用OpenOCD和ST-Link烧录：

```bash
openocd -f interface/stlink.cfg -f target/stm32f1x.cfg -c "program build/usart_communication.hex verify reset exit"
```

## 功能说明

本项目实现了基本的USART串口通信功能：

- 配置USART0，波特率9600，8位数据位，1位停止位，无校验
- 通过中断方式接收数据
- 接收到的数据会被回显

## 硬件连接

将USB转串口模块连接到GD32F103RC开发板的USART0引脚：

- PA9: USART0_TX
- PA10: USART0_RX
- GND: 共地

## 调试方法

1. 使用串口终端软件（如PuTTY）
2. 配置串口参数：波特率9600，8位数据位，1位停止位，无校验
3. 连接到对应的COM端口
4. 发送数据，观察回显

## 注意事项

- 本项目使用的是GD32F103RC高密度型号的微控制器
- 系统时钟配置为108MHz
- 如需修改波特率或其他USART参数，请修改`main.c`中的相关配置