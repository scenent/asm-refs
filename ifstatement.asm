;; ==============================
;; #include <stdio.h>
;; int main() {
;; 	int n = 2;
;; 	printf("Input natural number : ");
;; 	scanf("%d", &n);
;; 	if (n % 2 == 0) {
;; 		printf("%d is even.", n);
;; 	}
;; 	else {
;; 		printf("%d is odd.", n);
;; 	}
;; }
;; ==============================


default rel
bits 64

extern printf
extern scanf

global main

section .data
        fmt1 db "Input natural number : ", 0
	fmt2 db "%d", 0
        fmt3 db "%d is even.", 0
	fmt4 db "%d is odd.", 0
section .bss
section .text
main:
	push rbp
	mov rbp, rsp
	sub rsp, 48

	mov dword [rbp - 4], 2
	lea rax, fmt1
	mov rcx, rax
	call printf

	lea rax, [rbp - 4]
	lea rcx, fmt2
	mov rdx, rax
	call scanf

	mov eax, dword [rbp - 4]

	;; 여기서 왜 and를 쓰는가?
	;; n % 2의 결과는 0 또는 1이다.
	;; 따라서, 타겟의 가장 마지막 비트가 1이면?
	;;	7 (0111) & 1 (0001) = 1 (0001)
	;;		즉 AND값이 1이 나오고, 이는 홀수이다.
	;; 타겟의 마지막 비트가 0이면?
	;;	6 (0110) & 1 (0001) = 0 (0000)
	;;		즉 AND값이 0이 나오고, 이는 짝수이다.
	and eax, 1
	
	;; eax 의 값이 0인가?
	test eax, eax
	jne L2
	mov eax, dword [rbp - 4]
	lea rcx, fmt3
	mov edx, eax
	call printf
	jmp L3
L2:
	mov eax, dword [rbp - 4]
	lea rcx, fmt4
	mov edx, eax
	call printf
	;; 어차피 자동으로 L3 로 이동.
L3:
	mov eax, 0

	add rsp, 48
	pop rbp
	ret