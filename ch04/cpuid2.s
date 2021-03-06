# cpuid2.s = View the CPUID vendor id (just as cpuid.s), but use C lib calls

.section .data
output:
  # asciz - add NULL \0
  .asciz "The process Vendor ID is '%s'\n"

.section .bss
  # buffer = 12 byte area
  .lcomm buffer, 12

.section .text
.globl main
main:

  # same as before
  nop
  movl $0,        %eax
  cpuid

  movl $buffer,   %edi
  movl %ebx,     (%edi)
  movl %edx,    4(%edi)
  movl %ecx,    8(%edi)

  # printf(&output, &buffer)
  #
  # call printf, but push arguments onto the stack
  # arguments are pushed in reverse order:
  pushl $buffer
  pushl $output
  call printf
  # clear the params
  addl $8, %esp

  # exit(0)
  pushl $0
  call exit
