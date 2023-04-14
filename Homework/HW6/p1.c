long problem1(long i)
{
  long result;

  if (i < 2) result = 1;
  else result = problem1(i-1) + problem1(i-2);

  return result;
}
