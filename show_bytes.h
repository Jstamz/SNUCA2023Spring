#include <stdio.h>
#include <string.h>
typedef unsigned char *byte_pointer;

// Run with gcc show-bytes.c -o show-bytes && ./show-bytes

/* Show bytes in hex format */
void show_bytes(byte_pointer start, int len);

/* Show single byte in bit format */
void show_byte_in_bits(byte_pointer start);

/* Show bytes in hex format (Turn little endian to big endian) */
void show_bytes_be(byte_pointer start, int len);

/* Show bytes in bit format */
void show_bits(byte_pointer start, int len);

/* Show bytes in bit format (Turn little endian to big endian) */
void show_bits_be(byte_pointer start, int len);

/* Show bit sequence of arbitrary length */
void bits(byte_pointer start, int len);

void show_char(char x);

void show_short(short x);

void show_int(int x);

void show_long(long x);

void show_float(float x);

void show_double(double x);

void show_pointer(void *x);

void test_show_bytes(int val);