#include "kernel_usart.h"

static uint8_t g_aiUsart0_RecvBuf[USART0_RECV_MAXLEN] = {
    0,
};

void kernel_usart0_init(void) {
    uint8_t bufp[1024] = "My name is Holy";

    rcu_periph_clock_enable(USART0_GPIORCC);  // 使能GPIOB时钟

    /* enable USART clock */

    rcu_periph_clock_enable(USART0_RCC);                                        // 使能USART0时钟
    gpio_pin_remap_config(GPIO_USART0_REMAP, ENABLE);                           // PB6,PB7需要重映射
    gpio_init(USART0_GPIO, GPIO_MODE_AF_PP, GPIO_OSPEED_50MHZ, USART0_TX_PIN);  // PB6输出

    /* configure USART Rx as alternate function push-pull */
    gpio_init(USART0_GPIO, GPIO_MODE_IN_FLOATING, GPIO_OSPEED_50MHZ, USART0_RX_PIN);  // PB7输入

    /* USART configure */
    usart_deinit(USART0);
    usart_baudrate_set(USART0, USART_BAUD);
    usart_word_length_set(USART0, USART_WL_8BIT);
    usart_stop_bit_set(USART0, USART_STB_1BIT);
    usart_parity_config(USART0, USART_PM_NONE);
    usart_hardware_flow_rts_config(USART0, USART_RTS_DISABLE);
    usart_hardware_flow_cts_config(USART0, USART_CTS_DISABLE);
    usart_transmit_config(USART0, USART_TRANSMIT_ENABLE);
    usart_receive_config(USART0, USART_RECEIVE_ENABLE);
    usart_enable(USART0);  // 使能USART0
}