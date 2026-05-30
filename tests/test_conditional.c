/**
 * test_conditional_call.c
 *
 * Completeness case #2 — Conditional (predicated) call presence.
 *
 * Rationale: test_complex.c checks loops where a call appears on *every*
 * iteration (sqrt, printf).  A realistic and distinct gap is a loop whose
 * call is guarded by a branch — so the call is NOT guaranteed to execute on
 * every iteration.  The advisor must treat this conservatively: even a
 * *possible* non-intrinsic call anywhere inside the loop's blocks should
 * block unrolling, because replicating the call N times under an unroll
 * could change observable behaviour (I/O, errno, allocation side-effects).
 * This file validates:
 *
 *   a) Call on a taken-rarely branch (error path) — the call lives in a
 *      loop block; advisor should still emit NO UNROLL despite low dynamic
 *      frequency of the call.
 *
 *   b) Intrinsic-only conditional (llvm.expect / __builtin_expect) — these
 *      are LLVM intrinsics, not real calls; the advisor must NOT flag them
 *      and should recommend normally based on trip count alone.
 *      → TC = 16, no real call; expected: FULL or PARTIAL UNROLL
 *
 *   c) Call inside a nested if-else inside the loop body, but with a fixed
 *      known trip count — the conservatism must hold regardless of nesting
 *      depth of the conditional; expected: NO UNROLL.
 *
 *   d) A loop that conditionally calls different functions depending on a
 *      loop-invariant flag — both branches contain calls; expected: NO UNROLL.
 *
 * All loops with real calls use a small fixed trip count (≤ 8) so the ONLY
 * reason the advisor should decline is call presence, not trip-count size.
 * This cleanly isolates the call-detection logic from the TC classifier.
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

volatile int isink;

/* ── (a) call on error branch — expect NO UNROLL ────────────────────────── */
/*       TC = 8, constant; call only when arr[i] < 0                         */
void loop_call_on_error(const int *arr) {
    for (int i = 0; i < 8; i++) {
        if (arr[i] < 0)
            fprintf(stderr, "negative value at %d\n", i); /* real call */
        isink += arr[i];
    }
}

/* ── (b) intrinsic-only branch — expect FULL/PARTIAL UNROLL ─────────────── */
/*       __builtin_expect lowers to llvm.expect, which is an intrinsic        */
__attribute__((noinline))
int loop_intrinsic_hint(const int *arr) {
    int s = 0;
    for (int i = 0; i < 16; i++) {
        if (__builtin_expect(arr[i] != 0, 1))
            s += arr[i];
    }
    return s;
}

/* ── (c) call inside nested conditional — expect NO UNROLL ──────────────── */
/*       TC = 6, constant; call buried two levels deep                        */
void loop_nested_cond_call(const int *arr, int flag) {
    for (int i = 0; i < 6; i++) {
        if (arr[i] > 0) {
            if (flag)
                printf("pos+flag: %d\n", arr[i]); /* real call */
        }
        isink += arr[i];
    }
}

/* ── (d) loop-invariant flag selects which call to make — expect NO UNROLL  */
/*       TC = 5, constant; one of two calls fires on every iteration          */
void loop_dispatch_call(const int *arr, int use_stderr) {
    for (int i = 0; i < 5; i++) {
        if (use_stderr)
            fprintf(stderr, "%d\n", arr[i]); /* real call — branch A */
        else
            printf("%d\n", arr[i]);           /* real call — branch B */
    }
}

/* ── driver ──────────────────────────────────────────────────────────────── */
int main(void) {
    int arr[16] = {3, -1, 2, 4, -2, 1, 0, 5, 7,  6, 8, 9,  1, 2, 3, 4};

    loop_call_on_error(arr);
    isink += loop_intrinsic_hint(arr);
    loop_nested_cond_call(arr, 1);
    loop_dispatch_call(arr, 0);
    return 0;
}