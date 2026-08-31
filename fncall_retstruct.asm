;; ==============================
;; #include <stdio.h>
;; struct MyStruct {
;; 	int value;
;; 	float value2;
;; };
;; struct MyStruct do_something(int a, int b, int c) {
;; 	int n = (a + b) * c;
;; 	n *= 2;
;; 	struct MyStruct result = (struct MyStruct) {
;; 		.value = n,
;; 		.value2 = 3.14f
;; 	};
;; 	return result;
;; }
;; int main() {
;;     struct MyStruct retStruct = do_something(3, 5, 2);
;;     printf("retStruct.value = %d\n", retStruct.value);
;;     printf("retStruct.value2 = %f\n", retStruct.value2);
;; }
;; ==============================


default rel
bits 64

extern printf

global main

section .data
        fmt1 db "refStruct.value = %d", 10, 0
	fmt2 db "refStruct.value2 = %f", 10, 0
section .rodata
	align 4
	F0: dd 3.14
section .bss
section .text
do_something:
	push rbp
	mov rbp, rsp
	sub rsp, 16

	mov dword [rbp + 16], ecx
	mov dword [rbp + 24], edx
	mov dword [rbp + 32], r8d
	mov edx, dword [rbp + 16]
	mov eax, dword [rbp + 24]
	add edx, eax
	mov eax, dword [rbp + 32]
	imul eax, edx
	;; 이게 뭐지? 할당한 스택에 eax복사하고 (= int n)
	mov dword [rbp - 4], eax
	sal dword [rbp - 4], 1 ;; 아하. 2를 곱하는게 shift 로 치환된거구나. (n = n << 1).

	mov eax, dword [rbp - 4]
	mov dword [rbp - 12], eax

	movss xmm0, [rel F0]
	movss dword [rbp - 8], xmm0 ;; struct의 두 번째 : float value2; 값. -> [rbp - 8] 에 들어감. 
	mov rax, qword [rbp - 12]      ;; struct의 첫 번째 : int value; 값. -> rax에 들어감

	add rsp, 16
	pop rbp
	ret
main:
	push rbp
	mov rbp, rsp
	sub rsp, 48

	;; cx - dx - r8 - r9 - 스택 (rsp+N) ... 순으로
	mov r8d, 2
	mov edx, 5
	mov ecx, 3
	call do_something
	mov qword [rbp - 8], rax ;; 첫 번재 인자 복사하기. (일단 qword로)
	mov eax, dword [rbp - 8] ;; eax에 dword형식.
	lea rcx, fmt1
	mov edx, eax
	call printf
	movss xmm0, dword [rbp - 4]
	cvtss2sd xmm0, xmm0
	movapd xmm1, xmm0
	movapd xmm0, xmm1
	movq rdx, xmm1
	lea rax, fmt2
	movapd xmm1, xmm0
	mov rcx, rax
	call printf
	mov eax, 0

	add rsp, 48
	pop rbp
	ret