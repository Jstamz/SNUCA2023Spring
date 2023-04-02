#include "../../show_bytes.h"

int main(int argc, char *argv[])
{
    int i = -4190308;
    short s1 = -5000;
    short s = -5000 >> 8;
    unsigned char c1 = 144 + 127;
    char c2 = -100 - 44;

    show_bits_be((byte_pointer) &i, sizeof(int));
    printf("\n");
    show_bits_be((byte_pointer) &s1, sizeof(short));
    printf("\n");
    show_bits_be((byte_pointer) &s, sizeof(short));
    printf("\n");
    printf("%d\n", c1);
    printf("%d\n", c2);
}