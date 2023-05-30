#include "show_bytes.h"

int main(int argc, char *argv[])
{
    double d = 1.99999924952862784266471862793;
    float f = (float)d;

    show_double(d);
    printf("\n");
    show_float(f);
}