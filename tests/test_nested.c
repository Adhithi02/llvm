/**
 * test_nested.c
 * Nested loop structures.
 *
 * matrix_mul  — classic O(n³) triply-nested loop (variable bounds)
 * unroll_candidate — outer variable, inner fixed-count (inner → unroll)
 */
#include <stdio.h>

volatile int sink;

#define N 64

// All three loops: variable (depth 1,2,3) — do not unroll
void matrix_mul(int a[N][N], int b[N][N], int c[N][N], int n) {
    for (int i = 0; i < n; i++)
        for (int j = 0; j < n; j++) {
            int acc = 0;
            for (int k = 0; k < n; k++)
                acc += a[i][k] * b[k][j];
            c[i][j] = acc;
        }
}

// Outer: variable (do not unroll), Inner: fixed 4 → full unroll
void unroll_candidate(int *arr, int n) {
    for (int i = 0; i < n; i++) {         // variable → do not unroll
        int sub = 0;
        for (int j = 0; j < 4; j++)       // constant 4 → full unroll
            sub += arr[i + j];
        sink += sub;
    }
}

// Outer: fixed 8 → full unroll; Inner: fixed 8 → full unroll
void double_fixed(void) {
    int sum = 0;
    for (int i = 0; i < 8; i++)
        for (int j = 0; j < 8; j++)
            sum += i * j;
    sink = sum;
}

int main(void) {
    int a[N][N], b[N][N], c[N][N];
    matrix_mul(a, b, c, N);
    int arr[64] = {0};
    unroll_candidate(arr, 60);
    double_fixed();
    return 0;
}