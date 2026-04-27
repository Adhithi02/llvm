/**
 * test_variable.c
 * Loops whose bounds depend on runtime values.
 * ScalarEvolution can still build symbolic SCEV expressions for these,
 * but cannot yield a compile-time constant trip count.
 *
 * Expected advisor output: "Do not unroll" (trip count: unknown / symbolic)
 */
#include <stdio.h>
#include <string.h>

volatile int sink;

// Bound is a function parameter — SE sees it as a symbolic value
void loop_param(int n) {
    int sum = 0;
    for (int i = 0; i < n; i++)
        sum += i;
    sink = sum;
}

// Bound comes from array length derived at runtime
void loop_array(int *arr, int len) {
    int sum = 0;
    for (int i = 0; i < len; i++)
        sum += arr[i];
    sink = sum;
}

// Stride-2 loop — SE can represent it but count depends on n
void loop_stride(int n) {
    int sum = 0;
    for (int i = 0; i < n; i += 2)
        sum += i;
    sink = sum;
}

// While loop with pointer arithmetic — harder for SE
void loop_ptr(const char *s) {
    int len = 0;
    while (*s++) len++;
    sink = len;
}

int main(int argc, char **argv) {
    int arr[] = {1, 2, 3, 4, 5};
    loop_param(argc);
    loop_array(arr, argc);
    loop_stride(argc * 2);
    loop_ptr(argv[0]);
    return 0;
}