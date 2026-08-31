;; ================================= 
;; #include <stdio.h>
;; int main() {
;;     printf("Input diamond size = ");
;;     int n = 5;
;;     scanf("%d", &n);
;;     for (int i = 1; i <= n; i++) {
;;         for (int j = i; j < n; j++) printf(" ");
;;         for (int j = 1; j <= 2 * i - 1; j++) printf("*");
;;         printf("\n");
;;     }
;;     for (int i = n - 1; i >= 1; i--) {
;;         for (int j = i; j < n; j++) printf(" ");
;;         for (int j = 1; j <= 2 * i - 1; j++) printf("*");
;;         printf("\n");
;;     }
;; }
;; =================================

default rel
bits 64

extern scanf
extern printf
extern putchar

global main

section .data
	msg1 db "Input diamond size = ", 0
	msg2 db "%d", 0
section .bss
section .text
main:
	push rbp
	mov rbp, rsp
	sub rsp, 64

	lea rcx, msg1
	call printf
	mov eax, eax

	mov dword [rbp - 28], 5
	lea rax, [rbp - 28]
	lea rcx, msg2
	mov rdx, rax
	call scanf
	mov dword [rbp - 4], 1
	jmp L2
L7:
	mov eax, dword [rbp - 4]
	mov dword [rbp - 8], eax
	jmp L3
L4:
	mov ecx, 32
	call putchar
	add dword [rbp - 8], 1
L3:
	mov eax, dword [rbp - 28]
	cmp dword [rbp - 8], eax
	jl L4
	mov dword [rbp - 12], 1
	jmp L5
L6:
	mov ecx, 42
	call putchar
	add dword  [rbp - 12], 1
L5:
	mov eax, dword [rbp - 4]
	add eax, eax
	cmp dword [rbp - 12], eax
	jl L6
	mov ecx, 10
	call putchar
	add dword [rbp - 4], 1
L2:
	mov eax, dword [rbp - 28]
	cmp dword [rbp - 4], eax
	jle L7
	mov eax, dword [rbp - 28]
	sub eax, 1
	mov dword [rbp - 16], eax
	jmp L8
L13:
	mov eax, dword [rbp - 16]
	mov dword [rbp - 20], eax
	jmp L9
L10:
	mov ecx, 32
	call putchar
	add dword [rbp - 20], 1
L9:
	mov eax, dword [rbp - 28]
	cmp dword [rbp - 20], eax
	jl L10
	mov dword [rbp - 24], 1
	jmp L11
L12:
	mov ecx, 42
	call putchar
	add dword [rbp - 24], 1
L11:
	mov eax, dword [rbp - 16]
	add eax, eax
	cmp dword [rbp - 24], eax
	jl L12
	mov ecx, 10
	call putchar
	sub dword [rbp - 16], 1
L8:
	cmp dword [rbp - 16], 0
	jg L13
	mov eax, 0
	
	add rsp, 64
	pop rbp
	ret