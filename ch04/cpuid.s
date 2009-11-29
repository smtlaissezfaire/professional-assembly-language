# cpuid.s sameple program to extract the process vendor id

.section .data
output:
  # x's will be replaced with the string given below
  # offsets: 28,32,36,40
  .ascii "The processor Vendor ID is 'xxxxxxxxxxxx'\n"

.section .text
.globl _start
_start:
  # nop instruction for debugging (a bug in gdb)
  nop
  # 0 = cpuid output (vendor id)
  movl  $0, %eax
  cpuid

  # create pointer in edi register for ouput
  # variable defined above
  movl $output, %edi
  # see comments above on offsets - 28, 32, 36
  movl %ebx,    28(%edi)
  movl %edx,    32(%edi)
  movl %ecx,    36(%edi)

  # output the info
  # int 0x80 - int = interupt
  # basically, we are performing a write() (File.write) here
  # 4 = write
  # 1 = STDOUT
  # $output = pointer to the start of the string
  # 42 = length of the string
  movl $4,      %eax
  movl $1,      %ebx
  movl $output, %ecx
  movl $42,     %edx
  int  $0x80

  # 1 = syscall 1 exit()
  # 0 = return value (so return(0) in C)
  movl $1, %eax
  movl $0, %ebx
  int  $0x80