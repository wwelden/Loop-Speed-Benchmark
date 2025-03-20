; Implementation of merge sort algorithm in x86_64 Assembly for macOS
; Time complexity: O(n log n)
; Space complexity: O(n)
; Author: Assistant
; Date: 2024

section .data
    error_msg db "Error: Please provide an input file path", 10
    error_len equ $ - error_msg
    output_file db "sorted_data.txt", 0
    newline db 10
    digit_buffer resb 32    ; Buffer for number conversion
    digit_buffer_len equ $ - digit_buffer

section .bss
    buffer resb 1024
    numbers resq 100000
    temp_array resq 100000
    num_count resq 1
    file_handle resq 1
    current_number resq 1
    digit_count resq 1

section .text
    global _main
    extern _printf
    extern _fopen
    extern _fclose
    extern _fgets
    extern _fputs
    extern _fprintf
    extern _exit

_main:
    push rbp
    mov rbp, rsp
    sub rsp, 16     ; Local variables

    ; Check command line arguments
    mov rdi, [rbp + 16]  ; argc
    cmp rdi, 2
    jne print_error

    mov rdi, [rbp + 24]  ; argv
    mov rdi, [rdi + 8]   ; argv[1] (input file path)

    ; Open input file
    lea rsi, [rel read_mode]
    call _fopen
    test rax, rax
    jz print_error
    mov [rel file_handle], rax

    ; Read numbers from file
    xor r8, r8      ; Counter for numbers
read_loop:
    lea rdi, [rel buffer]
    mov rsi, 1024
    mov rdx, [rel file_handle]
    call _fgets
    test rax, rax
    jz read_done

    ; Process buffer
    lea rsi, [rel buffer]
    xor r9, r9      ; Current number
    xor r10, r10    ; Digit count
process_buffer:
    movzx eax, byte [rsi]
    test al, al
    jz read_loop
    cmp al, 10      ; Newline
    je convert_number
    cmp al, '0'
    jb read_loop
    cmp al, '9'
    ja read_loop

    ; Convert digit to number
    sub al, '0'
    movzx eax, al
    imul r9, 10
    add r9, rax
    inc r10
    inc rsi
    jmp process_buffer

convert_number:
    ; Store the number
    mov [rel numbers + r8*8], r9
    inc r8
    jmp read_loop

read_done:
    ; Close input file
    mov rdi, [rel file_handle]
    call _fclose

    ; Store number count
    mov [rel num_count], r8

    ; Call merge sort
    lea rdi, [rel numbers]
    mov rsi, [rel num_count]
    call merge_sort

    ; Open output file
    lea rdi, [rel output_file]
    lea rsi, [rel write_mode]
    call _fopen
    test rax, rax
    jz print_error
    mov [rel file_handle], rax

    ; Write numbers
    xor r8, r8      ; Counter
write_loop:
    cmp r8, [rel num_count]
    jge write_done

    ; Convert number to string
    mov rdi, [rel numbers + r8*8]
    call number_to_string

    ; Write number
    lea rdi, [rel digit_buffer]
    mov rsi, [rel file_handle]
    call _fputs

    ; Write newline
    lea rdi, [rel newline]
    mov rsi, [rel file_handle]
    call _fputs

    inc r8
    jmp write_loop

write_done:
    ; Close output file
    mov rdi, [rel file_handle]
    call _fclose

    ; Exit
    xor rdi, rdi    ; status 0
    call _exit

print_error:
    lea rdi, [rel error_msg]
    call _printf
    mov rdi, 1      ; status 1
    call _exit

; Data for file modes
read_mode db "r", 0
write_mode db "w", 0

; merge_sort: Sorts an array using merge sort algorithm
; Input: rdi = array pointer, rsi = array size
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
    lea rdi, [r12 + r14*8]  ; right array pointer
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
    mov rdi, [rel temp_array]
    mov rsi, r12
    mov edx, r13d
    add edx, r14d
    call copy_array

    ; Reset array pointer
    mov r12, [rel temp_array]

.merge_loop:
    ; Compare elements from both arrays
    cmp ebx, r13d       ; i < left_size
    jge .copy_right
    cmp r15d, r14d      ; j < right_size
    jge .copy_left

    ; Compare elements
    mov rax, [r12 + rbx*8]      ; left[i]
    mov rdx, [r12 + r13*8 + r15*8]  ; right[j]
    cmp rax, rdx
    jle .copy_left_element
    jmp .copy_right_element

.copy_left_element:
    mov [r12 + rcx*8], rax
    inc rbx
    inc rcx
    jmp .merge_loop

.copy_right_element:
    mov [r12 + rcx*8], rdx
    inc r15
    inc rcx
    jmp .merge_loop

.copy_left:
    ; Copy remaining left elements
    cmp ebx, r13d
    jge .merge_done
    mov rax, [r12 + rbx*8]
    mov [r12 + rcx*8], rax
    inc rbx
    inc rcx
    jmp .copy_left

.copy_right:
    ; Copy remaining right elements
    cmp r15d, r14d
    jge .merge_done
    mov rax, [r12 + r13*8 + r15*8]
    mov [r12 + rcx*8], rax
    inc r15
    inc rcx
    jmp .copy_right

.merge_done:
    ; Copy back to original array
    mov rdi, [rbp + 16]  ; original array pointer
    mov rsi, [rel temp_array]
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

; copy_array: Copies elements from source to destination
; Input: rdi = destination, rsi = source, rdx = size
copy_array:
    push rbp
    mov rbp, rsp
    push rbx
    push r12
    push r13

    mov r12, rdi        ; destination
    mov r13, rsi        ; source
    xor rbx, rbx        ; counter

.copy_loop:
    cmp ebx, edx
    jge .copy_done
    mov rax, [r13 + rbx*8]
    mov [r12 + rbx*8], rax
    inc rbx
    jmp .copy_loop

.copy_done:
    pop r13
    pop r12
    pop rbx
    pop rbp
    ret

; number_to_string: Converts a number to a string
; Input: rdi = number
number_to_string:
    push rbp
    mov rbp, rsp
    push rbx
    push r12
    push r13

    mov r12, rdi        ; number
    lea r13, [rel digit_buffer]
    xor rbx, rbx        ; digit count

    ; Handle zero case
    test r12, r12
    jnz .convert_loop
    mov byte [r13], '0'
    mov byte [r13 + 1], 10
    jmp .number_done

.convert_loop:
    test r12, r12
    jz .reverse_digits
    mov rax, r12
    xor rdx, rdx
    mov rcx, 10
    div rcx
    mov r12, rax
    add dl, '0'
    mov [r13 + rbx], dl
    inc rbx
    jmp .convert_loop

.reverse_digits:
    ; Reverse the digits
    lea r12, [r13 + rbx - 1]  ; end pointer
    lea r13, [rel digit_buffer]  ; start pointer
.reverse_loop:
    cmp r13, r12
    jge .number_done
    mov al, [r13]
    mov cl, [r12]
    mov [r13], cl
    mov [r12], al
    inc r13
    dec r12
    jmp .reverse_loop

.number_done:
    mov byte [r13 + rbx], 10  ; newline
    mov byte [r13 + rbx + 1], 0  ; null terminator

    pop r13
    pop r12
    pop rbx
    pop rbp
    ret
