int foo(long a, long b);

int bar(long a, long b);

int if_else(long a, long b) {
    int res;

    if(a >= b) res = foo(a, b);
    else res = bar(a, b);

    return res*2;
}