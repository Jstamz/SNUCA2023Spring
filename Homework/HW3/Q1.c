#include "../../show_bytes.c"

//gcc -o Q1 Q1.c ../../show_bytes.h
int main (int argc, char *argv[]) {
    char a = 81;
    char b = 106;

    short s = a * b;

    show_bits_be((byte_pointer) &s, sizeof(short));
    printf("\n");
}