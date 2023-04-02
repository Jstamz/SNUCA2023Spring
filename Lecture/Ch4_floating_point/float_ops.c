#include "../../show_bytes.c"
#include <math.h>

//gcc -o float_ops float_ops.c ../../show_bytes.h -lm
int main (int argc, char *argv[]) {
    float f1 = 0.5;
    float f2 = -0.4375;

    float ret_add = f1 + f2;
    float ret_mul = f1 * f2;

    show_bits_be((byte_pointer) &f1, sizeof(float));
    printf("\n");
    show_bits_be((byte_pointer) &f2, sizeof(float));
    printf("\n");
    show_bits_be((byte_pointer) &ret_add, sizeof(float));
    printf("\n");
    show_bits_be((byte_pointer) &ret_mul, sizeof(float));
    printf("\n");
}