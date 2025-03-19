; Binary search implementation in x86_64 Assembly for macOS
; Time complexity: O(log n)
; Space complexity: O(1)

section .data
    usage_msg db "Please provide a file path as an argument", 10, 0
    found_msg db "Found %d at index %d", 10, 0
    not_found_msg db "%d not found in the array", 10, 0
    read_mode db "r", 0
    scan_fmt db "%d", 0
    target equ 42

section .bss
    array resq 1000000  ; Space for up to 1M integers
    array_size resq 1   ; Size of the array

section .text
    global _main
    extern _printf
    extern _fopen
    extern _fclose
    extern _fscanf
    extern _atoi

_binary_search:  ; rdi = array, rsi = size, rdx = target
    push rbp
    mov rbp, rsp

    xor rax, rax        ; left = 0
    mov rcx, rsi        ; right = size - 1
    dec rcx

.loop:
    cmp rax, rcx        ; while (left <= right)
    jg .not_found

    mov r8, rcx         ; mid = left + (right - left) / 2
    sub r8, rax
    shr r8, 1
    add r8, rax

    mov r9d, [rdi + r8*4]  ; array[mid]
    cmp r9d, edx        ; compare with target
    je .found
    jl .greater
    mov rcx, r8         ; right = mid - 1
    dec rcx
    jmp .loop

.greater:
    mov rax, r8         ; left = mid + 1
    inc rax
    jmp .loop

.found:
    mov rax, r8         ; return mid
    jmp .done

.not_found:
    mov rax, -1         ; return -1

.done:
    pop rbp
    ret

_main:
    push rbp
    mov rbp, rsp

    ; Check if argument is provided
    cmp rdi, 2
    jne .usage_error

    ; Open file
    mov rdi, [rsi+8]    ; argv[1]
    lea rsi, [read_mode]
    call _fopen
    test rax, rax
    jz .usage_error
    mov r12, rax        ; Save file pointer

    ; Read numbers into array
    xor r13, r13        ; array_size = 0
.read_loop:
    mov rdi, r12
    lea rsi, [scan_fmt]
    lea rdx, [array + r13*4]
    call _fscanf
    cmp rax, 1
    jne .read_done
    inc r13
    jmp .read_loop

.read_done:
    mov [array_size], r13

    ; Close file
    mov rdi, r12
    call _fclose

    ; Call binary search
    lea rdi, [array]
    mov rsi, [array_size]
    mov edx, target
    call _binary_search

    ; Print result
    cmp rax, -1
    je .print_not_found

    lea rdi, [found_msg]
    mov esi, target
    mov edx, eax
    xor eax, eax
    call _printf
    jmp .exit

.print_not_found:
    lea rdi, [not_found_msg]
    mov esi, target
    xor eax, eax
    call _printf
    jmp .exit

.usage_error:
    lea rdi, [usage_msg]
    xor eax, eax
    call _printf

.exit:
    xor eax, eax
    pop rbp
    ret
