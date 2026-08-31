;; ==============================
;; #include <stdio.h>
;; int main() {
;; 	int i = 0;
;;	while (i < 10) {
;;		printf("%d", i);
;;		i++;
;;	}
;; }
;; ==============================


default rel
bits 64

extern printf

global main

section .data
	fmt1 db "%d", 10, 0
section .bss
section .text
main:
	push rbp
	mov rbp, rsp
	sub rsp, 48
	
	mov dword [rbp - 4], 0
	jmp L2
L3:
	mov eax, dword [rbp - 4]
	lea rcx, fmt1
	mov edx, eax
	call printf
	add dword [rbp - 4], 1
L2:
	cmp dword [rbp - 4], 9
	jle L3
	
	add rsp, 48
	pop rbp
	ret