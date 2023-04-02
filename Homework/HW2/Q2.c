#include "../../show_bytes.h"

int main(int argc, char *argv[])
{
    short x = 0xB5D2;
    short y = 0x7E3A;
    short z = 0x5ABC;

    printf("%hx & %hx = %hx\n", x, y, x & y);
    printf("%hx | %hx = %hx\n", x, y, x | y);
    printf("%hx | (%hx & %hx) = %hx\n", x, y, z, x | (y & z));
    printf("~%hx | ~%hx = %hx\n", x, y, ~x | ~y);
    printf("%hx & !%hx = %hx\n", x, y, x & !y);

    printf("%hx & %hx = %hx\n", x, y, x && y);
    printf("%hx | %hx = %hx\n", x, y, x || y);
    printf("%hx | (%hx & %hx) = %hx\n", x, y, z, x || (y && z));
    printf("~%hx | ~%hx = %hx\n", x, y, !x || !y);
    printf("%hx & !%hx = %hx\n", x, y, x && ~y);
}