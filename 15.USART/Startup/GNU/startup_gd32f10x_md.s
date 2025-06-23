; GNU Assembler (GAS) compatible startup file for GD32F10x Medium-density devices

.syntax unified
.cpu cortex-m3
.thumb

.equ Stack_Size, 0x00002000

.section .stack, "noinit", %nobits
.align 3
Stack_Mem:
.space Stack_Size
.global __initial_sp
__initial_sp:

.equ Heap_Size, 0x00002000

.section .heap, "noinit", %nobits
.align 3
.global __heap_base
__heap_base:
Heap_Mem:
.space Heap_Size
.global __heap_limit
__heap_limit:

.section .vectors, "a", %progbits
.align 2
.global __Vectors
.global __Vectors_End
.global __Vectors_Size

__Vectors:
.word __initial_sp
.word Reset_Handler
.word NMI_Handler
.word HardFault_Handler
.word MemManage_Handler
.word BusFault_Handler
.word UsageFault_Handler
.word 0
.word 0
.word 0
.word 0
.word SVC_Handler
.word DebugMon_Handler
.word 0
.word PendSV_Handler
.word SysTick_Handler

.word WWDGT_IRQHandler
.word LVD_IRQHandler
.word TAMPER_IRQHandler
.word RTC_IRQHandler
.word FMC_IRQHandler
.word RCU_IRQHandler
.word EXTI0_IRQHandler
.word EXTI1_IRQHandler
.word EXTI2_IRQHandler
.word EXTI3_IRQHandler
.word EXTI4_IRQHandler
.word DMA0_Channel0_IRQHandler
.word DMA0_Channel1_IRQHandler
.word DMA0_Channel2_IRQHandler
.word DMA0_Channel3_IRQHandler
.word DMA0_Channel4_IRQHandler
.word DMA0_Channel5_IRQHandler
.word DMA0_Channel6_IRQHandler
.word ADC0_1_IRQHandler
.word USBD_HP_CAN0_TX_IRQHandler
.word USBD_LP_CAN0_RX0_IRQHandler
.word CAN0_RX1_IRQHandler
.word CAN0_EWMC_IRQHandler
.word EXTI5_9_IRQHandler
.word TIMER0_BRK_IRQHandler
.word TIMER0_UP_IRQHandler
.word TIMER0_TRG_CMT_IRQHandler
.word TIMER0_Channel_IRQHandler
.word TIMER1_IRQHandler
.word TIMER2_IRQHandler
.word TIMER3_IRQHandler
.word I2C0_EV_IRQHandler
.word I2C0_ER_IRQHandler
.word I2C1_EV_IRQHandler
.word I2C1_ER_IRQHandler
.word SPI0_IRQHandler
.word SPI1_IRQHandler
.word USART0_IRQHandler
.word USART1_IRQHandler
.word USART2_IRQHandler
.word EXTI10_15_IRQHandler
.word RTC_Alarm_IRQHandler
.word USBD_WKUP_IRQHandler
.word 0
.word 0
.word 0
.word 0
.word 0
.word EXMC_IRQHandler

__Vectors_End:

.equ __Vectors_Size, (__Vectors_End - __Vectors)

.text

.global Reset_Handler
.weak Reset_Handler
.type Reset_Handler, %function
Reset_Handler:
.extern __main
.extern SystemInit
LDR     R0, =SystemInit
BLX     R0
LDR     R0, =__main
BX      R0
.size Reset_Handler, .-Reset_Handler

.global NMI_Handler
.weak NMI_Handler
.type NMI_Handler, %function
NMI_Handler:
B       .
.size NMI_Handler, .-NMI_Handler

.global HardFault_Handler
.weak HardFault_Handler
.type HardFault_Handler, %function
HardFault_Handler:
B       .
.size HardFault_Handler, .-HardFault_Handler

.global MemManage_Handler
.weak MemManage_Handler
.type MemManage_Handler, %function
MemManage_Handler:
B       .
.size MemManage_Handler, .-MemManage_Handler

