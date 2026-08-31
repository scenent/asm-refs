;; ==============================
;; #include <stdio.h>
;; void write_value(int* ptr) {
;; 	(*ptr) = 4419;
;; }
;; int main() {
;; 	int value = 100;
;; 	printf("%d\n", value);
;; 	write_value(&value);
;; 	printf("%d\n", value);
;; }
;; ==============================

default rel
bits 64

extern printf

global main

section .data
        fmt1 db "%d", 10, 0
section .rodata
section .bss
section .text
write_value:
	push rbp
	mov rbp, rsp
	;; 스택을 할당할 필요가 없다!
	;; 그냥 포인터(caller의 스택에서 할당된) 의 값만 바꾸므로.
	
	;; mov qword [rbp + 16], rcx
	;; mov rax, qword [rbp  +16]
	;; mov dword [rax], 4419

	;; win64에서 인자는
	;; rcx, rdx, r8, r9, stack ... 으로 들어온다.
	mov dword [rcx], 4419
	nop

	pop rbp
	ret
main:
	push rbp
	mov rbp, rsp
	sub rsp, 48

	mov dword [rbp - 4], 100
	mov eax, dword [rbp - 4]
	lea rcx, fmt1
	mov edx, eax
	call printf

	;; 스택(rbp - 4 위치) 에 할당된 변수의
	;; 주소를 rcx에 넘김.
	lea rax, [rbp - 4]
	mov rcx, rax
	call write_value
	
	mov eax, dword [rbp - 4]
	lea rcx, fmt1
	mov edx, eax
	call printf
	mov eax, 0
	
	add rsp, 48
	pop rbp
	ret