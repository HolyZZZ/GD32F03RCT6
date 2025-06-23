@ 转换说明：
@ 1. 所有伪指令替换为GNU格式
@ 2. 标号后添加冒号(:)
@ 3. 注释符;替换为@
@ 4. 添加GNU汇编必需的头信息
@ 5. 弱引用处理使用.weak
@ 6. 函数添加类型和大小标记
@ 7. 保留原始逻辑结构和功能

.syntax unified     @ 使用统一汇编语法
.cpu cortex-m3      @ 指定Cortex-M3内核
.thumb              @ 使用Thumb指令集

@ =================== 堆栈配置 ===================
.equ Stack_Size, 0x00002000  @ 堆栈大小

.section .stack, "aw", %nobits @ 定义堆栈段
Stack_Mem:
    .space Stack_Size          @ 分配堆栈空间
    .size Stack_Mem, Stack_Size
    .global __initial_sp
__initial_sp:                  @ 栈顶指针

@ =================== 堆配置 ===================
.equ Heap_Size, 0x00002000    @ 堆大小

.section .heap, "aw", %nobits @ 定义堆段
    .global __heap_base
__heap_base:
Heap_Mem:
    .space Heap_Size           @ 分配堆空间
    .size Heap_Mem, Heap_Size
    .global __heap_limit
__heap_limit:

@ =================== 向量表 ===================
.section .isr_vector, "a"     @ 定义向量表段
    .global __Vectors
    .global __Vectors_End
    .global __Vectors_Size

__Vectors:
    .word   __initial_sp       @ 栈顶地址
    .word   Reset_Handler      @ 复位处理程序
    .word   NMI_Handler
    .word   HardFault_Handler
    .word   MemManage_Handler
    .word   BusFault_Handler
    .word   UsageFault_Handler
    .word   0                   @ 保留
    .word   0                   @ 保留
    .word   0                   @ 保留
    .word   0                   @ 保留
    .word   SVC_Handler
    .word   DebugMon_Handler
    .word   0                   @ 保留
    .word   PendSV_Handler
    .word   SysTick_Handler
    
    @ 外部中断处理程序
    .word   WWDGT_IRQHandler
    .word   LVD_IRQHandler
    @ ... (其他中断向量保持不变)
    .word   DMA1_Channel3_4_IRQHandler

__Vectors_End:
    .equ __Vectors_Size, __Vectors_End - __Vectors

@ =================== 代码段 ===================
.section .text
.thumb_func

@ 复位处理程序
Reset_Handler:
    .global Reset_Handler
    .weak Reset_Handler
    .type Reset_Handler, %function
Reset_Handler:
    ldr r0, =SystemInit
    blx r0
    ldr r0, =main
    bx r0
    .size Reset_Handler, . - Reset_Handler

@ 异常处理程序 (通用格式)
.macro DEFAULT_HANDLER handler_name
    .global \handler_name
    .weak \handler_name
    .type \handler_name, %function
\handler_name:
    b .
    .size \handler_name, . - \handler_name
.endm

@ 应用宏定义所有异常处理程序
DEFAULT_HANDLER NMI_Handler
DEFAULT_HANDLER HardFault_Handler
@ ... (为所有异常处理程序重复此模式)

@ 默认中断处理程序
Default_Handler:
    b .
    .size Default_Handler, . - Default_Handler

@ 弱引用所有中断处理程序
.weak WWDGT_IRQHandler
.set WWDGT_IRQHandler, Default_Handler
@ ... (为所有中断处理程序重复此模式)

@ =================== 堆栈/堆初始化 ===================
@ 使用microlib的情况
.ifdef __MICROLIB
    .global __initial_sp
    .global __heap_base
    .global __heap_limit
.else
    .global __user_initial_stackheap
    .type __user_initial_stackheap, %function
__user_initial_stackheap:
    ldr r0, =Heap_Mem
    ldr r1, =(Stack_Mem + Stack_Size)
    ldr r2, =(Heap_Mem + Heap_Size)
    ldr r3, =Stack_Mem
    bx lr
    .size __user_initial_stackheap, . - __user_initial_stackheap
.endif

.end