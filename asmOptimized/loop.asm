.section .data, "aw"
array:      .space 40000                  // Reserve space for an array of 10,000 int32 elements
random_value: .word 0                     // Placeholder for random value
input_value:  .word 0                     // Placeholder for input value
mod_sums:    .space 4000                  // Space for pre-calculated modulo sums (max 1000 values)

.section .text, "ax"
.global _start

_start:
    // Load input value (hardcoded to 5)
    MOV W0, #5
    LDR X1, =input_value
    STR W0, [X1]                          // Store input value in memory

    // Generate random value (hardcoded to 1234)
    MOV W1, #1234
    LDR X2, =random_value
    STR W1, [X2]                          // Store random value in memory

    // Pre-calculate modulo sums
    LDR X1, =input_value
    LDR W0, [X1]                          // Load input value
    LDR X2, =mod_sums                     // Load base address of mod_sums array

    MOV W3, #0                            // i = 0
    MOV W4, W0                            // Store input value in W4 for reuse

calc_mod_sums:
    CMP W3, W4
    BGE end_calc_mod_sums

    MOV W5, #0                            // sum = 0
    MOV W6, #0                            // j = 0
    MOVZ W7, #100000 & 0xFFFF             // Load 100000 in two steps
    MOVK W7, #100000 >> 16, LSL #16

mod_sum_loop:
    CMP W6, W7
    BGE end_mod_sum_loop

    // Optimized modulo calculation
    UDIV W8, W6, W4                       // W8 = j / input
    MSUB W9, W8, W4, W6                   // W9 = j % input
    ADD W5, W5, W9                        // sum += j % input

    ADD W6, W6, #1                        // j++
    B mod_sum_loop

end_mod_sum_loop:
    STR W5, [X2, W3, SXTW #2]            // Store sum in mod_sums[i]
    ADD W3, W3, #1                        // i++
    B calc_mod_sums

end_calc_mod_sums:
    // Initialize loop variables
    MOV W2, #0                            // Outer loop index
    MOV W3, #10000                        // Outer loop limit
    LDR X8, =array                        // Load base address of array
    LDR X9, =mod_sums                     // Load base address of mod_sums
    LDR W10, =random_value                // Load address of random_value

outer_loop:
    CMP W2, W3
    BGE end_outer_loop

    // Load pre-calculated sum and random value
    LDR W11, [X9, W2, SXTW #2]           // Load mod_sums[i]
    LDR W12, [X10]                        // Load random value
    ADD W11, W11, W12                     // Add random value to sum
    STR W11, [X8, W2, SXTW #2]           // Store result in array[i]

    ADD W2, W2, #1                        // i++
    B outer_loop

end_outer_loop:
    MOV W12, #1234                        // Hardcoded index
    LDR W13, [X8, W12, SXTW #2]          // Load array[random_index]

    MOV X0, #1                            // Exit syscall number
    MOV X1, #0                            // Exit status
    SVC #0                                // Make syscall
