#include "../../show_bytes.c"

//gcc -o float2intcasting float2intcasting.c ../../show_bytes.h
int main (int argc, char *argv[]) {
    float f1 = 1.8;
    float f2 = 2.8;

    int i1 = (int)f1;
    int i2 = (int)f2;

    show_bits_be((byte_pointer) &f1, sizeof(float));
    printf("\n");
    show_bits_be((byte_pointer) &i1, sizeof(int));
    printf("\n");
    show_bits_be((byte_pointer) &f2, sizeof(float));
    printf("\n");
    show_bits_be((byte_pointer) &i2, sizeof(int));
    printf("\n");
}