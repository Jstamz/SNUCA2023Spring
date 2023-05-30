long problem2(long N, int a[][N])
{
  long sum = 0;

  for (long i=0; i<N; i++) {
    sum += a[i][i];
  }

  return sum;
}
