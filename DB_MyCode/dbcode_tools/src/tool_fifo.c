#include "tool_fifo.h"

// 队列初始化函数
uint8_t tool_fifo_init(T_FIFO_STRUCT *fifo, uint8_t *buffer, uint16_t size)
{
    // 参数检查
    if (fifo == NULL || buffer == NULL || size == 0) {
        return 0;
    }
    // 检查size是否超过最大值
    if (size > FD_FIFO_MAX_LEN) {
        return 0;
    }
    
    // 初始化FIFO结构
    memset(fifo, 0, sizeof(T_FIFO_STRUCT));
    fifo->buffer = buffer;
    fifo->size = size;
    fifo->count = 0;
    // 清空缓冲区
    memset(buffer, 0, size);
    return 1;
}

// 入队函数
uint8_t tool_fifo_input(T_FIFO_STRUCT *fifo, uint8_t data)
{
    // 检查参数和队列是否已满
    if (fifo == NULL || fifo->count >= fifo->size) {
        return 0;
    }
    
    // 存储数据
    fifo->buffer[fifo->in] = data;
    fifo->count++;
    fifo->in++;

    // 更新入队指针，如果到达缓冲区末尾则回到开始
    if (fifo->in >= fifo->size) {
        fifo->in = 0;
    }
    
    return 1;
}

// 出队函数
uint8_t tool_fifo_output(T_FIFO_STRUCT *fifo, uint8_t *data)
{
    // 检查参数和队列是否为空
    if (fifo == NULL || data == NULL || fifo->count == 0) {
        return 0;
    }
    
    // 获取数据
    *data = fifo->buffer[fifo->out];
    fifo->count--;
    
    // 更新出队指针，如果到达缓冲区末尾则回到开始
    fifo->out++;
    if (fifo->out >= fifo->size) {
        fifo->out = 0;
    }
    
    return 1;
}

// 清空队列函数
void tool_fifo_clear(T_FIFO_STRUCT *fifo)
{
    if (fifo != NULL) {
        fifo->in = 0;
        fifo->out = 0;
        fifo->count = 0;
    }
}

// 获取队列中数据个数
uint16_t tool_fifo_getcount(T_FIFO_STRUCT *fifo)
{
    if (fifo == NULL) {
        return 0;
    }
    return fifo->count;
}

// 检查队列是否为空
bool tool_fifo_empty(T_FIFO_STRUCT *fifo)
{
    if (fifo == NULL) {
        return 1;
    }
    return (fifo->count == 0);
}

// 检查队列是否已满
uint8_t tool_fifo_full(T_FIFO_STRUCT *fifo)
{
    if (fifo == NULL) {
        return 1;
    }
    return (fifo->count >= fifo->size);
}


