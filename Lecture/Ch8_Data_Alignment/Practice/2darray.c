#define N 10
#define M 100

int A[N][M];

int get(int i, int j)
{
    return A[i][j];
}

int sum(void)
{
    int i, j, sum = 0;

    for (i=0; i<N; i++) {
        for (j=0; j<M; j++) {
            sum += A[i][j];
        }
    }
    
    return sum;
} 