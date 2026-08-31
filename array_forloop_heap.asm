;; ==============================
;; #include <stdio.h>
;; #include <stdlib.h>
;; int main() {
;; 	int* arr = (int*)malloc(sizeof(int) * 5);
;; 	arr[0] = 1;
;; 	arr[1] = 2;
;; 	arr[2] = 3;
;; 	arr[3] = 4;
;; 	arr[4] = 5;
;; 	for (int i = 0; i < 5; i++) {
;; 		printf("%d\n", arr[i]);
;; 	}
;; 	free(arr);
;; }
;; ==============================

default rel
bits 64

extern printf
extern malloc
extern free

global main

section .data
	fmt1 db "%d", 10, 0
section .bss
section .text
main:
	push rbp
	mov rbp, rsp
	sub rsp, 48

	;; 필요한 것 : 
	;; 	int* 형 포인터 -> 8바이트.
	;; 	int 형 for 카운터 -> 4바이트
	;; 12바이트 필요하므로 
	;; (32 + 12) 와 제일 가까운 16 배수는 48.

	mov ecx, 20    ;; sizeof(int) * 5 == 20
	call malloc

	;; 이게 필요한 이유: 오프셋 늘릴거니까, 백업해야 함.
	mov qword [rbp - 16], rax ;; [rbp - 16] 에다가, malloc 반환값 백업.
	mov rax, qword [rbp - 16]
	mov dword [rax], 1 ;; arr[0] = 1;
	mov rax, qword [rbp - 16]
	add rax, 4
	mov dword [rax], 2
	mov rax, qword [rbp - 16]
	add rax, 8
	mov dword [rax], 3
	mov rax, qword [rbp - 16]
	add rax, 12
	mov dword [rax], 4
	mov rax, qword [rbp - 16]
	add rax, 16
	mov dword [rax], 5

	;; rax에 malloc의 주소가 딸려온다.
	;;	아까 위에서 이미 넣었었음.
	;; mov qword [rbp - 16], rax
	mov qword [rbp - 4], 0
	jmp L2
L3:
	mov eax, dword [rbp - 4]
	cdqe
	lea rdx, [0 + rax * 4 + 0]    ;; rdx에는, 배열 원소값의 '주소' (lea니까)
	mov rax, qword [rbp - 16]  ;; rax에는, 배열 1번째의 주소. (malloc으로 받았던 거)
	add rax, rdx                     ;; baseAddress + offset
	;; printf 준비
	mov eax, dword [rax]  
	lea rcx, fmt1
	mov edx, eax
	call printf
	add dword [rbp - 4], 1
L2:
	cmp dword [rbp - 4], 4
	jle L3

	;; rcx에 malloc 주소 넣고, free 준비
	mov rax, qword [rbp - 16]
	mov rcx, rax
	call free

	mov eax, 0

	add rsp, 48
	pop rbp
	ret