#Please implement the following logic:
#
#str_lower(src_addr):
#  i = 0
#  if src_addr != 0:
#    while [src_addr] != 0x00:
#      if [src_addr] <= 0x5a:
#        [src_addr] = foo([src_addr])
#        i += 1
#      src_addr += 1
#  return i
#
#foo is provided at 0x403000. foo takes a single argument as a value and returns a value.
#
#All functions (foo and str_lower) must follow the Linux amd64 calling convention (also known as System V AMD64 ABI): System V AMD64 ABI
#
#Therefore, your function str_lower should look for src_addr in rdi and place the function return in rax.
#
#An important note is that src_addr is an address in memory (where the string is located) and [src_addr] refers to the byte that exists at src_addr.
#
#Therefore, the function foo accepts a byte as its first argument and returns a byte.

.intel_syntax noprefix
.global _start
_start:


str_lower:
	mov r10, 0x0			# Initialize counter to 0
	cmp rdi, 0x0
	je nowhere

loop:
	mov rbx, rdi
	mov rax, 0x403000
	xor rdi, rdi
	mov dil, byte ptr [rbx]
	cmp dil, 0x0
	je nowhere
	cmp dil, 0x5a
	jg greater_than
	add r10, 0x1
	call rax
	mov byte ptr [rbx], al

greater_than:
	mov rdi, rbx
	add rdi, 0x1
	jmp loop

nowhere:
	mov rax, r10
	ret

