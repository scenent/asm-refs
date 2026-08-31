;; ===============================
;; #include <stdio.h>
;; int main() {
;;     unsigned char a = 0b10100101;
;;     unsigned char b = 0b11001100;
;;
;;     printf("%d\n", a & b);
;;     printf("%d\n", a | b);
;;     printf("%d\n", a ^ b);
;;     printf("%d\n", ~a);
;;     printf("%d\n", a << 2);
;;     printf("%d\n", a >> 2);
;; }
;; ===============================

default rel
bits 64

extern printf
global main

section .data
    msg db "%d", 10, 0

section .text

main:
    push rbp
    mov rbp, rsp
    sub rsp, 48

    mov byte [rbp - 1], 10100101b    ; 165
    mov byte [rbp - 2], 11001100b    ; 204


    ; ========================================
    ; printf("%d\n", a & b);
    ;
    ; 10100101 = 165
    ; 11001100 = 204
    ; ----------------
    ; 10000100 = 132
    ; ========================================

    movzx eax, byte [rbp - 1]
    and eax, [rbp - 2]

    mov edx, eax
    lea rcx, [msg]
    call printf


    ; ========================================
    ; printf("%d\n", a | b);
    ;
    ; 10100101 = 165
    ; 11001100 = 204
    ; ----------------
    ; 11101101 = 237
    ; ========================================

    ;; movzx eax, byte [rbp - 1]
    ;; or eax, [rbp - 2]
    movzx eax, byte [rbp - 1]
    movzx edx, byte [rbp - 2]
    or eax, edx

    mov edx, eax
    lea rcx, [msg]
    call printf


    ; ========================================
    ; printf("%d\n", a ^ b);
    ;
    ; 10100101
    ; 11001100
    ; --------
    ; 01101001 = 105
    ; ========================================

    ;; movzx eax, byte [rbp - 1]
    ;; xor eax, [rbp - 2]
    movzx eax, byte [rbp - 1]
    movzx edx, byte [rbp - 2]
    xor eax, edx

    mov edx, eax
    lea rcx, [msg]
    call printf


    ; ========================================
    ; printf("%d\n", ~a);
    ;
    ; C에서는 unsigned char가 int로 승격된 후
    ; ~ 연산이 수행된다.
    ;
    ; a = 165
    ; 00000000 00000000 00000000 10100101
    ; ~a
    ; 11111111 11111111 11111111 01011010
    ;
    ; signed int = -166
    ; ========================================

    movzx eax, byte [rbp - 1]
    not eax

    mov edx, eax
    lea rcx, [msg]
    call printf


    ; ========================================
    ; printf("%d\n", a << 2);
    ;
    ; a = 165
    ; 165 << 2 = 660
    ;
    ; 00000000 10100101
    ; << 2
    ; 00000010 10010100
    ; = 660
    ; ========================================

    movzx eax, byte [rbp - 1]
    shl eax, 2

    mov edx, eax
    lea rcx, [msg]
    call printf


    ; ========================================
    ; printf("%d\n", a >> 2);
    ;
    ; 165 >> 2 = 41
    ;
    ; 10100101
    ; >> 2
    ; 00101001 = 41
    ; ========================================

    movzx eax, byte [rbp - 1]
    shr eax, 2

    mov edx, eax
    lea rcx, [msg]
    call printf


    ; return 0;
    xor eax, eax

    add rsp, 48
    pop rbp
    ret
