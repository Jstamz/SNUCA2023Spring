long foo(long a, unsigned long b, char *cp)
{
  char c = *cp;
  long sum=0;
  long n = a > b ? a-b : b-a;

  do {
    sum += n + c;
    n--;
  } while (n > 0);

  return sum;
}
