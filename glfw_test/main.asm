default rel
bits 64

extern glfwInit
extern glfwCreateWindow
extern glfwMakeContextCurrent
extern glfwWindowShouldClose
extern glfwSwapBuffers
extern glfwPollEvents
extern glfwDestroyWindow
extern glfwTerminate

extern glClearColor
extern glClear

global main

section .data

    title db "NASM + GLFW", 0

    ; float 0.2, 0.3, 0.3, 1.0
    clear_color:
        dd 0.2
        dd 0.3
        dd 0.3
        dd 1.0

section .text

main:

    ; --------------------------------
    ; stack frame
    ; --------------------------------

    push rbp
	;; ************************************************************************************
	;; push r12

    mov rbp, rsp

    ; Win64 shadow space
    sub rsp, 32


    ; --------------------------------
    ; glfwInit()
    ;
    ; int glfwInit(void)
    ;
    ; return:
    ;   EAX = non-zero on success
    ; --------------------------------

    call glfwInit

    test eax, eax
    jz .exit


    ; --------------------------------
    ; glfwCreateWindow(
    ;     800,
    ;     600,
    ;     "NASM + GLFW",
    ;     NULL,
    ;     NULL
    ; )
    ;
    ; GLFWwindow *
    ; glfwCreateWindow(
    ;     int width,
    ;     int height,
    ;     const char *title,
    ;     GLFWmonitor *monitor,
    ;     GLFWwindow *share
    ; )
    ;
    ; RCX = 800
    ; RDX = 600
    ; R8  = title
    ; R9  = NULL
    ;
    ; 5번째 인자 share = stack
    ; --------------------------------

    mov ecx, 800
    mov edx, 600
    lea r8, [rel title]
    xor r9d, r9d

    ; 5th argument
    mov qword [rsp + 32], 0

    call glfwCreateWindow

    ; RAX = GLFWwindow *
    test rax, rax
    jz .terminate

    ; window pointer 보관
    mov r12, rax


    ; --------------------------------
    ; glfwMakeContextCurrent(window)
    ;
    ; RCX = window
    ; --------------------------------

    mov rcx, r12
    call glfwMakeContextCurrent


.main_loop:

    ; --------------------------------
    ; glfwWindowShouldClose(window)
    ;
    ; return:
    ;   EAX = 0 -> 계속
    ;   EAX != 0 -> 종료
    ; --------------------------------

    mov rcx, r12
    call glfwWindowShouldClose

    test eax, eax
    jnz .close


    ; --------------------------------
    ; glClearColor(0.2, 0.3, 0.3, 1.0)
    ;
    ; OpenGL:
    ; void glClearColor(
    ;     GLfloat red,
    ;     GLfloat green,
    ;     GLfloat blue,
    ;     GLfloat alpha
    ; )
    ;
    ; float 인자는 XMM0~XMM3
    ; --------------------------------

    movss xmm0, [rel clear_color + 0]
    movss xmm1, [rel clear_color + 4]
    movss xmm2, [rel clear_color + 8]
    movss xmm3, [rel clear_color + 12]

    call glClearColor


    ; --------------------------------
    ; glClear(GL_COLOR_BUFFER_BIT)
    ;
    ; GL_COLOR_BUFFER_BIT = 0x00004000
    ; --------------------------------

    mov ecx, 0x00004000
    call glClear


    ; --------------------------------
    ; glfwSwapBuffers(window)
    ; --------------------------------

    mov rcx, r12
    call glfwSwapBuffers


    ; --------------------------------
    ; glfwPollEvents()
    ; --------------------------------

    call glfwPollEvents

    jmp .main_loop


.close:

    ; --------------------------------
    ; glfwDestroyWindow(window)
    ; --------------------------------

    mov rcx, r12
    call glfwDestroyWindow


.terminate:

    ; --------------------------------
    ; glfwTerminate()
    ; --------------------------------

    call glfwTerminate


.exit:

    xor eax, eax

    add rsp, 32
    pop rbp
    ret
