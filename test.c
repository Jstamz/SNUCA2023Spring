#include "show_bytes.h"

int main(int argc, char *argv[])
{
    float pi = 0.125;

    printf("%f\n", pi);
    show_float(pi);
    printf("\n");

    float f1 = 3.125;
    float f2 = 4.25;

    show_float(f1);
    printf("\n");
    show_float(f2);
    printf("\n");
    show_float(f1 + f2);
    printf("\n");
    show_float(f1 * f2);
    printf("\n");
    printf("\n");
    printf("\n");
    int test = 1073740000;
    show_float((float)test);
    printf("\n");
}