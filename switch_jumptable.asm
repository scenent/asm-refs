;; ==============================
;; #include <stdio.h>
;; int main() {
;; 	int n = 1;
;; 	printf("Input number (1 ~ 9) : ");
;; 	scanf("%d", &n);
;; 	int test = 0;
;; 	switch (n) {
;; 		case (1) : { test = 51925; break; }
;; 		case (2) : { test = 15517; break; }
;; 		case (3) : { test = 20318; break; }
;; 		case (4) : { test = 31283; break; }
;; 		case (5) : { test = 31231; break; }
;; 		case (6) : { test = 90127; break; }
;; 		case (7) : { test = 10247; break; }
;; 		case (8) : { test = 12309; break; }
;; 		case (9) : { test = 12303; break; }
;; 		default: { printf("invalid n\n"); break; }
;; 	}
;; 	printf("value = %d", test);
;; }
;; ==============================


default rel
bits 64

extern printf
extern scanf
extern puts

global main

section .rodata
align 4
jump_table:
	dd  L2-jump_table
	dd  L12-jump_table
	dd  L13-jump_table
	dd  L10-jump_table
	dd  L9-jump_table
	dd  L8-jump_table
	dd  L7-jump_table
	dd  L6-jump_table
	dd  L5-jump_table
	dd  L3-jump_table
section .data
        LC0 db "Input number (1 ~ 9) : ", 0
	LC1 db "%d", 0
        LC2 db "invalid n.", 0
        LC3 db "value = %d", 0
section .bss
section .text
main:
	push rbp
	mov rbp, rsp
	sub rsp, 56
	
	mov dword [rsp + 44], 1
	
	lea rcx, LC0
	call printf

	lea rdx, [rsp + 44]
	lea rcx, LC1
	call scanf

	;; n = 0  → 통과
	;; n = 1  → 통과
	;; ...
	;; n = 9  → 통과
	;; n = 10 → .L2
	cmp dword [rsp + 44], 9
	ja L2
	
	mov eax, dword [rsp + 44]
	lea rdx, jump_table
	movsxd rax, dword [rdx + rax * 4]
	add rax, rdx
	jmp rax
L12:
	mov edx, 51925
	;; jmp L11 ;; 이건 없어도 됨.
L11:
	lea rcx, LC3
	call printf
	mov eax, 0
	add rsp, 56
	pop rbp
	ret	
L10:
	mov edx, 20318
	jmp L11
L9:
	mov edx, 31283
	jmp L11
L8:
	mov edx, 31231
	jmp L11
L7:
	mov edx, 90127
	jmp L11
L6:
	mov edx, 10247
	jmp L11
L5:
	mov edx, 12309
	jmp L11
L3:
	mov edx, 12303
	jmp L11
L2:
	lea rcx, LC2
	call puts
	mov edx, 0
	jmp L11
L13:
	mov edx, 15517
	jmp L11