#include "show_bytes.h"

// Run with gcc show-bytes.c -o show-bytes && ./show-bytes

/* Show bytes in hex format */
void show_bytes(byte_pointer start, int len) {
    int i;
    for (i = 0; i < len; i++){
        printf(" %.2x", start[i]);
    }
}

/* Show single byte in bit format */
void show_byte_in_bits(byte_pointer start) {
    int i;
    for (i = 0; i < 8 ; i++){
        printf("%d", (*start & ( 1 << (i ^ 7) ))>0);
    }
}

/* Show bytes in hex format (Turn little endian to big endian) */
void show_bytes_be(byte_pointer start, int len) {
    int i;
    for (i = len -1 ; i >= 0; i--){
        printf(" %.2x", start[i]);
    }
}

/* Show bytes in bit format */
void show_bits(byte_pointer start, int len) {
    int i;
    for (i = 0; i < len; i++){
        show_byte_in_bits(start+i);
        printf(" ");
    }
}

/* Show bytes in bit format (Turn little endian to big endian) */
void show_bits_be(byte_pointer start, int len) {
    int i;
    for (i = len -1 ; i >= 0; i--){
        show_byte_in_bits(start+i);
        printf(" ");
    }
}

/* Show bit sequence of arbitrary length */
void bits(byte_pointer start, int len) {
    int i;
    for (i = 0; i < len; i++){
        if (i % 8 == 0)
            printf(" ");
        printf("%d",( *( start + (i >> 3) ) & ( 1 << (  (i & 7) ^ 7 ) ) ) > 0 );
    }
}

void show_char(char x) {
    printf("Character value [char:%c] [decimal:%d] [hex:0x%x]\n",x,x,x);
    printf("little endian:\t[");
    show_bytes((byte_pointer) &x, sizeof(char));
    printf(" ]\t[");
    show_bits((byte_pointer) &x, sizeof(char));
    printf("]\n");

    printf("big    endian:\t[");
    show_bytes_be((byte_pointer) &x, sizeof(char));
    printf(" ]\t[");
    show_bits_be((byte_pointer) &x, sizeof(char));
    printf("]");
}

void show_short(short x) {
    printf("Short Integer value [decimal:%d] [hex:0x%x]\n",x,x);
    printf("little endian:\t[");
    show_bytes((byte_pointer) &x, sizeof(short));
    printf(" ]\t[");
    show_bits((byte_pointer) &x, sizeof(short));
    printf("]\n");

    printf("big    endian:\t[");
    show_bytes_be((byte_pointer) &x, sizeof(short));
    printf(" ]\t[");
    show_bits_be((byte_pointer) &x, sizeof(short));
    printf("]");
}

void show_int(int x) {
    printf("Integer value [decimal:%d] [hex:0x%x]\n",x,x);
    printf("little endian:\t[");
    show_bytes((byte_pointer) &x, sizeof(int));
    printf(" ]\t[");
    show_bits((byte_pointer) &x, sizeof(int));
    printf("]\n");

    printf("big    endian:\t[");
    show_bytes_be((byte_pointer) &x, sizeof(int));
    printf(" ]\t[");
    show_bits_be((byte_pointer) &x, sizeof(int));
    printf("]");
}

void show_long(long x) {
    printf("Long Integer value [decimal:%ld] [hex:0x%lx]\n",x,x);
    printf("little endian:\t[");
    show_bytes((byte_pointer) &x, sizeof(long));
    printf(" ]\t[");
    show_bits((byte_pointer) &x, sizeof(long));
    printf("]\n");

    printf("big    endian:\t[");
    show_bytes_be((byte_pointer) &x, sizeof(long));
    printf(" ]\t[");
    show_bits_be((byte_pointer) &x, sizeof(long));
    printf("]");
}

void show_float(float x) {
    printf("Float value [decimal:%f]\n",x);
    printf("little endian:\t[");
    show_bytes((byte_pointer) &x, sizeof(float));
    printf(" ]\t[");
    show_bits((byte_pointer) &x, sizeof(float));
    printf("]\n");

    printf("big    endian:\t[");
    show_bytes_be((byte_pointer) &x, sizeof(float));
    printf(" ]\t[");
    show_bits_be((byte_pointer) &x, sizeof(float));
    printf("]");
}

void show_double(double x) {
    printf("Double value [decimal:%lf]\n",x);
    printf("little endian:\t[");
    show_bytes((byte_pointer) &x, sizeof(double));
    printf(" ]\t[");
    show_bits((byte_pointer) &x, sizeof(double));
    printf("]\n");

    printf("big    endian:\t[");
    show_bytes_be((byte_pointer) &x, sizeof(double));
    printf(" ]\t[");
    show_bits_be((byte_pointer) &x, sizeof(double));
    printf("]");
}

void show_pointer(void *x){
    printf("Pointer value [decimal:%d] [hex: %x]\n",(int)(x), (int)(x));
    printf("little endian:\t[");
    show_bytes((byte_pointer) &x, sizeof(void *));
    printf(" ]\t[");
    show_bits((byte_pointer) &x, sizeof(void *));
    printf("]\n");

    printf("big    endian:\t[");
    show_bytes_be((byte_pointer) &x, sizeof(void *));
    printf(" ]\t[");
    show_bits_be((byte_pointer) &x, sizeof(void *));
    printf("]");
}

void test_show_bytes(int val){
    int ival = val;
    float fval = (float) ival;
    int *pval = &ival;

    show_int(ival);
    printf("\n");

    show_float(fval);
    printf("\n");

    show_pointer(pval);
    printf("\n");
}

// int main(int argc, char *argv[]) {
//     //gcc show-bytes.c -o show-bytes && ./show-bytes
//     int val;
//     if (argc > 2) {
//         switch (argv[1][0])
//         {
//             case 'c':
//                 char temp1;
//                 sscanf(argv[2], "%c", &temp1);
//                 show_char(temp1);
//                 break;
//             case 's':
//                 short temp2;
//                 sscanf(argv[2], "%hd", &temp2);
//                 show_short(temp2);
//                 break;
//             case 'd':
//                 int temp3;
//                 sscanf(argv[2], "%d", &temp3);
//                 show_int(temp3);
//                 break;
//             case 'h':
//                 int temp4;
//                 sscanf(argv[2], "%x", &temp4);
//                 show_int(temp4);
//                 break;
//             case 'f':
//                 float temp5;
//                 sscanf(argv[2], "%f", &temp5);
//                 show_float(temp5);
//                 break;
//             case 'l':
//                 double temp6;
//                 sscanf(argv[2], "%lf", &temp6);
//                 show_double(temp6);
//                 break;
//             default:
//                 break;
//         }
//         printf("\n");
//     }

//     return 0;
// }