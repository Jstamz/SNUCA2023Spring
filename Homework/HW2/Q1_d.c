#include "../../show_bytes.c"

int main (int argc, char *argv[]) {
    int a = 0x1234;
    int b = 0x8e;

    printf("%x + %x = %x\n", a, b, a+b);
}