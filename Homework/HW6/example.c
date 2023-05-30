#include <stdlib.h>

long init(long *a, long from, long to)
{
  long ninit = 0;

  for (long i=from; i<to; i++) {
    a[i] = (unsigned long)random() % 1024;
    ninit++;
  }

  return ninit;
}