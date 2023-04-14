int sum(int *A, int length) {
    int ret = 0;

    for(int i = 0; i < length; i++) {
        ret += A[i];
    }

    return ret;
}