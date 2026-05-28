/**
 * test_edge.c
 * Extra edge cases: pointer chasing, call-heavy loops, and non-unit stride.
 */
#include <math.h>
#include <stdio.h>

typedef struct Node {
    int value;
    struct Node *next;
} Node;

volatile int sink;
volatile int edge_buf[16];

#if defined(__clang__) || defined(__GNUC__)
#define NOINLINE __attribute__((noinline))
#else
#define NOINLINE
#endif

// Non-unit stride with constant bound: TC = 4 (0,3,6,9)
NOINLINE void loop_stride_const(void) {
    int sum = 0;
    for (int i = 0; i < 12; i += 3) {
        sum += i;
        edge_buf[i] = sum;
    }
    sink = sum;
}

// Pointer chasing: trip count unknown to SE
NOINLINE int loop_pointer_chase(Node *head) {
    int sum = 0;
    for (Node *p = head; p != NULL; p = p->next)
        sum += p->value;
    return sum;
}

// Call-heavy loop: should never unroll
NOINLINE void loop_call_heavy(void) {
    double acc = 0.0;
    for (int i = 0; i < 8; i++) {
        acc += sqrt((double)i);
        printf("%d ", i);
    }
    printf("\n");
    sink = (int)acc;
}

int main(void) {
    loop_stride_const();

    Node a = {1, NULL};
    Node b = {2, &a};
    sink = loop_pointer_chase(&b);

    loop_call_heavy();
    return 0;
}
