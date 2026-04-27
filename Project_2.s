.section .data # Data section
message: .asciz "Hello, World!" # Declare a null-terminated ASCII string
.section .text # Text section
.globl _start
_start:
mov $4, %eax # syscall number 4 (sys_write)
mov $1, %ebx # file descriptor 1 (stdout)
mov $message, %ecx # address of the message string
mov $13, %edx # length of the string (13 characters)
int $0x80 # Global entry point for the program