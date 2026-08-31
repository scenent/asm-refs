;; ==============================
;; #include <stdio.h>
;; int main() {
;;	int arr[5] = { 1, 2, 3, 4, 5 };
;;	for (int i = 0; i < 5; i++) {
;;		printf("%d\n", arr[i]);
;;	}
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
main:
	push rbp
	mov rbp, rsp
	sub rsp, 64

	mov dword [rbp - 32], 1
	mov dword [rbp - 28], 2
	mov dword [rbp - 24], 3
	mov dword [rbp - 20], 4
	mov dword [rbp - 16], 5

	;; 이건 forloop의 카운터 변수 i.
	mov dword [rbp - 4], 0
	jmp L2
L3: ;; forloop 안.
	;; eax = i
	mov eax, dword [rbp - 4]
	;; rax = eax
	;; cdqe : eax를 부호 있는 32비트로써 rax로 확장시킨다.
	;;	mov eax, 0xFFFFFFFF 를 하면
	;;	rax의 값은 자동으로 0x00000000FFFFFFFF (상위비트 클리어)
	;; 	여기서 cdqe 부르면
	;;	rax의 값이 0xFFFFFFFFFFFFFFFF 로 변함.
	;; 참고:
	;; 	cbw: AL → AX
	;; 	cwde: AX → EAX
	;; 	cdqe: EAX → RAX
	cdqe
	;; nasm의 메모리 주소 표현식:
	;; 	[base + index * scale + displacement]
	;; rax값이 0이면
	;;	rbp + 0 - 32, 즉 1
	;; rax값이 1이면
	;;	rbp + 4 - 32, 즉 2 이런식.
	mov eax, dword [rbp + rax * 4 - 32]
	lea rcx, fmt1
	mov edx, eax
	call printf
	add dword [rbp - 4], 1
L2:
	cmp dword [rbp - 4], 4
	jle L3 ;; 아직 루프 끝나지 않음

	mov eax, 0

	add rsp, 64
	pop rbp
	ret