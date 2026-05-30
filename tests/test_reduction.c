/**
 * test_reduction.c
 *
 * Completeness case #1 — Reduction patterns and multiple induction variables.
 *
 * Rationale: The existing suite tests single-variable linear induction and
 * call presence, but never exercises loops whose bodies carry cross-iteration
 * data dependences (reductions) or advance more than one induction variable
 * simultaneously.  ScalarEvolution can still compute exact trip counts for
 * these loops, so the advisor should recommend unrolling based purely on the
 * trip-count classification — the reduction dependence is NOT a reason to
 * block unrolling at the analysis level.  This file therefore validates:
 *
 *   a) A simple sum-reduction over a small, fixed trip count
 *      → SE gives exact TC = 8; no calls; expected: FULL UNROLL
 *
 *   b) A dot-product loop (two input arrays, one accumulator) with a moderate
 *      fixed trip count
 *      → SE gives exact TC = 32; no calls; expected: PARTIAL UNROLL
 *
 *   c) A two-variable loop (i advances forward, j retreats backward) that
 *      still has a deterministic iteration count known at compile time
 *      → SE gives exact TC = 16; no calls; expected: FULL or PARTIAL UNROLL
 *        depending on advisor thresholds
 *
 *   d) A large reduction whose trip count is a runtime variable
 *      → SE cannot give an exact constant; expected: NO UNROLL / KEEP AS-IS
 *
 * No function calls appear in any loop body, so call-detection logic must not
 * influence the recommendations here.
 */

#include <stddef.h>

volatile int   isink;
volatile double dsink;

/* ── (a) small fixed reduction — expect FULL UNROLL ─────────────────────── */
__attribute__((noinline))
int sum_fixed(void) {
    volatile int s = 0;          // volatile prevents loop elimination
    for (int i = 0; i < 8; i++)
        s += i * i;
    return s;
}

/* ── (b) dot-product, moderate fixed count — expect PARTIAL UNROLL ──────── */
double dot_product(const double *a, const double *b) {
    double acc = 0.0;
    for (int i = 0; i < 32; i++)  /* TC = 32, constant */
        acc += a[i] * b[i];
    return acc;
}

/* ── (c) two induction variables, fixed count — expect FULL/PARTIAL UNROLL  */
/*       i counts up, j counts down; loop runs while i < j (16 iterations)  */
int two_induction(const int *arr) {
    int lo = 0, hi = 31;
    int result = 0;
    /* Rewrite as a for-loop so SE sees a clear primary IV */
    for (int k = 0; k < 16; k++) { /* TC = 16, constant */
        result += arr[lo] - arr[hi];
        lo++;
        hi--;
    }
    return result;
}

/* ── (d) large runtime reduction — expect NO UNROLL ─────────────────────── */
long sum_variable(const int *arr, int n) {
    long s = 0;
    for (int i = 0; i < n; i++)   /* TC = n, unknown at compile time */
        s += arr[i];
    return s;
}

/* ── driver (keeps optimiser from deleting the functions) ───────────────── */
int main(void) {
    static const double a[32], b[32];
    static const int    arr[32];

    isink  = sum_fixed();
    dsink  = dot_product(a, b);
    isink += two_induction(arr);
    isink += (int)sum_variable(arr, 32);
    return 0;
}