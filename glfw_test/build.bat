nasm main.asm -f win64 -o main.obj
gcc main.obj libglfw3.a -lopengl32 -lgdi32 -o main.exe
pause