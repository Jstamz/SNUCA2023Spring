int sum(int *A, int length) {
    int ret = 0;
    int i = 0;

    while (i < length) {
        ret += A[i];
        i++;
    }
    

    return ret;
}