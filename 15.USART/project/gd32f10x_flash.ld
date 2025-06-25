/* GD32F103RC 链接脚本 */

MEMORY
{
  FLASH (rx)   : ORIGIN = 0x08000000, LENGTH = 128K
  RAM (xrw)    : ORIGIN = 0x20000000, LENGTH = 48K
}

/* 栈顶地址 (必须匹配启动文件) */
_estack = ORIGIN(RAM) + LENGTH(RAM);

/* 入口点 */
ENTRY(Reset_Handler)

/* 堆栈大小 (匹配启动文件设置) */
_Min_Heap_Size = 0x2000;     /* 8KB */
_Min_Stack_Size = 0x2000;    /* 8KB */
/*
PHDRS
{
    text PT_LOAD;
    data PT_LOAD;
    bss PT_LOAD;
}*/

SECTIONS
{
  /* 中断向量表 */
  .isr_vector :
  {
    . = ALIGN(4);
    KEEP(*(.isr_vector))
    . = ALIGN(4);
  } >FLASH

  /* 代码段 */
  .text :
  {
    . = ALIGN(4);
    *(.text)
    *(.text*)
    *(.glue_7)
    *(.glue_7t)
    *(.eh_frame)
    
    KEEP (*(.init))
    KEEP (*(.fini))
    
    . = ALIGN(4);
    _etext = .;
  } >FLASH

  /* 只读数据 */
  .rodata :
  {
    . = ALIGN(4);
    *(.rodata)
    *(.rodata*)
    . = ALIGN(4);
  } >FLASH

  /* ARM特定段 */
  .ARM.extab : { *(.ARM.extab*) } >FLASH
  .ARM : {
    __exidx_start = .;
    *(.ARM.exidx*)
    __exidx_end = .;
  } >FLASH

  /* 初始化数组 */
  .preinit_array :
  {
    PROVIDE_HIDDEN (__preinit_array_start = .);
    KEEP (*(.preinit_array*))
    PROVIDE_HIDDEN (__preinit_array_end = .);
  } >FLASH
  
  .init_array :
  {
    PROVIDE_HIDDEN (__init_array_start = .);
    KEEP (*(SORT(.init_array.*)))
    KEEP (*(.init_array*))
    PROVIDE_HIDDEN (__init_array_end = .);
  } >FLASH
  
  .fini_array :
  {
    PROVIDE_HIDDEN (__fini_array_start = .);
    KEEP (*(SORT(.fini_array.*)))
    KEEP (*(.fini_array*))
    PROVIDE_HIDDEN (__fini_array_end = .);
  } >FLASH

  /* 初始化数据 (加载到RAM但存储在FLASH) */
  _sidata = LOADADDR(.data);
  
  .data :
  {
    . = ALIGN(4);
    _sdata = .;
    *(.data)
    *(.data*)
    . = ALIGN(4);
    _edata = .;
  } >RAM AT> FLASH

  /* 未初始化数据 (BSS) */
  .bss :
  {
    . = ALIGN(4);
    _sbss = .;
    __bss_start__ = _sbss;
    *(.bss)
    *(.bss*)
    *(COMMON)
    . = ALIGN(4);
    _ebss = .;
    __bss_end__ = _ebss;
  } >RAM

  /************ 关键修改 ************/
  
  /* 专用堆段 (匹配启动文件) */
  .heap (NOLOAD) :
  {
    . = ALIGN(8);
    PROVIDE(__heap_base = .);
    . = . + _Min_Heap_Size;
    . = ALIGN(8);
    PROVIDE(__heap_limit = .);
  } >RAM

  /* 专用栈段 (位于RAM末尾) */
  .stack (NOLOAD) :
  {
    . = ALIGN(8);
    PROVIDE(__stack_start = .);
    . = . + _Min_Stack_Size;
    . = ALIGN(8);
    PROVIDE(__initial_sp = .); /* 栈顶指针 */
  } >RAM
  
  /*********************************/
  
  /* 库文件排除 */
  /DISCARD/ :
  {
    libc.a (*)
    libm.a (*)
    libgcc.a (*)
  }
  
  /* ARM属性 */
  .ARM.attributes 0 : { *(.ARM.attributes) }
  
  /* 调试信息 */
  .debug_info     0 : { *(.debug_info) }
  .debug_abbrev   0 : { *(.debug_abbrev) }
  .debug_loc      0 : { *(.debug_loc) }
  .debug_aranges  0 : { *(.debug_aranges) }
}