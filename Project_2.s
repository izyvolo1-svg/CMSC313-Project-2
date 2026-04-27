.section .data
prompt: .ascii "enter text: "
len = . - prompt

.section .bss
.lcomm buffer, 128

.section .text
.globl _start

_start:
    mov $1, %rax
    mov $1, %rdi
    mov $prompt, %rsi
    mov $len, %rdx
    syscall

    mov $0, %rax
    mov $0, %rdi
    mov $buffer, %rsi
    mov $128, %rdx
    syscall

    mov %rax, %rdx
    mov $1, %rax
    mov $1, %rdi
    mov $buffer, %rsi
    syscall

    mov $60, %rax
    xor %rdi, %rdi
    syscall
