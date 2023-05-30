#include <stdio.h>
#define N1 3
#define N2 4
#define N3 5
#define N4 6

int a1[N3][N2][N1] = {{{}}};

int main(void) 
{
    int *p = (int *)a1;

    for (size_t i = 0; i < N3; i++) {
        for (size_t j = 0; j < N2; j++) {
            for (size_t k = 0; k < N1; k++) {
                p[k + N1*(j + N2*i)] = k + N1*(j + N2*i);
            }
        }
    }

    for (size_t i = 0; i < N3; i++) {
        for (size_t j = 0; j < N2; j++) {
            for (size_t k = 0; k < N1; k++) {
                printf("%d", *(p + k + N1*(j + N2*i)));
            }
        }
    }  
}