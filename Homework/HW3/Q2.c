#include "../../show_bytes.c"

//gcc -o Q2 Q2.c ../../show_bytes.h
int main (int argc, char *argv[]) {
    char a = 97;
    char b = 5;

    short s = a / b;

    show_bits_be((byte_pointer) &s, sizeof(short));
    printf("\n");
}