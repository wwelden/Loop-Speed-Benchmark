global _main
extern _printf
extern _malloc
extern _free
extern _exit

section .data
    array_size equ 1000
    iterations equ 100
    seed_msg db "Initializing random seed...", 10
    seed_len equ $ - seed_msg
    seed:   dq  0

section .bss
    array resq array_size
    temp resq array_size

section .text

_main:
    push    rbp
    mov     rbp, rsp
    sub     rsp, 16

    ; Initialize random seed
    rdtsc
    mov     [rel seed], rax

    ; Run 100 iterations
    mov     qword [rbp-8], 0  ; iteration counter
.iter_loop:
    cmp     qword [rbp-8], 100
    jge     .done

    ; Allocate array
    mov     rdi, 8000         ; 1000 integers * 8 bytes
    call    _malloc
    mov     [rbp-16], rax     ; Store array pointer

    ; Generate random array
    mov     rcx, 0            ; counter
.gen_loop:
    cmp     rcx, 1000
    jge     .gen_done

    ; Generate random number
    mov     rax, [rel seed]
    imul    rax, 1103515245
    add     rax, 12345
    mov     [rel seed], rax
    mov     rdx, 0
    mov     r8, 1000
    div     r8
    mov     rax, rdx          ; random number in range [0,999]

    ; Store in array
    mov     rdi, [rbp-16]     ; array pointer
    mov     [rdi + rcx*8], rax
    inc     rcx
    jmp     .gen_loop
.gen_done:

    ; Sort array
    mov     rdi, [rbp-16]     ; array pointer
    mov     rsi, 0            ; left index
    mov     rdx, 999          ; right index
    call    mergeSort

    ; Free array
    mov     rdi, [rbp-16]
    call    _free

    inc     qword [rbp-8]
    jmp     .iter_loop

.done:
    mov     rdi, 0
    call    _exit

mergeSort:
    push    rbp
    mov     rbp, rsp
    sub     rsp, 48
    mov     [rbp-8], rdi      ; array pointer
    mov     [rbp-16], rsi     ; left
    mov     [rbp-24], rdx     ; right

    ; if (left < right)
    cmp     rsi, rdx
    jge     .return

    ; mid = (left + right) / 2
    mov     rax, rsi
    add     rax, rdx
    mov     rdx, 0
    mov     r8, 2
    div     r8
    mov     [rbp-32], rax     ; mid

    ; mergeSort(arr, left, mid)
    mov     rdi, [rbp-8]
    mov     rsi, [rbp-16]
    mov     rdx, [rbp-32]
    call    mergeSort

    ; mergeSort(arr, mid + 1, right)
    mov     rdi, [rbp-8]
    mov     rsi, [rbp-32]
    inc     rsi
    mov     rdx, [rbp-24]
    call    mergeSort

    ; merge(arr, left, mid, right)
    mov     rdi, [rbp-8]
    mov     rsi, [rbp-16]
    mov     rdx, [rbp-32]
    mov     rcx, [rbp-24]
    call    merge

.return:
    leave
    ret

merge:
    push    rbp
    mov     rbp, rsp
    sub     rsp, 8000         ; Temporary array for merging

    mov     r8, rsi          ; i = left
    mov     r9, rdx          ; mid
    inc     r9
    mov     r10, rsi         ; k = left
    mov     r11, rdx         ; Save mid for later

    ; while (i <= mid && j <= right)
.merge_loop:
    cmp     r8, r11          ; i <= mid
    jg      .copy_left
    cmp     r9, rcx          ; j <= right
    jg      .copy_left

    mov     rax, [rdi + r8*8]
    cmp     rax, [rdi + r9*8]
    jg      .copy_right

    mov     [rsp + r10*8], rax
    inc     r8
    inc     r10
    jmp     .merge_loop

.copy_right:
    mov     rax, [rdi + r9*8]
    mov     [rsp + r10*8], rax
    inc     r9
    inc     r10
    jmp     .merge_loop

.copy_left:
    cmp     r8, r11          ; while (i <= mid)
    jg      .copy_remaining

    mov     rax, [rdi + r8*8]
    mov     [rsp + r10*8], rax
    inc     r8
    inc     r10
    jmp     .copy_left

.copy_remaining:
    cmp     r9, rcx          ; while (j <= right)
    jg      .restore

    mov     rax, [rdi + r9*8]
    mov     [rsp + r10*8], rax
    inc     r9
    inc     r10
    jmp     .copy_remaining

.restore:
    mov     r8, rsi          ; k = left
.restore_loop:
    cmp     r8, rcx          ; k <= right
    jg      .merge_done

    mov     rax, [rsp + r8*8]
    mov     [rdi + r8*8], rax
    inc     r8
    jmp     .restore_loop

.merge_done:
    leave
    ret
