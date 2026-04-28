.section .data
prompt: .ascii "Enter Number: "
len = . - prompt

output: .ascii "The double is: "
output_len = . - output

.section .bss
.lcomm input, 128

.section .text
.globl _start

_start:
#print input message
    mov $1, %rax
    mov $1, %rdi
    mov $prompt, %rsi
    mov $len, %rdx
    syscall

# read input from command line
    mov $0, %rax
    mov $0, %rdi
    mov $input, %rsi
    mov $128, %rdx
    syscall

#save input
    mov %rax, %rbx

#print output text
    mov $1, %rax
    mov $1, %rdi
    mov $output, %rsi
    mov $output_len, %rdx
    syscall

# print user input
    mov %rax, %rdx
    mov $1, %rax
    mov $1, %rdi
    mov $input, %rsi
    mov %rbx, %rdx
    syscall

# Exit
    mov $60, %rax
    xor %rdi, %rdi
    syscall

