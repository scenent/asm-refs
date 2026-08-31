;; ==============================
;; #include <stdio.h>
;; int main() {
;; 	int n = 1;
;; 	printf("Input 1 or 2 or 3 : ");
;; 	scanf("%d", &n);
;; 	switch (n) {
;; 		case (1) : {
;; 			printf("n is 1.");
;; 			break;
;; 		}
;; 		case (2) : {
;; 			printf("n is 2.");
;; 			break;
;; 		}
;; 		case (3) : {
;; 			printf("n is 3.");
;; 			break;
;; 		}
;; 		default: {
;; 			printf("invalid n.");
;; 			break;
;; 		}
;; 	}
;; }
;; ==============================


default rel
bits 64

extern printf
extern scanf

global main

section .data
        fmt1 db "Input 1 or 2 or 3 : ", 0
	fmt2 db "%d", 0
        msg1 db "n is 1.", 0
        msg2 db "n is 2.", 0
        msg3 db "n is 3.", 0
        msg4 db "invalid n.", 0
section .bss
section .text
main:
	push rbp
	mov rbp, rsp
	sub rsp, 48

	mov dword [rbp - 4], 1
	lea rax, fmt1
	mov rcx, rax
	call printf

	lea rax, [rbp - 4]
	lea rcx, fmt2
	mov rdx, rax
	call scanf

	mov eax, dword [rbp - 4]
	cmp eax, 3
	je L2
	cmp eax, 3
	jg L3
	cmp eax, 1
	je L4
	cmp eax, 2
	je L5
	jmp L3
L4:
	lea rax, msg1
	mov rcx, rax
	call printf
	jmp L6
L5:
	lea rax, msg2
	mov rcx, rax
	call printf
	jmp L6
L2:
	lea rax, msg3
	mov rcx, rax
	call printf
	jmp L6
L3:
	lea rax, msg4
	mov rcx, rax
	call printf
	nop
L6:
	mov eax, 0		

	add rsp, 48
	pop rbp
	ret