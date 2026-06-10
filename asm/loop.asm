// ARM64 macOS implementation of the loop benchmark.
// The benchmark loop is hand-written assembly; argument parsing, randomness,
// and printing call into libc, just like the other implementations.
//
// Build: clang asm/loop.asm -o asm/loop

.text
.global _main
.align 4

_main:
    sub sp, sp, #96
    stp x29, x30, [sp, #80]
    add x29, sp, #80
    stp x19, x20, [sp, #64]
    stp x21, x22, [sp, #48]
    stp x23, x24, [sp, #32]
    stp x25, x26, [sp, #16]

    cmp w0, #2                        // if (argc < 2) -> usage error
    blt usage_error
    mov x19, x1                       // x19 = argv

    ldr x0, [x19, #8]                 // input = atoi(argv[1])
    bl _atoi
    mov w20, w0                       // w20 = input (u)
    cmp w20, #1                       // atoi returns 0 for junk; reject <= 0
    blt invalid_error

    mov x0, #0                        // r = rand() % 10000, seeded from time
    bl _time
    bl _srand
    bl _rand
    mov w5, #10000
    udiv w1, w0, w5
    msub w21, w1, w5, w0              // w21 = r

    adrp x22, array@PAGE              // x22 = array of 10k int32, zeroed (bss)
    add x22, x22, array@PAGEOFF

    mov w23, #0                       // i = 0
outer_loop:                           // 10k outer loop iterations
    mov w24, #0                       // j = 0
    mov w25, #34464                   // w25 = 100000 (0x186A0, built in two steps)
    movk w25, #1, lsl #16
inner_loop:                           // 100k inner loop iterations
    udiv w4, w24, w20
    msub w4, w4, w20, w24             // w4 = j % input
    ldr w5, [x22, x23, lsl #2]
    add w5, w5, w4                    // a[i] = a[i] + j % input
    str w5, [x22, x23, lsl #2]
    add w24, w24, #1
    cmp w24, w25
    blt inner_loop

    ldr w5, [x22, x23, lsl #2]
    add w5, w5, w21                   // a[i] += r
    str w5, [x22, x23, lsl #2]

    add w23, w23, #1
    mov w6, #10000
    cmp w23, w6
    blt outer_loop

    adrp x0, fmt@PAGE                 // printf("%d\n", a[r])
    add x0, x0, fmt@PAGEOFF
    ldr w8, [x22, x21, lsl #2]
    str x8, [sp]                      // variadic args go on the stack (Apple ABI)
    bl _printf

    mov w0, #0
    b epilogue

usage_error:
    adrp x1, usage_msg@PAGE
    add x1, x1, usage_msg@PAGEOFF
    mov w2, #49
    mov w0, #2                        // write(stderr, msg, len)
    bl _write
    mov w0, #1
    b epilogue

invalid_error:
    adrp x1, invalid_msg@PAGE
    add x1, x1, invalid_msg@PAGEOFF
    mov w2, #40
    mov w0, #2                        // write(stderr, msg, len)
    bl _write
    mov w0, #1
    b epilogue

epilogue:
    ldp x25, x26, [sp, #16]
    ldp x23, x24, [sp, #32]
    ldp x21, x22, [sp, #48]
    ldp x19, x20, [sp, #64]
    ldp x29, x30, [sp, #80]
    add sp, sp, #96
    ret

.data
fmt:         .asciz "%d\n"
usage_msg:   .ascii "Please provide a number as command line argument\n"
invalid_msg: .ascii "Please provide a valid non-zero integer\n"

.lcomm array, 40000, 2
