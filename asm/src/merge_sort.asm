; Implementation of merge sort algorithm in x86_64 Assembly
; Time complexity: O(n log n)
; Space complexity: O(n)
; Author: Assistant
; Date: 2024

section .data
    ; Test data
    test_array dd 5, 3, 8, 4, 2, 1, 9, 7, 6, 0
    test_size  dd 10
    test_msg   db "Testing merge sort...", 10
    test_len   equ $ - test_msg
    pass_msg   db "Test passed!", 10
    pass_len   equ $ - pass_msg
    fail_msg   db "Test failed!", 10
    fail_len   equ $ - fail_msg

section .bss
    ; Temporary array for merging
    temp_array resd 1000
    temp_size  resd 1

section .text
    global _start

_start:
    ; Print test message
    mov rax, 1          ; sys_write
    mov rdi, 1          ; stdout
    mov rsi, test_msg
    mov rdx, test_len
    syscall

    ; Test merge sort
    mov rdi, test_array
    mov esi, [test_size]
    call merge_sort

    ; Verify sorting
    call verify_sort
    test al, al
    jz .test_failed

    ; Print success message
    mov rax, 1
    mov rdi, 1
    mov rsi, pass_msg
    mov rdx, pass_len
    syscall
    jmp .exit

.test_failed:
    ; Print failure message
    mov rax, 1
    mov rdi, 1
    mov rsi, fail_msg
    mov rdx, fail_len
    syscall

.exit:
    ; Exit program
    mov rax, 60         ; sys_exit
    xor rdi, rdi        ; status 0
    syscall

; merge_sort: Sorts an array using merge sort algorithm
; Input: rdi = array pointer, rsi = array size
; Output: sorted array in place
merge_sort:
    push rbp
    mov rbp, rsp
    push rbx
    push r12
    push r13
    push r14
    push r15

    ; Save parameters
    mov r12, rdi        ; array pointer
    mov r13d, esi       ; array size

    ; Base case: array of size 0 or 1 is already sorted
    cmp r13d, 1
    jle .merge_sort_done

    ; Calculate mid point
    mov eax, r13d
    shr eax, 1          ; mid = size / 2
    mov r14d, eax       ; left size
    mov r15d, r13d
    sub r15d, eax       ; right size

    ; Recursively sort left half
    push r15            ; save right size
    mov rdi, r12        ; array pointer
    mov esi, r14d       ; left size
    call merge_sort

    ; Recursively sort right half
    pop r15             ; restore right size
    lea rdi, [r12 + r14*4]  ; right array pointer
    mov esi, r15d       ; right size
    call merge_sort

    ; Merge the sorted halves
    mov rdi, r12        ; array pointer
    mov esi, r14d       ; left size
    mov edx, r15d       ; right size
    call merge

.merge_sort_done:
    pop r15
    pop r14
    pop r13
    pop r12
    pop rbx
    pop rbp
    ret

; merge: Merges two sorted arrays into a single sorted array
; Input: rdi = array pointer, rsi = left size, rdx = right size
; Output: merged array in place
merge:
    push rbp
    mov rbp, rsp
    push rbx
    push r12
    push r13
    push r14
    push r15

    ; Save parameters
    mov r12, rdi        ; array pointer
    mov r13d, esi       ; left size
    mov r14d, edx       ; right size

    ; Initialize indices
    xor rbx, rbx        ; i = 0 (left index)
    xor r15, r15        ; j = 0 (right index)
    xor rcx, rcx        ; k = 0 (temp index)

    ; Copy array to temp array
    mov rdi, temp_array
    mov rsi, r12
    mov edx, r13d
    add edx, r14d
    call copy_array

    ; Reset array pointer
    mov r12, temp_array

.merge_loop:
    ; Compare elements from both arrays
    cmp ebx, r13d       ; i < left_size
    jge .copy_right
    cmp r15d, r14d      ; j < right_size
    jge .copy_left

    ; Compare elements
    mov eax, [r12 + rbx*4]      ; left[i]
    cmp eax, [r12 + r13*4 + r15*4]  ; compare with right[j]
    jle .copy_left_elem

.copy_right_elem:
    mov eax, [r12 + r13*4 + r15*4]
    mov [r12 + rcx*4], eax
    inc r15d
    jmp .continue_merge

.copy_left_elem:
    mov eax, [r12 + rbx*4]
    mov [r12 + rcx*4], eax
    inc ebx

.continue_merge:
    inc ecx
    jmp .merge_loop

.copy_left:
    ; Copy remaining elements from left array
    cmp ebx, r13d
    jge .merge_done
    mov eax, [r12 + rbx*4]
    mov [r12 + rcx*4], eax
    inc ebx
    inc ecx
    jmp .copy_left

.copy_right:
    ; Copy remaining elements from right array
    cmp r15d, r14d
    jge .merge_done
    mov eax, [r12 + r13*4 + r15*4]
    mov [r12 + rcx*4], eax
    inc r15d
    inc ecx
    jmp .copy_right

.merge_done:
    ; Copy back to original array
    mov rdi, [rbp + 16]  ; original array pointer
    mov rsi, temp_array
    mov edx, r13d
    add edx, r14d
    call copy_array

    pop r15
    pop r14
    pop r13
    pop r12
    pop rbx
    pop rbp
    ret

; copy_array: Copies elements from source array to destination array
; Input: rdi = dest pointer, rsi = src pointer, rdx = size
; Output: copied array
copy_array:
    push rbp
    mov rbp, rsp
    push rbx
    push r12
    push r13

    mov r12, rdi        ; dest pointer
    mov r13, rsi        ; src pointer
    xor rbx, rbx        ; i = 0

.copy_loop:
    cmp ebx, edx
    jge .copy_done
    mov eax, [r13 + rbx*4]
    mov [r12 + rbx*4], eax
    inc ebx
    jmp .copy_loop

.copy_done:
    pop r13
    pop r12
    pop rbx
    pop rbp
    ret

; verify_sort: Verifies if an array is sorted
; Input: rdi = array pointer, rsi = array size
; Output: al = 1 if sorted, 0 if not
verify_sort:
    push rbp
    mov rbp, rsp
    push rbx
    push r12
    push r13

    mov r12, rdi        ; array pointer
    mov r13d, esi       ; array size
    xor rbx, rbx        ; i = 0

.verify_loop:
    inc ebx
    cmp ebx, r13d
    jge .verify_done
    mov eax, [r12 + rbx*4 - 4]  ; arr[i-1]
    cmp eax, [r12 + rbx*4]      ; compare with arr[i]
    jle .verify_loop
    xor al, al          ; return 0 (not sorted)
    jmp .verify_exit

.verify_done:
    mov al, 1           ; return 1 (sorted)

.verify_exit:
    pop r13
    pop r12
    pop rbx
    pop rbp
    ret
