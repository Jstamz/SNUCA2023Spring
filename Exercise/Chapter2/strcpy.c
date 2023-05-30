void strcpy(char x[], char y[]) {
    int i = 0;

    while ((x[i] != '\0') || (y[i] != '\0'))
    {
        x[i] = y[i];
        i++;
    }
}