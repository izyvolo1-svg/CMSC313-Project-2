.section .data
prompt: .ascii "Enter Number: " # var for user input prompt
len = . - prompt #var for length of prompt

output: .ascii "The double is: " #var for output txt
output_len = . - output #var for output length

newline: .ascii "\n" # var for printing newlines
newlen = . - newline # var for newline len

.section .bss
.lcomm input, 128 # var for user input
.lcomm ninput, 4 # var for final version of user input (doubled)

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

# save input len
    mov %rax, %r8

# save input address and load 0 to rax
    mov $input, %rdi
    mov $0, %rax

# convert string input into int
convert_to_int:
# checks if current char is newline if so end of input reached convert ends
    movzbq (%rdi), %rcx
    cmp $10, %rcx
    je done_int

# converts current char to num then adds to current total (by mult total by 10 then add curr num)
    sub $'0', %rcx
    imul $10, %rax, %rax
    add %rcx, %rax

# go to next char and go again
    inc %rdi
    jmp convert_to_int


done_int:

# double int vers of input
    mov %rax, %rbx
    imul $2, %rbx, %rbx

# start output var, set base for division needed for conversion, load var to convert
    mov $ninput+3, %rsi
    mov $10, %rcx
    mov %rbx, %rax

# starts converting if input int not zero
    cmp $0, %rax
    jne convert_to_str

# case inwhich we wanna convert 0 to str
    movb $'0', (%rsi)
    dec %rsi
    jmp done_str

# convert doubled input to str
convert_to_str:

# divide curr int by 10 (remainder is curr num)
    mov $0, %rdx
    div %rcx

# converts current digit (remainder from div) to ascii char stores then moves left to prep for next digit
    add $'0', %dl
    mov %dl, (%rsi)
    dec %rsi

# check remaining num if zero stops if not loops
    cmp $0, %rax
    jne convert_to_str

done_str:

# moves rsi to first digit of new str num
    inc %rsi

# get end of string and use rsi and end of str to get new str len
    mov $ninput+4, %rdx
    sub %rsi, %rdx
   
# save str start address and length
    mov %rsi, %r9
    mov %rdx, %r10

#print output text
    mov $1, %rax
    mov $1, %rdi
    mov $output, %rsi
    mov $output_len, %rdx
    syscall

# print user input now doubled using previously saved start address and length
    mov $1, %rax
    mov $1, %rdi
    mov %r9, %rsi
    mov %r10, %rdx
    syscall

# print newline for the sake of output looking better
    mov $1, %rax
    mov $1, %rdi
    mov $newline, %rsi
    mov $newlen, %rdx
    syscall

# Exit
    mov $60, %rax
    xor %rdi, %rdi
    syscall

