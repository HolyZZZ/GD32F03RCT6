#ifndef __TOOL_DEFINE_H__   
#define __TOOL_DEFINE_H__

#include <stdio.h>
#include <string.h>
#include <stdint.h>
#include <stdbool.h>

uint16_t tool_goto_str(char* str,char st);
void tool_hextostr(char *pbDest,char *pbSrc,uint16_t iLen );
void tool_strtohex(unsigned char *pbDest, unsigned char *pbSrc, uint16_t iLen);
void tool_output_hex( int8_t *pData, uint16_t iLen);
uint8_t tool_memstrstr(uint8_t* dst,uint8_t* src,uint32_t lenth);

void tool_getstr_form_character(char *szInput, \
    uint16_t iPos,\
    char cSplit,
    char *szOutBuf,\
     uint16_t iBuffLen);

void* tool_malloc(uint32_t size);
void tool_free(void* ptr);

#endif