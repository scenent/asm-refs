default rel
bits 64

extern printf

global main

section .data
	fmt db "%d, %d, %d, %d, %d, %d", 0
section .bss
section .text
main:
	push rbp
	mov rbp, rsp
	sub rsp, 64

	lea rax, fmt

	;; Win64에서, 인자는
	;; 4개까지는 rcx, rdx, r8, r9 를 사용하되
	;; 이후부터는 [rsp + 32] 형식의 스택을 쓴다.
	mov dword [rsp + 48], 6
	mov dword [rsp + 40], 5
	mov dword [rsp + 32], 4
	mov r9d, 3
	mov r8d, 2
	mov edx, 1
	mov rcx, rax
	call printf
	mov eax, 0

	add rsp, 64
	pop rbp
	ret