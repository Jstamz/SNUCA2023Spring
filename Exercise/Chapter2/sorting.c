void swap(int v[], int idx) {
    int temp = v[idx];
    v[idx] = v[idx+1];
    v[idx+1] = temp;
}

void sort(int v[], int N) {
    for (int i = 0; i < N; i++)
    {
        for (int j = i - 1; j >= 0; j--)
        {
            if(v[j] > v[j+1]) {
                swap(v, j);
            }
        }
    }
}