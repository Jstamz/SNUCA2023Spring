int sum(int *A, int length) {
    int ret = 0;
    int i = 0;

    if(length == 0) return 0;

    do {
        ret += A[i];
        i++;
    } while (i < length);

    return ret;
}