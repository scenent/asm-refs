from pathlib import Path
import subprocess

base_dir = Path(__file__).resolve().parent
obj_dir = base_dir / "obj"
bin_dir = base_dir / "bin"

obj_dir.mkdir(exist_ok=True)
bin_dir.mkdir(exist_ok=True)

for asm_file in base_dir.glob("*.asm"):
    name = asm_file.stem

    obj_file = obj_dir / f"{name}.obj"
    exe_file = bin_dir / f"{name}.exe"

    if exe_file.exists():
        print(f"Skipping {asm_file.name} (already built)")
        continue

    print(f"Building {asm_file.name}...")

    subprocess.run([
        "nasm",
        str(asm_file),
        "-f", "win64",
        "-o", str(obj_file)
    ], check=True)

    subprocess.run([
        "gcc",
        str(obj_file),
        "-o", str(exe_file)
    ], check=True)

    print(f"  -> {exe_file}")

print("Build complete.")
