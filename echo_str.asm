;; ==============================
;; #include <stdio.h>
;; int main() {
;; 	printf("Input text : ");
;; 	char buf[64] = { 0, };
;; 	scanf("%s", &buf[0]);
;; 	printf("Your text = %s", &buf[0]);
;; }
;; ==============================


default rel
bits 64

extern printf
extern scanf

global main

section .data
	msg1 db "Input text : ", 0
	msg2 db "Your text = %s", 0
	fmt db "%s", 0
section .bss
section .text
main:
	push rbp
	mov rbp, rsp
	sub rsp, 96
	
	lea rax, msg1
	mov rcx, rax
	call printf

	mov qword [rbp - 64], 0
	mov qword [rbp - 56], 0
	mov qword [rbp - 48], 0
	mov qword [rbp - 40], 0	
	mov qword [rbp - 32], 0
	mov qword [rbp - 24], 0
	mov qword [rbp - 16], 0
	mov qword [rbp - 8], 0

	lea rax, [rbp - 64]
	lea rcx, fmt
	mov rdx, rax
	call scanf
	lea rax, [rbp - 64]
	lea rcx, msg2
	mov rdx, rax
	call printf
	mov eax, 0
	
	add rsp, 96
	pop rbp
	ret