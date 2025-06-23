# Makefile for GD32F103RC USART project (Windows Optimized)

# 工具链设置
PREFIX = arm-none-eabi-
CC = $(PREFIX)gcc
AS = $(PREFIX)gcc -x assembler-with-cpp
CP = $(PREFIX)objcopy
SZ = $(PREFIX)size

# 项目名称
TARGET = app

# 定义目录
BUILD_DIR = build
OUTPUT_DIR = ../out
CMSIS_DIR = ../CMSIS
LIB_DIR = ../Library
USER_DIR = ../User
STARTUP_DIR = ../Startup/GNU

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

# C编译器标志
CFLAGS = $(DEFS) $(INCLUDES) $(DEBUG) $(OPT) \
-mcpu=cortex-m3 -mthumb \
-ffunction-sections -fdata-sections -Wall -fno-strict-aliasing \
-MMD -MP -MF"$(@:%.o=%.d)" -MT"$@"

# 汇编器标志
ASFLAGS = -mcpu=cortex-m3 -mthumb -g

# 链接器标志
LDFLAGS = -mcpu=cortex-m3 -mthumb \
	-specs=nano.specs -specs=nosys.specs \
	-T$(LDSCRIPT) \
	-Wl,-Map=$(BUILD_DIR)/$(TARGET).map,--cref -Wl,--gc-sections \
	-Wl,--print-memory-usage

# 链接脚本
LDSCRIPT = gd32f10x_flash.ld

# 源文件
C_SOURCES = \
$(USER_DIR)/main.c \
$(USER_DIR)/gd32f10x_it.c \
$(USER_DIR)/systick.c \
$(USER_DIR)/syscalls.c \
$(CMSIS_DIR)/system_gd32f10x.c \
$(LIB_DIR)/Source/gd32f10x_gpio.c \
$(LIB_DIR)/Source/gd32f10x_rcu.c \
$(LIB_DIR)/Source/gd32f10x_usart.c \
$(LIB_DIR)/Source/gd32f10x_misc.c

# 汇编源文件 (保留原始文件名)
ASM_SOURCES = $(STARTUP_DIR)/startup_gd32f10x_hd.s

# 目标文件列表
OBJECTS = $(addprefix $(BUILD_DIR)/,$(notdir $(C_SOURCES:.c=.o)))
vpath %.c $(sort $(dir $(C_SOURCES)))
OBJECTS += $(addprefix $(BUILD_DIR)/,$(notdir $(ASM_SOURCES:.s=.o)))
vpath %.s $(sort $(dir $(ASM_SOURCES)))

# 默认目标
all: $(BUILD_DIR) $(BUILD_DIR)/$(TARGET).elf $(BUILD_DIR)/$(TARGET).hex $(BUILD_DIR)/$(TARGET).bin
	@echo ===== BUILD SUCCESS =====
	
	@echo Creating output directory...
	@if not exist "$(OUTPUT_DIR)" mkdir "$(OUTPUT_DIR)"
	
	@echo Copying output files...
	@copy /Y "$(BUILD_DIR)\$(TARGET).bin" "$(OUTPUT_DIR)\" > nul
	@copy /Y "$(BUILD_DIR)\$(TARGET).hex" "$(OUTPUT_DIR)\" > nul
	@if exist "$(BUILD_DIR)\$(TARGET).map" copy /Y "$(BUILD_DIR)\$(TARGET).map" "$(OUTPUT_DIR)\" > nul
	
	@echo Output files copied to: $(OUTPUT_DIR)

# 创建构建目录
$(BUILD_DIR):
	@echo Creating build directory...
	@mkdir "$(BUILD_DIR)"

# 编译C源文件
$(BUILD_DIR)/%.o: %.c Makefile | $(BUILD_DIR)
	@echo Compiling: $<
	@$(CC) -c $(CFLAGS) -Wa,-a,-ad,-alms=$(BUILD_DIR)/$(notdir $(<:.c=.lst)) $< -o $@

# 编译汇编源文件
$(BUILD_DIR)/%.o: $(STARTUP_DIR)/%.s Makefile | $(BUILD_DIR)
	@echo Assembling: $<
	@$(AS) -c $(ASFLAGS) $< -o $@

# 链接
$(BUILD_DIR)/$(TARGET).elf: $(OBJECTS) Makefile
	@echo Linking objects...
	@$(CC) $(OBJECTS) $(LDFLAGS) -o $@
	@$(SZ) $@

# 创建hex文件
$(BUILD_DIR)/$(TARGET).hex: $(BUILD_DIR)/$(TARGET).elf
	@echo Creating HEX file...
	@$(CP) -O ihex $< $@

# 创建bin文件
$(BUILD_DIR)/$(TARGET).bin: $(BUILD_DIR)/$(TARGET).elf
	@echo Creating BIN file...
	@$(CP) -O binary -S $< $@

# 清理
clean:
	@echo Cleaning build files...
	@if exist "$(BUILD_DIR)" rmdir /S /Q "$(BUILD_DIR)"
	@echo Clean completed!

# 显示帮助
help:
	@echo "GD32F103RC USART Project Build Script"
	@echo "Usage: make [target]"
	@echo "Targets:"
	@echo "  all     - Build project (default)"
	@echo "  clean   - Clean build files"
	@echo "  help    - Show this help"

# 依赖
-include $(wildcard $(BUILD_DIR)/*.d)

# 伪目标
.PHONY: all clean help