#include "operations.h"

int addnums(int x, int y) {
    int sum = x + y;
    return sum;
}

int subnums(int x, int y) {
    int result = x - y;
    return result;
}

int multnums(int x, int y) {
    int result = x * y;
    return result;
}

int divnums(int x, int y) {
    int result = x / y;
    return result;
}

int andnums(int x, int y) {
    int result = x & y;
    return result;
}

int ornums(int x, int y) {
    int result = x | y;
    return result;
}

int xornums(int x, int y) {
    int result = x ^ y;
    return result;
}

int lshiftnums(int x, int y) {
    int result = x << y;
    return result;
}

unsigned int rshiftnums(unsigned int x, int y) {
    int result = x >> y;
    return result;
}