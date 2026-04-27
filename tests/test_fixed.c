/**
 * test_fixed.c
 * Loops with compile-time-constant trip counts.
 * Compiled at -O1 (sufficient for SE to recognise the induction variable
 * while keeping simple loops alive since they write to a global array).
 *
 * Expected advisor output:
 *   loop_tiny  (TC=4)    -> Full unroll
 *   loop_small (TC=16)   -> Unroll x4
 *   loop_large (TC=1000) -> Do not unroll
 */

/* Global so the optimizer keeps the loop body alive */
int result[1024];

void loop_tiny(void) {
    /* TC = 4: tiny -> full unroll */
    for (int i = 0; i < 4; i++)
        result[i] += i * i;
}

void loop_small(void) {
    /* TC = 16: moderate -> unroll x4 */
    for (int i = 0; i < 16; i++)
        result[i] += i;
}

void loop_large(void) {
    /* TC = 1000: too large -> do not unroll */
    for (int i = 0; i < 1000; i++)
        result[i] += i;
}

/* Trip count = 8: boundary of full-unroll threshold */
void loop_boundary(void) {
    for (int i = 0; i < 8; i++)
        result[i] += i;
}

int main(void) {
    loop_tiny();
    loop_small();
    loop_large();
    loop_boundary();
    return result[0];
}