.global BusFault_Handler
.weak BusFault_Handler
.type BusFault_Handler, %function
BusFault_Handler:
B       .
.size BusFault_Handler, .-BusFault_Handler

.global UsageFault_Handler
.weak UsageFault_Handler
.type UsageFault_Handler, %function
UsageFault_Handler:
B       .
.size UsageFault_Handler, .-UsageFault_Handler

.global SVC_Handler
.weak SVC_Handler
.type SVC_Handler, %function
SVC_Handler:
B       .
.size SVC_Handler, .-SVC_Handler

.global DebugMon_Handler
.weak DebugMon_Handler
.type DebugMon_Handler, %function
DebugMon_Handler:
B       .
.size DebugMon_Handler, .-DebugMon_Handler

.global PendSV_Handler
.weak PendSV_Handler
.type PendSV_Handler, %function
PendSV_Handler:
B       .
.size PendSV_Handler, .-PendSV_Handler

.global SysTick_Handler
.weak SysTick_Handler
.type SysTick_Handler, %function
SysTick_Handler:
B       .
.size SysTick_Handler, .-SysTick_Handler

.global Default_Handler
.weak Default_Handler
.type Default_Handler, %function
Default_Handler:

.global WWDGT_IRQHandler
.weak WWDGT_IRQHandler
.global LVD_IRQHandler
.weak LVD_IRQHandler
.global TAMPER_IRQHandler
.weak TAMPER_IRQHandler
.global RTC_IRQHandler
.weak RTC_IRQHandler
.global FMC_IRQHandler
.weak FMC_IRQHandler
.global RCU_IRQHandler
.weak RCU_IRQHandler
.global EXTI0_IRQHandler
.weak EXTI0_IRQHandler
.global EXTI1_IRQHandler
.weak EXTI1_IRQHandler
.global EXTI2_IRQHandler
.weak EXTI2_IRQHandler
.global EXTI3_IRQHandler
.weak EXTI3_IRQHandler
.global EXTI4_IRQHandler
.weak EXTI4_IRQHandler
.global DMA0_Channel0_IRQHandler
.weak DMA0_Channel0_IRQHandler
.global DMA0_Channel1_IRQHandler
.weak DMA0_Channel1_IRQHandler
.global DMA0_Channel2_IRQHandler
.weak DMA0_Channel2_IRQHandler
.global DMA0_Channel3_IRQHandler
.weak DMA0_Channel3_IRQHandler
.global DMA0_Channel4_IRQHandler
.weak DMA0_Channel4_IRQHandler
.global DMA0_Channel5_IRQHandler
.weak DMA0_Channel5_IRQHandler
.global DMA0_Channel6_IRQHandler
.weak DMA0_Channel6_IRQHandler
.global ADC0_1_IRQHandler
.weak ADC0_1_IRQHandler
.global USBD_HP_CAN0_TX_IRQHandler
.weak USBD_HP_CAN0_TX_IRQHandler
.global USBD_LP_CAN0_RX0_IRQHandler
.weak USBD_LP_CAN0_RX0_IRQHandler
.global CAN0_RX1_IRQHandler
.weak CAN0_RX1_IRQHandler
.global CAN0_EWMC_IRQHandler
.weak CAN0_EWMC_IRQHandler
.global EXTI5_9_IRQHandler
.weak EXTI5_9_IRQHandler
.global TIMER0_BRK_IRQHandler
.weak TIMER0_BRK_IRQHandler
.global TIMER0_UP_IRQHandler
.weak TIMER0_UP_IRQHandler
.global TIMER0_TRG_CMT_IRQHandler
.weak TIMER0_TRG_CMT_IRQHandler
.global TIMER0_Channel_IRQHandler
.weak TIMER0_Channel_IRQHandler
.global TIMER1_IRQHandler
.weak TIMER1_IRQHandler
.global TIMER2_IRQHandler
.weak TIMER2_IRQHandler
.global TIMER3_IRQHandler
.weak TIMER3_IRQHandler
.global I2C0_EV_IRQHandler
.weak I2C0_EV_IRQHandler
.global I2C0_ER_IRQHandler
.weak I2C0_ER_IRQHandler
.global I2C1_EV_IRQHandler
.weak I2C1_EV_IRQHandler
.global I2C1_ER_IRQHandler
.weak I2C1_ER_IRQHandler
.global SPI0_IRQHandler
.weak SPI0_IRQHandler
.global SPI1_IRQHandler
.weak SPI1_IRQHandler
.global USART0_IRQHandler
.weak USART0_IRQHandler
.global USART1_IRQHandler
.weak USART1_IRQHandler
.global USART2_IRQHandler
.weak USART2_IRQHandler
.global EXTI10_15_IRQHandler
.weak EXTI10_15_IRQHandler
.global RTC_Alarm_IRQHandler
.weak RTC_Alarm_IRQHandler
.global USBD_WKUP_IRQHandler
.weak USBD_WKUP_IRQHandler
.global EXMC_IRQHandler
.weak EXMC_IRQHandler

