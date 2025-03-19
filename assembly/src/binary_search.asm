; Binary Search Implementation in x86_64 Assembly
; NASM syntax
; Calling convention: System V ABI

section .data
    ; Test arrays
    arr1: dd 1, 2, 3, 4, 5    ; Target in middle
    arr2: dd 1, 2, 3, 4, 5    ; Target at start
    arr3: dd 1, 2, 3, 4, 5    ; Target at end
    arr4: dd 1, 2, 3, 4, 5    ; Target not present
    arr5: dd 1                ; Single element

    ; Array lengths
    len1: equ ($ - arr1) / 4
    len2: equ ($ - arr2) / 4
    len3: equ ($ - arr3) / 4
    len4: equ ($ - arr4) / 4
    len5: equ ($ - arr5) / 4

    ; Test targets
    target1: dd 3    ; Target in middle
    target2: dd 1    ; Target at start
    target3: dd 5    ; Target at end
    target4: dd 6    ; Target not present
    target5: dd 1    ; Single element

    ; Output format string
    fmt: db "Array: [%d, %d, %d, %d, %d], Target: %d, Result: %d", 10, 0

section .text
    global main
    extern printf

; Binary search function
; Parameters:
;   rdi: pointer to array
;   rsi: array length
;   rdx: target value
; Returns:
;   rax: index of target if found, -1 otherwise
binary_search:
    push rbp
    mov rbp, rsp

    ; Check for empty array
    test rsi, rsi
    jz .not_found

    ; Initialize left and right pointers
    xor r8, r8          ; left = 0
    dec rsi             ; right = length - 1

.loop:
    ; Check if left > right
    cmp r8, rsi
    jg .not_found

    ; Calculate mid = (left + right) / 2
    mov r9, r8
    add r9, rsi
    shr r9, 1

    ; Compare arr[mid] with target
    mov eax, [rdi + r9*4]
    cmp eax, edx
    je .found

    ; If arr[mid] < target, search right half
    jl .search_right

    ; Otherwise, search left half
    mov rsi, r9
    dec rsi
    jmp .loop

.search_right:
    mov r8, r9
    inc r8
    jmp .loop

.found:
    mov rax, r9
    jmp .done

.not_found:
    mov rax, -1

.done:
    pop rbp
    ret

main:
    push rbp
    mov rbp, rsp

    ; Test case 1: Target in middle
    lea rdi, [arr1]
    mov rsi, len1
    mov edx, [target1]
    call binary_search
    push rax
    push dword [target1]
    push dword [arr1+16]
    push dword [arr1+12]
    push dword [arr1+8]
    push dword [arr1+4]
    push dword [arr1]
    lea rdi, [fmt]
    mov rsi, rsp
    xor rax, rax
    call printf
    add rsp, 56

    ; Test case 2: Target at start
    lea rdi, [arr2]
    mov rsi, len2
    mov edx, [target2]
    call binary_search
    push rax
    push dword [target2]
    push dword [arr2+16]
    push dword [arr2+12]
    push dword [arr2+8]
    push dword [arr2+4]
    push dword [arr2]
    lea rdi, [fmt]
    mov rsi, rsp
    xor rax, rax
    call printf
    add rsp, 56

    ; Exit program
    xor rax, rax
    pop rbp
    ret
