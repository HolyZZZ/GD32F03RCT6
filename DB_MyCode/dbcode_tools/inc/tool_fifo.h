#ifndef TOOL_FIFO_H
#define TOOL_FIFO_H

#include "tool_define.h"

#define FD_FIFO_MAX_LEN 1024

typedef struct {
    uint8_t *buffer;      // 缓冲区指针
    uint16_t size;        // 缓冲区大小
    uint16_t in;          // 入队指针
    uint16_t out;         // 出队指针
    uint16_t count;       // 当前数据计数
} T_FIFO_STRUCT;

uint8_t tool_fifo_init(T_FIFO_STRUCT *fifo, uint8_t *buffer, uint16_t size);
uint8_t tool_fifo_input(T_FIFO_STRUCT *fifo, uint8_t data);
uint8_t tool_fifo_output(T_FIFO_STRUCT *fifo, uint8_t *data);
void tool_fifo_clear(T_FIFO_STRUCT *fifo);
uint16_t tool_fifo_getcount(T_FIFO_STRUCT *fifo);
bool tool_fifo_empty(T_FIFO_STRUCT *fifo);
bool tool_fifo_full(T_FIFO_STRUCT *fifo);


#endif