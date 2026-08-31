;; ==============================
;; #include <stdio.h>
;; void add_num(int a, int b, int c, int d) {
;; 	int n = a + b + c + d;
;;	printf("%d", n);
;; }
;; int main() {
;;     add_num(1, 2, 3, 4);
;; }
;; ==============================


default rel
bits 64

extern printf

global main

section .data
	fmt db "%d", 10, 0
section .bss
section .text
add_num:
	push rbp
	mov rbp, rsp
	sub rsp, 48

	mov dword [rbp + 16], ecx ;; 인자 a
	mov dword [rbp + 24], edx ;; 인자 b
	mov dword [rbp + 32], r8d ;; 인자 c
	mov dword [rbp + 40], r9d ;; 인자 d

	;; b = b + a
	;; 	edx = edx + eax
	mov edx, dword [rbp + 16]
	mov eax, dword [rbp + 24]
	add edx, eax	

	;; b = b + c
	mov eax, dword [rbp + 32]
	add edx, eax

	;; d = d + b
	mov eax, dword [rbp + 40]
	add eax, edx

	;; 이제 최종으로 더한 값은 eax에 있음.
	mov dword [rbp - 4], eax
	mov eax, dword [rbp - 4]
	lea rcx, fmt
	mov edx, eax
	call printf
	nop

	add rsp, 48
	pop rbp
	ret
main:
	push rbp
	mov rbp, rsp
	sub rsp, 32

	mov r9d, 4
	mov r8d, 3
	mov edx, 2
	mov ecx, 1
	call add_num
	mov eax, 0

	add rsp, 32
	pop rbp
	ret