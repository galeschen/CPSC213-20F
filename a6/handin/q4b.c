#include <stdio.h>
#include <stdlib.h>

int x[8] = {1, 2, 3, -1, -2, 0, 184, 340057058};
int y[8] = {0, 0, 0, 0, 0, 0, 0, 0};

int f(int a0) {
    int b = 0;
    while (a0 != 0) {
        // printf("\n%d a0:", a0);
        // printf("\n%d b:", b);
        if ((a0 & 0x80000000) == 0) {
            a0 = a0 * 2;
            // printf("\n made it to a0 inc");
        } else {
             b++;
             a0 = a0 * 2;
        }
    }
    return b;
}

int main() {
    for (int a = 8; a > 0; a--) {
        y[a-1] = f(x[a-1]);
    }

    for (int a = 0; a < 8; a++) {
        printf("%d\n", x[a]);
    }
    
    for (int a = 0; a < 8; a++) {
        printf("%d\n", y[a]);
    }
}
