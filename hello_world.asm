default rel
bits 64

extern printf

global main

section .data
	msg db "Hello, world!", 0
section .bss
section .text
main:
	push rbp
	mov rbp, rsp
	sub rsp, 32

	mov rcx, msg
	call printf

	add rsp, 32
	pop rbp
	ret