;; ==============================
;; #include <stdio.h>
;; int add(int a, int b) {
;; 	return a + b;
;; }
;; int main() {
;; 	int(*add_ptr)(int, int) = &add;
;; 	int value = add_ptr(1, 2);
;; 	printf("%d", value);
;; }
;; ==============================


default rel
bits 64

extern printf

global main

section .data
        fmt1 db "%d", 0
section .bss
section .text
add:
	push rbp
	mov rbp, rsp
	mov dword [rbp + 16], ecx
	mov dword [rbp + 24], edx
	mov edx, dword [rbp + 16]
	mov eax, dword [rbp + 24]
	add eax, edx
	pop rbp
	ret
main:
	push rbp
	mov rbp, rsp
	sub rsp, 48

	lea rax, [add]
	mov qword [rbp - 8], rax
	mov rax, qword [rbp  - 8]
	mov edx, 2
	mov ecx, 1
	call rax

	mov dword [rbp - 12], eax
	mov eax, dword [rbp - 12]
	lea rcx, fmt1
	mov edx, eax
	call printf
	mov eax, 0

	add rsp, 48
	pop rbp
	ret