.type WWDGT_IRQHandler, %function
WWDGT_IRQHandler:
.type LVD_IRQHandler, %function
LVD_IRQHandler:
.type TAMPER_IRQHandler, %function
TAMPER_IRQHandler:
.type RTC_IRQHandler, %function
RTC_IRQHandler:
.type FMC_IRQHandler, %function
FMC_IRQHandler:
.type RCU_IRQHandler, %function
RCU_IRQHandler:
.type EXTI0_IRQHandler, %function
EXTI0_IRQHandler:
.type EXTI1_IRQHandler, %function
EXTI1_IRQHandler:
.type EXTI2_IRQHandler, %function
EXTI2_IRQHandler:
.type EXTI3_IRQHandler, %function
EXTI3_IRQHandler:
.type EXTI4_IRQHandler, %function
EXTI4_IRQHandler:
.type DMA0_Channel0_IRQHandler, %function
DMA0_Channel0_IRQHandler:
.type DMA0_Channel1_IRQHandler, %function
DMA0_Channel1_IRQHandler:
.type DMA0_Channel2_IRQHandler, %function
DMA0_Channel2_IRQHandler:
.type DMA0_Channel3_IRQHandler, %function
DMA0_Channel3_IRQHandler:
.type DMA0_Channel4_IRQHandler, %function
DMA0_Channel4_IRQHandler:
.type DMA0_Channel5_IRQHandler, %function
DMA0_Channel5_IRQHandler:
.type DMA0_Channel6_IRQHandler, %function
DMA0_Channel6_IRQHandler:
.type ADC0_1_IRQHandler, %function
ADC0_1_IRQHandler:
.type USBD_HP_CAN0_TX_IRQHandler, %function
USBD_HP_CAN0_TX_IRQHandler:
.type USBD_LP_CAN0_RX0_IRQHandler, %function
USBD_LP_CAN0_RX0_IRQHandler:
.type CAN0_RX1_IRQHandler, %function
CAN0_RX1_IRQHandler:
.type CAN0_EWMC_IRQHandler, %function
CAN0_EWMC_IRQHandler:
.type EXTI5_9_IRQHandler, %function
EXTI5_9_IRQHandler:
.type TIMER0_BRK_IRQHandler, %function
TIMER0_BRK_IRQHandler:
.type TIMER0_UP_IRQHandler, %function
TIMER0_UP_IRQHandler:
.type TIMER0_TRG_CMT_IRQHandler, %function
TIMER0_TRG_CMT_IRQHandler:
.type TIMER0_Channel_IRQHandler, %function
TIMER0_Channel_IRQHandler:
.type TIMER1_IRQHandler, %function
TIMER1_IRQHandler:
.type TIMER2_IRQHandler, %function
TIMER2_IRQHandler:
.type TIMER3_IRQHandler, %function
TIMER3_IRQHandler:
.type I2C0_EV_IRQHandler, %function
I2C0_EV_IRQHandler:
.type I2C0_ER_IRQHandler, %function
I2C0_ER_IRQHandler:
.type I2C1_EV_IRQHandler, %function
I2C1_EV_IRQHandler:
.type I2C1_ER_IRQHandler, %function
I2C1_ER_IRQHandler:
.type SPI0_IRQHandler, %function
SPI0_IRQHandler:
.type SPI1_IRQHandler, %function
SPI1_IRQHandler:
.type USART0_IRQHandler, %function
USART0_IRQHandler:
.type USART1_IRQHandler, %function
USART1_IRQHandler:
.type USART2_IRQHandler, %function
USART2_IRQHandler:
.type EXTI10_15_IRQHandler, %function
EXTI10_15_IRQHandler:
.type RTC_Alarm_IRQHandler, %function
RTC_Alarm_IRQHandler:
.type USBD_WKUP_IRQHandler, %function
USBD_WKUP_IRQHandler:
.type EXMC_IRQHandler, %function
EXMC_IRQHandler:

