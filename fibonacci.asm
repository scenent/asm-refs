;; ==============================
;; #include <stdio.h>
;; int fib(int n) {
;;     if (n <= 1) { return n; }
;;     return fib(n - 1) + fib(n - 2);
;; }
;; int main() {
;; 	int n = 1;
;; 	printf("Input natural number : ");
;; 	scanf("%d", &n);
;; 	int f = fib(n);
;; 	printf("%dst Fibonacci = %d", n, f);
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
	fmt3 db "%dst Fibonacci = %d", 0
section .bss
section .text
fib:
	;; 여기서 push rbx 가 왜 등장하는가?
	;; 
	;; 밑의 레지스터들은 Caller-Saved.
	;; 즉, 함수를 부르는 측이 마음대로 조작 가능함.
	;; 	RAX RCX RDX R8 R9 R10 R11
	;; 밑은 Callee-Saved.
	;; 함수 안에서 이 레지스터를 사용하려면
	;; ret전에 이전 값으로 복구해야 한다.
	;; RBX RBP RSI RDI RSP R12 R13 R14 R15
	;;	
	;; 여기서는 rbx에다가
	;; 	fib(n - 1) + fib(n  - 2); 
	;; 	이 과정에서, fib(n-1) 의 반환값 eax를 임시로 저장해두었다.
	;;	(eax 덮어쓰기 방지)
	;; 
	;; rbx는 Callee-Saved 이므로
	;; push rbx / pop rbx 를 써서 복구해줘야 한다.

	push rbp
	push rbx
	sub rsp, 40
	;; GCC컴파일러는, mov rbp, rsp 대신 이렇게 썼다.
	;; int fib(int n); 의 n 이 
	;;	[rbp + 32] 부분에 저장된다.
	;; 그냥 rbp를 32바이트 높게 잡은 것.
	lea rbp, [rsp + 32]
	
	mov dword [rbp + 32], ecx
	cmp dword [rbp + 32], 1
	jg fib_L2
	mov eax, dword [rbp + 32]
	jmp fib_L3
fib_L2:
	mov eax, dword [rbp + 32]
	sub eax, 1
	mov ecx, eax
	call fib
	mov ebx, eax
	mov eax, dword [rbp + 32]
	sub eax, 2
	mov ecx, eax
	call fib
	add eax, ebx
fib_L3:
	add rsp, 40
	pop rbx
	pop rbp
	ret
main:
	push rbp
	mov rbp, rsp
	sub rsp, 48
	
	mov dword [rbp - 8], 1
	lea rax, fmt1
	mov rcx, rax
	call printf

	lea rax, [rbp - 8]
	lea rcx, fmt2
	mov rdx, rax
	call scanf

	mov eax, dword [rbp - 8]
	mov ecx, eax
	call fib

	mov dword [rbp - 4], eax
	mov eax, dword [rbp - 8]
	mov edx, dword [rbp - 4]
	lea rcx, fmt3
	mov r8d, edx
	mov edx, eax
	call printf

	mov eax, 0
	
	add rsp, 48
	pop rbp
	ret