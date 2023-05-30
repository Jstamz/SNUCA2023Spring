#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>

#define addr(x) printf(" %-8s: %4zu %8p\n", x, sizeof(x), &x)

double d;
float f;
void *p;

#ifdef __SIZEOF_INT128__
__int128 i128;
#endif

long long ll;
long l;
char c2;
int i;
short s;
char c1;

int main(void) {
    addr(d);
    addr(f);
    addr(p);
    #ifdef __SIZEOF_INT128__
    addr(i128);
    #endif
    addr(ll);
    addr(l);
    addr(c2);
    addr(i);
    addr(s);
    addr(c1);
    return EXIT_SUCCESS;
}