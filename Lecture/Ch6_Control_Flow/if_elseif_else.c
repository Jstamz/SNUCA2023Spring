long if_elseif_else(long a, long b, long c) {
    long ret = 0;
    
    if(a > b) a++;
    else if(b > c) b += 2;
    else c += 3;

    ret = a + b * c;

    return ret;
}