B       .
.size Default_Handler, .-Default_Handler

.macro  def_irq_handler handler_name
.weak   handler_name
.set    handler_name, Default_Handler
.endm

def_irq_handler WWDGT_IRQHandler
def_irq_handler LVD_IRQHandler
def_irq_handler TAMPER_IRQHandler
def_irq_handler RTC_IRQHandler
def_irq_handler FMC_IRQHandler
def_irq_handler RCU_IRQHandler
def_irq_handler EXTI0_IRQHandler
def_irq_handler EXTI1_IRQHandler
def_irq_handler EXTI2_IRQHandler
def_irq_handler EXTI3_IRQHandler
def_irq_handler EXTI4_IRQHandler
def_irq_handler DMA0_Channel0_IRQHandler
def_irq_handler DMA0_Channel1_IRQHandler
def_irq_handler DMA0_Channel2_IRQHandler
def_irq_handler DMA0_Channel3_IRQHandler
def_irq_handler DMA0_Channel4_IRQHandler
def_irq_handler DMA0_Channel5_IRQHandler
def_irq_handler DMA0_Channel6_IRQHandler
def_irq_handler ADC0_1_IRQHandler
def_irq_handler USBD_HP_CAN0_TX_IRQHandler
def_irq_handler USBD_LP_CAN0_RX0_IRQHandler
def_irq_handler CAN0_RX1_IRQHandler
def_irq_handler CAN0_EWMC_IRQHandler
def_irq_handler EXTI5_9_IRQHandler
def_irq_handler TIMER0_BRK_IRQHandler
def_irq_handler TIMER0_UP_IRQHandler
def_irq_handler TIMER0_TRG_CMT_IRQHandler
def_irq_handler TIMER0_Channel_IRQHandler
def_irq_handler TIMER1_IRQHandler
def_irq_handler TIMER2_IRQHandler
def_irq_handler TIMER3_IRQHandler
def_irq_handler I2C0_EV_IRQHandler
def_irq_handler I2C0_ER_IRQHandler
def_irq_handler I2C1_EV_IRQHandler
def_irq_handler I2C1_ER_IRQHandler
def_irq_handler SPI0_IRQHandler
def_irq_handler SPI1_IRQHandler
def_irq_handler USART0_IRQHandler
def_irq_handler USART1_IRQHandler
def_irq_handler USART2_IRQHandler
def_irq_handler EXTI10_15_IRQHandler
def_irq_handler RTC_Alarm_IRQHandler
def_irq_handler USBD_WKUP_IRQHandler
def_irq_handler EXMC_IRQHandler

.align 4

#ifdef __MICROLIB

.global __initial_sp
.global __heap_base
.global __heap_limit

#else

.extern __use_two_region_memory
.global __user_initial_stackheap

__user_initial_stackheap:
LDR     R0, =  Heap_Mem
LDR     R1, =(Stack_Mem + Stack_Size)
LDR     R2, = (Heap_Mem +  Heap_Size)
LDR     R3, = Stack_Mem
BX      LR

#endif

.end

