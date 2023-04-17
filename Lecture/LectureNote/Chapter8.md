Compoiste Data Structures
=========================

Data Alignment
--------------
- Basic rule : ***primitive type T variable V must saved in address that divisible with sizeof(T)***
1. Global variable
    - follow specific order! : depends on compiler
        - noramlly not follow delcaration order
    - properly aligned in **data section**

2. Local variable
    - allocated on **stack**
    - compiler reorder variables to minimize padding

Arrays
------
1. Declare
    - $<T_{base}>\ <name>[N_{outer}][N_{inner}]$
    - $<T_{base}>\ <name>[N_{D_n}]...[N_{D_2}][N_{D_1}]$

2. address
    - example : $arr[N3][N2][N1]$
        - $arr[i][j][k] = *(arr + k + N1\times(j + N2 \times k))$
    - Note that outermost array length doesn't used in memory access...
        - That's why we can declare array like this
            - int A[][N2][N1]; &rarr; blank outermost lenght

3. Multilevel Arrays
    - kind of array of pointers
    - each pointers could be a variable length array

cf) 3d array case example
```c
#define N1 3
#define N2 4
#define N3 5

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
}
```
Structs
-------
1. Data alignment
    - Two basic rules
        - ***all variable's first address must divislbe with size of variable***
        - ***total structure's size must divisible with largest size of it's element*** : due to struct array
    - For avoiding lot's of padding, must declare big size valiables first

Unions
------