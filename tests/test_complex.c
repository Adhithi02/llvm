/**
 * test_complex.c
 * Edge cases: loops with calls, early exits, and non-linear induction.
 */
#include <stdio.h>
#include <math.h>

volatile double dsink;
volatile int isink;

// Loop with a library call — do not unroll even if trip count known
void loop_with_call(int n) {
    double acc = 0.0;
    for (int i = 0; i < n; i++)
        acc += sqrt((double)i);   // call to sqrt
    dsink = acc;
}

// Early exit (break) — SE may not compute exact trip count
void loop_early_exit(int *arr, int n) {
    for (int i = 0; i < n; i++) {
        if (arr[i] == 0) break;
        isink += arr[i];
    }
}

// Exponential induction variable  (i = i * 2)
// SE can represent it but cannot give a small constant trip count
void loop_exp_stride(void) {
    int product = 1;
    for (int i = 1; i < 1024; i *= 2)   // 10 iters, but SE sees recurrence
        product *= i;
    isink = product;
}

// Small fixed loop WITH a call — call presence should block unroll
void small_loop_call(void) {
    for (int i = 0; i < 4; i++)
        printf("%d ", i);           // call blocks unroll despite tiny TC
    printf("\n");
}

int main(void) {
    loop_with_call(100);
    int arr[] = {1,2,3,0,5};
    loop_early_exit(arr, 5);
    loop_exp_stride();
    small_loop_call();
    return 0;
}