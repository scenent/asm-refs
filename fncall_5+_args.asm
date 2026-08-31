default rel
bits 64

extern printf

global main

section .data
	fmt1 db "%d", 0
section .bss
section .text
add_6_nums:
	push rbp
	mov rbp, rsp
	
	mov dword [rbp + 16], ecx
	mov dword [rbp + 24], edx
	mov dword [rbp + 32], r8d
	mov dword [rbp + 40], r9d
	mov edx, dword [rbp + 16]
	mov eax, dword [rbp + 24]
	add edx, eax
	mov eax, dword [rbp + 32]
	add edx, eax
	mov eax, dword [rbp + 40]
	add edx, eax
	mov eax, dword [rbp + 48]
	add edx, eax
	mov eax, dword [rbp + 56]
	add eax, edx
	pop rbp
	ret
main:
	push rbp
	mov rbp, rsp
	sub rsp, 64

	mov dword [rsp + 40], 6
	mov dword [rsp + 32], 5
	mov r9d, 4
	mov r8d, 3
	mov edx, 2
	mov ecx, 1
	call add_6_nums
	;; mov dword [rbp - 4], eax
	;; mov eax, dword [rbp - 4]
	lea rcx, fmt1
	mov edx, eax
	call printf
	mov eax, 0

	add rsp, 64
	pop rbp
	ret