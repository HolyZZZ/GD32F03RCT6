#include "tool_define.h"

void tool_output_hex( int8_t *pData, uint16_t iLen) {
	char szBuf[256];
	char szTmp[5];

	uint8_t *p = pData;
	uint8_t i;

	// 清空缓存
	szBuf[0] = 0;

	// 不显示太多，要不然卡死
	if( iLen > 256 )
		iLen = 256;

	while ( iLen > 0 ) { 
		uint8_t iSend;

		iSend = min(iLen,30);
		for ( i = 0; i < iSend; i ++ ) {
			/* 加快打印速度 */
			szTmp[0] = "0123456789abcdef"[(p[i]&0xff)/16];
			szTmp[1] = "0123456789abcdef"[(p[i]&0xff)%16];
			szTmp[2] = ' ';
			szTmp[3] = '\0';
//			sprintf(szTmp, "%02x,", p[i]& 0xff);
			strcat( szBuf, szTmp );
		}

		iLen = iLen - iSend;
		p = p + iSend;
		TBIT_TOOL_LOG("HEX[%s]\r\n", szBuf);
		szBuf[0] = 0;  // 清空
	}
}

void tool_strtohex(unsigned char *pbDest, unsigned char *pbSrc, uint16_t iLen) {
  char h1,h2;
  char s1,s2;
  uint16_t i;
 
  for(i = 0 ; i < iLen ; i++) {
		h1 = pbSrc[2*i];
		h2 = pbSrc[2*i+1];

		s1 = toupper(h1) - 0x30;
		if(s1 > 9)
		s1 -= 7;
		s2 = toupper(h2) - 0x30;
		if(s2 > 9)
		s2 -= 7;
		pbDest[i] = s1*16 + s2;
  }
}
void tool_hextostr(char *pbDest,char *pbSrc,uint16_t iLen ) {
    char ddl,ddh;
    uint16_t i;

    for (i=0; i<iLen; i++) {
        ddh = 48 + pbSrc[i] / 16;
        ddl = 48 + pbSrc[i] % 16;
        if (ddh > 57) ddh = ddh + 7;
        if (ddl > 57) ddl = ddl + 7;
        pbDest[i*2] = ddh;
        pbDest[i*2+1] = ddl;
    }
    pbDest[iLen*2] = '\0';
}

uint8_t tool_memstrstr(uint8_t* dst,uint8_t* src,uint32_t lenth)
{
	uint8_t j = 0;
	for(uint8_t i = 0; i < lenth; i++)
	{
		if(dst[i] == src[0])
		{
			for(j = 0; j < strlen(src); j++)
			{
				if(dst[i + j] != src[j])
				{
					break;
				}
			}
			if(j == strlen(src))
			{
				return 1;
			}
		}
	}
	return 0;
}

uint16_t tool_goto_str(char* str,char st) {
	uint16_t i = 0;
	for(i = 0 ; i < strlen(str); i++) {
		if(str[i] == st)
		break;
	}
	return i + 1;
		
}

void tool_getstr_form_character(char *szInput, \
                        uint16_t iPos,\
                        char cSplit,
                        char *szOutBuf,\
                         uint16_t iBuffLen) {
	uint16_t i = 0;
	char   *c = szInput;
	char   *p = szOutBuf;

	if (szInput == NULL)
		return;

	while ( *c != '\0' ) {
		if(i == iPos &&  *c != cSplit) {
			*p++ = *c;

			if( p >= (szOutBuf + iBuffLen - 1) )
				break;
		}
		else if(i > iPos) {
			break;
		}

		if( *c == cSplit) {
			i++;
		}
		c++;
	}
	*p = '\0';
}
void* tool_malloc(uint32_t size) {
    return (void*)malloc(size);
}
void tool_free(void* ptr) {
    free(ptr);
}

