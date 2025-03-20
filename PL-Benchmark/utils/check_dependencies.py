#!/usr/bin/env python3

import os
import sys
import subprocess
import shutil
import platform
from typing import Dict, List, Tuple

def check_command(command: str) -> bool:
    """Check if a command is available in the PATH."""
    return shutil.which(command) is not None

def run_command(command: List[str]) -> Tuple[bool, str, str]:
    """Run a command and return success, stdout, stderr."""
    try:
        process = subprocess.Popen(
            command,
            stdout=subprocess.PIPE,
            stderr=subprocess.PIPE,
            universal_newlines=True
        )
        stdout, stderr = process.communicate()
        return process.returncode == 0, stdout, stderr
    except Exception as e:
        return False, "", str(e)

def check_python_packages(packages: List[str]) -> Dict[str, bool]:
    """Check if Python packages are installed."""
    results = {}
    for package in packages:
        try:
            __import__(package)
            results[package] = True
        except ImportError:
            results[package] = False
    return results

def check_dependencies() -> Dict[str, Dict[str, bool]]:
    """Check all dependencies and return their status."""
    dependencies = {
        "languages": {},
        "build_tools": {},
        "python_packages": {}
    }

    # Check language interpreters and compilers
    language_commands = {
        "python": "python3 --version",
        "node": "node --version",
        "java": "java --version",
        "javac": "javac --version",
        "gcc": "gcc --version",
        "g++": "g++ --version",
        "rustc": "rustc --version",
        "cargo": "cargo --version",
        "go": "go version",
        "swift": "swiftc --version",
        "dotnet": "dotnet --version",
        "perl": "perl --version",
        "php": "php --version",
        "bash": "bash --version",
        "nasm": "nasm --version",
        "ghc": "ghc --version",
        "tsc": "tsc --version",
        "zig": "zig version",
        "R": "R --version",
        "lua": "lua -v",
        "kotlinc": "kotlinc -version",
        "scalac": "scalac -version"
    }

    for command, version_cmd in language_commands.items():
        # First check if the command exists
        if check_command(command):
            # Then check if it runs properly
            success, _, _ = run_command(version_cmd.split())
            dependencies["languages"][command] = success
        else:
            dependencies["languages"][command] = False

    # Check build tools
    build_tools = [
        "make", "cmake", "git", "bc", "column"
    ]

    for tool in build_tools:
        dependencies["build_tools"][tool] = check_command(tool)

    # Check Python packages
    python_packages = [
        "pandas", "numpy", "matplotlib"
    ]

    dependencies["python_packages"] = check_python_packages(python_packages)

    return dependencies

def print_dependencies_report(dependencies: Dict[str, Dict[str, bool]]) -> None:
    """Print a report of all dependencies."""
    print("\n===== PL-Benchmark Dependencies Report =====\n")

    print("System Information:")
    print(f"  OS: {platform.system()} {platform.release()}")
    print(f"  Python: {platform.python_version()}")
    print()

    # Language interpreters and compilers
    print("Language Support:")
    missing_languages = []
    for lang, installed in dependencies["languages"].items():
        status = "✓" if installed else "✗"
        print(f"  {lang}: {status}")
        if not installed:
            missing_languages.append(lang)
    print()

    # Build tools
    print("Build Tools:")
    missing_tools = []
    for tool, installed in dependencies["build_tools"].items():
        status = "✓" if installed else "✗"
        print(f"  {tool}: {status}")
        if not installed:
            missing_tools.append(tool)
    print()

    # Python packages
    print("Python Packages:")
    missing_packages = []
    for package, installed in dependencies["python_packages"].items():
        status = "✓" if installed else "✗"
        print(f"  {package}: {status}")
        if not installed:
            missing_packages.append(package)
    print()

    # Summary
    print("Summary:")
    total_deps = (
        len(dependencies["languages"]) +
        len(dependencies["build_tools"]) +
        len(dependencies["python_packages"])
    )
    missing_deps = len(missing_languages) + len(missing_tools) + len(missing_packages)

    if missing_deps == 0:
        print("  All dependencies are installed. You're ready to run benchmarks!")
    else:
        print(f"  Missing {missing_deps}/{total_deps} dependencies.")

        if missing_languages:
            print("\nMissing language support:")
            for lang in missing_languages:
                installation_cmd = get_installation_command(lang)
                print(f"  - {lang}: {installation_cmd}")

        if missing_tools:
            print("\nMissing build tools:")
            for tool in missing_tools:
                installation_cmd = get_installation_command(tool)
                print(f"  - {tool}: {installation_cmd}")

        if missing_packages:
            print("\nMissing Python packages:")
            print(f"  Run: pip install {' '.join(missing_packages)}")

    print("\n===========================================\n")

def get_installation_command(program: str) -> str:
    """Get installation command for a program based on the OS."""
    os_name = platform.system().lower()

    if os_name == "darwin":  # macOS
        return f"brew install {program}"
    elif os_name == "linux":
        if shutil.which("apt-get"):  # Debian/Ubuntu
            return f"sudo apt-get install {program}"
        elif shutil.which("dnf"):  # Fedora
            return f"sudo dnf install {program}"
        elif shutil.which("pacman"):  # Arch
            return f"sudo pacman -S {program}"
        else:
            return "Use your package manager to install"
    elif os_name == "windows":
        return f"Install using winget or download from the official website"
    else:
        return "Use your package manager to install"

def main():
    dependencies = check_dependencies()
    print_dependencies_report(dependencies)

    # Exit with an error code if any dependencies are missing
    missing_deps = any(
        not installed
        for category in dependencies.values()
        for installed in category.values()
    )

    if missing_deps:
        sys.exit(1)
    else:
        sys.exit(0)

if __name__ == "__main__":
    main()
