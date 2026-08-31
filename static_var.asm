;; =========================================
;; #include <stdio.h>
;; int foo() {
;; 	static int x = 1;
;; 	return x++;
;; }
;; int main() {
;; 	printf("%d\n", foo());
;; 	printf("%d\n", foo());
;; 	printf("%d\n", foo());
;; }
;; =========================================

default rel
bits 64

extern printf

global main

section .data
	fmt1 db "%d", 10, 0
	;; foo() 안의 static 변수
	x:  dd 1
section .bss
section .text
foo:
	push rbp
	mov rbp, rsp
	mov eax, dword [x]
	lea edx, [rax + 1]
	mov dword [x], edx
	pop rbp
	ret
main:
	push rbp
	mov rbp, rsp
	sub rsp, 32

	call foo
	mov edx, eax
	lea rax, fmt1
	mov rcx, rax
	call printf
	
	call foo
	mov edx, eax
	lea rax, fmt1
	mov rcx, rax
	call printf

	call foo
	mov edx, eax
	lea rax, fmt1
	mov rcx, rax
	call printf	

	mov eax, 0

	add rsp, 32
	pop rbp
	ret