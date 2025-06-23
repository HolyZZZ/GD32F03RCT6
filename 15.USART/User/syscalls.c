#include <errno.h>
#include <sys/unistd.h>

int _close(int file)
{
    (void)file;
    return 0;       // 总是返回成功
}

int _lseek(int file, int ptr, int dir)
{
    (void)file;
    (void)ptr;
    (void)dir;
    return 0;       // 总是返回当前位置0
}

int _read(int file, char *ptr, int len)
{
    //未用到，可以不实现
    (void)file;
    (void)ptr;
    return 0;       // 返回0表示没有数据可读
}

int _write(int file, char *ptr, int len)
{
    //未用到，可以不实现
    (void)file;     // 避免未使用参数警告
    (void)ptr;      // 避免未使用参数警告
    return len;     // 假装所有数据都已写入
}