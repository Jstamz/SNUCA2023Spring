unsigned int q32(int *a, int idx, long N){
    if(N > 1000) {
        idx = 1000 - idx;
    }

    return a[idx];
}