global main
extern printf

default rel
bits 64

struc Person
    .age:   resd 1
    .name:  resq 1
    .score: resq 1
endstruc

section .data

;; struc 정의를 써서, Person person{.age=30, .name = "Alice", .score=95.5}; 만든다.
person:
    istruc Person
        at Person.age,   dd 30
        at Person.name,  dq name
        at Person.score, dq 95.5
    iend

	name db "Alice", 0
	fmt db "age = %d", 10, 0
section .text

main:
    sub rsp, 40

	;; lea rcx, [rel fmt]
	;; 	→ RCX = &fmt
	;; mov rcx, [rel fmt]
	;; 	→ RCX = *(uint64_t *)&fmt
	;; mov ecx, fmt
	;; 	→ ECX = address(fmt)를 32비트 immediate로 넣으려는 형태
	
    ; printf("%d\n", person.age)
    lea rcx, [rel fmt]
    mov edx, [person + Person.age]

    call printf

    add rsp, 40

    xor eax, eax
    ret



