#define WSIZE 8*sizeof(long)

long pconut_for(unsigned long x) {
    long result = 0;

    for (int i = 0; i < WSIZE; i++)
    {
        unsigned long mask = 1 << i;
        result += (x & mask) != 0;
    }

    return result;
}