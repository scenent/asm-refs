gcc -c hello.c -o hello.obj
nasm main.asm -f win64 -o main.obj
gcc main.obj hello.obj -o main.exe
pause