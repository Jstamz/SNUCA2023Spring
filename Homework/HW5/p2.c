long problem2(int *a, long start, long end, long exclude_start, long exclude_end)
{
  long chksum = -1;

  if (!a) return chksum;

  for (long p=start; p<end; p++) {
    if ((p < exclude_start) || (p >= exclude_end)) {
      chksum ^= a[p];
    }
  }

  return chksum;
}
