#ifndef TOOL_LIST_H
#define TOOL_LIST_H

#include "tool_define.h"

// 通用链表节点结构
typedef struct Node {
    void* data;          // 指向任意类型的数据
    struct Node* next;   // 指向下一个节点
} Node;

// 通用链表结构
typedef struct {
    Node* head;          // 指向链表头节点
    Node* tail;          // 指向链表尾节点
    uint32_t size;       // 链表元素数量
} LinkedList;

#endif