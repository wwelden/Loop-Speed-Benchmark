.section .data, "aw"
array:      .space 40000                  // Reserve space for an array of 10,000 int32 elements
random_value: .word 0                     // Placeholder for random value
input_value:  .word 0                     // Placeholder for input value

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

    // Initialize loop variables
    MOV W2, #0                            // Outer loop index
    MOV W3, #10000                        // Outer loop limit

    LDR X8, =array                        // Load base address of array

outer_loop:
    CMP W2, W3
    BGE end_outer_loop

    MOV W4, #0                            // Inner loop index

    MOVZ W5, #100000 & 0xFFFF             // Load 100000 in two steps
    MOVK W5, #100000 >> 16, LSL #16

inner_loop:
    CMP W4, W5
    BGE end_inner_loop

    // Compute a[i] = a[i] + j % u
    LDR X1, =input_value
    LDR W6, [X1]                          // Load input value (u)

    UDIV W7, W4, W6                        // W7 = j / u
    MSUB W8, W7, W6, W4                    // W8 = j % u (modulo operation)
    ADD W9, W8, W8                         // W9 = a[i] + (j % u)

    STR W9, [X8, W2, SXTW #2]              // Store result in array[i]

    ADD W4, W4, #1                         // j++
    B inner_loop

end_inner_loop:
    LDR X2, =random_value
    LDR W10, [X2]                          // Load random value

    LDR W11, [X8, W2, SXTW #2]             // Load a[i]
    ADD W11, W11, W10                      // a[i] += random value
    STR W11, [X8, W2, SXTW #2]             // Store updated value in array[i]

    ADD W2, W2, #1                         // i++
    B outer_loop

end_outer_loop:
    MOV W12, #1234                         // Hardcoded index
    LDR W13, [X8, W12, SXTW #2]            // Load array[random_index]

    MOV X0, #1                             // Exit syscall number
    MOV X1, #0                             // Exit status
    SVC #0                                 // Make syscall
