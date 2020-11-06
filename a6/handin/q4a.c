#include <stdio.h>
#include <stdlib.h>

int array[10] = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0};

void foo(int param1, int param2) {
    array[param2] = array[param2] + param1;
}

void b() {
    int a0 = 1;
    int a1 = 2;
    foo(3, 4);
    foo(a0, a1);
}

void main() {
    b();

    for(int i = 0; i < 10; i++) {
        printf("%d\n", array[i]);
    }
}