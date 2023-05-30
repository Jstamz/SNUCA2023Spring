long problem1(long a, long b, long c, long d)
{
  long p1 = 48*a + 36*b - c*d;
  if (a << 1 > b >> 1) p1 -= c;
  if ((b & 0xffff) > 0x8765) c += d;
  p1 += c;

  return p1;
}
