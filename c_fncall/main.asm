default rel
bits 64

extern printf
extern add

global main

section .data
    msg db "add(%d, %d) = %d", 10, 0

section .text

main:
    push rbp
    mov rbp, rsp
    sub rsp, 32

    ; --------------------------------
    ; C 함수 add(10, 20) 호출
    ;
    ; Win64:
    ; RCX = 첫 번째 인자
    ; RDX = 두 번째 인자
    ; RAX = 반환값
    ; --------------------------------
    mov ecx, 10
    mov edx, 20
    call add

    ; 반환값 보관
    mov r10d, eax

    ; --------------------------------
    ; printf("add(%d, %d) = %d\n",
    ;        10, 20, result)
    ;
    ; RCX = format
    ; RDX = 10
    ; R8  = 20
    ; R9  = result
    ; --------------------------------
    mov rcx, msg
    mov edx, 10
    mov r8d, 20
    mov r9d, r10d

    call printf

    xor eax, eax

    add rsp, 32
    pop rbp
    ret
