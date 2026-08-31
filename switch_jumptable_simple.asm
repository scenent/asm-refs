;; ==============================
;; #include <stdio.h>
;; int main() {
;; 	int n = 1;
;; 	printf("Input number (1 ~ 9) : ");
;; 	scanf("%d", &n);
;; 	int test = 0;
;; 	switch (n) {
;; 		case (1) : { test = 1; break; }
;; 		case (2) : { test = 2; break; }
;; 		case (3) : { test = 3; break; }
;; 		case (4) : { test = 4; break; }
;; 		case (5) : { test = 5; break; }
;; 		case (6) : { test = 6; break; }
;; 		case (7) : { test = 7; break; }
;; 		case (8) : { test = 8; break; }
;; 		case (9) : { test = 9; break; }
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

section .data
        fmt1 db "Input number (1 ~ 9) : ", 0
	fmt2 db "%d", 0
        fmt3 db "invalid n.", 0
        fmt4 db "value = %d", 0
section .bss
section .text
main:
	push rbp
	mov rbp, rsp
	sub rsp, 56
	
	mov dword [rsp + 44], 1
	
	lea rcx, fmt1
	call printf

	lea rdx, [rsp + 44]
	lea rcx, fmt2
	call scanf

	mov edx, dword [rsp + 44]
	;; n = 0  → 통과
	;; n = 1  → 통과
	;; ...
	;; n = 9  → 통과
	;; n = 10 → .L2
	cmp edx, 9
	ja L2
	
	mov eax, edx

	;; rcx = jump_table 주소
	lea rcx, [rel jump_table]
	movsxd rax, dword [rcx + rax * 4]
	add rax, rcx
	;; jmp [register] 형식.
	jmp rax

;; Jump table의 각 항목은 dd,
;;	즉 4바이트.
;;	ㄴ [rcx + rax * 4] 로 쓴다.
align 4
jump_table:
    dd L2 - jump_table
    dd L3 - jump_table
    dd L3 - jump_table
    dd L3 - jump_table
    dd L3 - jump_table
    dd L3 - jump_table
    dd L3 - jump_table
    dd L3 - jump_table
    dd L3 - jump_table
    dd L3 - jump_table

L2:
	lea rcx, fmt3
	call puts
	mov edx, 0
L3:
	lea rcx, fmt4
	call printf
	mov eax, 0

	add rsp, 56
	pop rbp
	ret