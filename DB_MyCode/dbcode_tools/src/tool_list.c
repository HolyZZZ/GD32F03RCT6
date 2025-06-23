#include "tool_list.h"



LinkedList* tool_list_creat(void) {
    LinkedList* listhead = tool_malloc(sizeof(LinkedList));
    if(listhead == NULL) {
        return NULL;
    } else {
        listhead->head = NULL;
        listhead->tail = NULL;
        listhead->size = 0;
        return listhead;
    }
}