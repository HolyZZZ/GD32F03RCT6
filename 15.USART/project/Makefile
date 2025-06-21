# Makefile for GD32F103RC USART project

# 工具链设置
PREFIX = arm-none-eabi-
CC = $(PREFIX)gcc
AS = $(PREFIX)gcc -x assembler-with-cpp
CP = $(PREFIX)objcopy
SZ = $(PREFIX)size
AR = $(PREFIX)ar

# 项目名称
TARGET = usart_communication

# 定义目录
BUILD_DIR = build
CMSIS_DIR = ../CMSIS
LIB_DIR = ../Library
USER_DIR = ../User
STARTUP_DIR = ../Startup

# 优化级别
OPT = -O2

# 调试信息
DEBUG = -g

# 定义
DEFS = -DGD32F10X_HD -D__FPU_PRESENT

# 包含路径
INCLUDES = \
-I$(CMSIS_DIR) \
-I$(LIB_DIR)/Include \
-I$(USER_DIR)

# 编译器标志
CFLAGS = $(DEFS) $(INCLUDES) $(DEBUG) $(OPT) \
-mcpu=cortex-m3 -mthumb \
-ffunction-sections -fdata-sections -Wall -fno-strict-aliasing \
-MMD -MP -MF"$(@:%.o=%.d)" -MT"$@"

# 链接器标志
LDFLAGS = -mcpu=cortex-m3 -mthumb \
-specs=nano.specs -specs=nosys.specs \
-T$(LDSCRIPT) \
-Wl,-Map=$(BUILD_DIR)/$(TARGET).map,--cref -Wl,--gc-sections

# 链接脚本
LDSCRIPT = gd32f10x_flash.ld

# 源文件
C_SOURCES = \
$(USER_DIR)/main.c \
$(USER_DIR)/gd32f10x_it.c \
$(USER_DIR)/systick.c \
$(CMSIS_DIR)/system_gd32f10x.c \
$(LIB_DIR)/Source/gd32f10x_adc.c \
$(LIB_DIR)/Source/gd32f10x_bkp.c \
$(LIB_DIR)/Source/gd32f10x_can.c \
$(LIB_DIR)/Source/gd32f10x_crc.c \
$(LIB_DIR)/Source/gd32f10x_dac.c \
$(LIB_DIR)/Source/gd32f10x_dbg.c \
$(LIB_DIR)/Source/gd32f10x_dma.c \
$(LIB_DIR)/Source/gd32f10x_enet.c \
$(LIB_DIR)/Source/gd32f10x_exmc.c \
$(LIB_DIR)/Source/gd32f10x_exti.c \
$(LIB_DIR)/Source/gd32f10x_fmc.c \
$(LIB_DIR)/Source/gd32f10x_fwdgt.c \
$(LIB_DIR)/Source/gd32f10x_gpio.c \
$(LIB_DIR)/Source/gd32f10x_i2c.c \
$(LIB_DIR)/Source/gd32f10x_misc.c \
$(LIB_DIR)/Source/gd32f10x_pmu.c \
$(LIB_DIR)/Source/gd32f10x_rcu.c \
$(LIB_DIR)/Source/gd32f10x_rtc.c \
$(LIB_DIR)/Source/gd32f10x_sdio.c \
$(LIB_DIR)/Source/gd32f10x_spi.c \
$(LIB_DIR)/Source/gd32f10x_timer.c \
$(LIB_DIR)/Source/gd32f10x_usart.c \
$(LIB_DIR)/Source/gd32f10x_wwdgt.c

# 汇编源文件
ASM_SOURCES = \
$(STARTUP_DIR)/startup_gd32f10x_hd.s

# 目标文件列表
OBJECTS = $(addprefix $(BUILD_DIR)/,$(notdir $(C_SOURCES:.c=.o)))
vpath %.c $(sort $(dir $(C_SOURCES)))
OBJECTS += $(addprefix $(BUILD_DIR)/,$(notdir $(ASM_SOURCES:.s=.o)))
vpath %.s $(sort $(dir $(ASM_SOURCES)))

# 默认目标
all: $(BUILD_DIR) $(BUILD_DIR)/$(TARGET).elf $(BUILD_DIR)/$(TARGET).hex $(BUILD_DIR)/$(TARGET).bin

# 创建构建目录
$(BUILD_DIR):
	mkdir -p $@

# 编译C源文件
$(BUILD_DIR)/%.o: %.c Makefile | $(BUILD_DIR)
	$(CC) -c $(CFLAGS) -Wa,-a,-ad,-alms=$(BUILD_DIR)/$(notdir $(<:.c=.lst)) $< -o $@

# 编译汇编源文件
$(BUILD_DIR)/%.o: %.s Makefile | $(BUILD_DIR)
	$(AS) -c $(CFLAGS) $< -o $@

# 链接
$(BUILD_DIR)/$(TARGET).elf: $(OBJECTS) Makefile
	$(CC) $(OBJECTS) $(LDFLAGS) -o $@
	$(SZ) $@

# 创建hex文件
$(BUILD_DIR)/$(TARGET).hex: $(BUILD_DIR)/$(TARGET).elf
	$(CP) -O ihex $< $@

# 创建bin文件
$(BUILD_DIR)/$(TARGET).bin: $(BUILD_DIR)/$(TARGET).elf
	$(CP) -O binary -S $< $@

# 清理
clean:
	rm -rf $(BUILD_DIR)

# 依赖
-include $(wildcard $(BUILD_DIR)/*.d)

# 伪目标
.PHONY: all clean