# asm-refs
nasm references for win64

---

Tested on Windows 11 x64

GCC v15.2.0

NASM v3.0.1

### commands

`.c -> .asm (gcc)`

```
gcc -S -O0 -masm=intel main.c -o main.asm
```

`.asm (nasm) -> .obj`

```
nasm main.asm -f win64 -o main.obj
```

`.obj -> .exe`

```
gcc main.obj -o main.exe
gcc main.obj header.obj -o main.exe
```