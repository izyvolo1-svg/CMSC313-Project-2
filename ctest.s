.section .data
prompt: .ascii "Enter Number: "
len = . - prompt

output: .ascii "The double is: "
output_len = . - prompt

.section .bss
.lcomm buffer, 128

.section .text
.globl _start

_start:
# prints input message
    mov $1, %rax
    mov $1, %rdi
    mov $prompt, %rsi
    mov $len, %rdx
    syscall

# reads input from command line
    mov $0, %rax
    mov $0, %rdi
    mov $buffer, %rsi
    mov $128, %rdx
    syscall

# removes newline from input
    cmp $0, %rax
    je done_strip

    dec %rax
    
    mov $buffer, %rsi
    add %rax, %rsi

    cmpb $10, (%rsi)
    je done_strip

    inc %rax

    done_strip:
# prints output text
    mov $1, %rax
    mov $1, %rdi
    mov $output, %rsi
    mov $output_len, %rdx
    syscall

# prints user input
    #mov %rax, %rdx
    #mov $1, %rax
    #mov $1, %rdi
    #mov $buffer, %rsi
    #syscall

# exits
    mov $60, %rax
    xor %rdi, %rdi
    syscall
