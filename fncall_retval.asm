;; ==============================
;; #include <stdio.h>
;; void print_num(int n) {
;;     printf("%d", n);
;; }
;; int main() {
;;     printf("%d, %d", 100, 200);
;;     print_num(8484);
;; }
;; ==============================


default rel
bits 64

extern printf

global main

section .data
        fmt1 db "%d, %d", 10, 0
	fmt2 db "%d", 10, 0
	;; msg db "Hello, world!", 0
section .bss
section .text
print_num:
	push rbp
	mov rbp, rsp
	sub rsp, 32

	; 여기서는 ecx로 인자를 받았기에,
	; rbp를 거쳐서 eax에 전달하고 있다.
	; 사실 그냥 mov eax, ecx 해도 된다.
	; 여기서 rbp+16 은?
	; 	ㄴ caller 에서 확보해 놓은, 스택 메모리이다.
	mov dword [rbp + 16], ecx
	mov eax, dword [rbp + 16]
	;     만약 eax의 부호가 있다면
	;     movsxd rbp, ecx 
	; 	    를 써서 rbp에 옮기거나
	;     부호 없는 32비트 값이라면
	;     mov ebp, ecx 를 쓰면 된다. (이때 남은 32비트는 0으로 클리어)

	lea rcx, fmt2 ;; print의 첫 번째 인자
	mov edx, eax ;; printf의 인자 2
	call printf
	nop ;; !!
	add rsp, 32
	pop rbp
	ret
main:
	push rbp
	mov rbp, rsp
	sub rsp, 32

	lea rax, fmt1
	mov r8d, 200  ;; printf의 인자 3
	mov edx, 100  ;; printf의 인자 2
	mov rcx, rax    ;; printf의 첫 번째 인자
	call printf

	mov ecx, 8484
	call print_num
	mov ecx, 0

	add rsp, 32
	pop rbp
	ret