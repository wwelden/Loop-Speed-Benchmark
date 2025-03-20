#!/bin/bash

# Create output directories if they don't exist
mkdir -p implementations/assembly
mkdir -p implementations/zig

# Make all scripts executable
chmod +x implementations/*/*.sh
chmod +x implementations/*/*.py
chmod +x implementations/*/*.js
chmod +x implementations/*/*.ts
chmod +x implementations/*/*.lua
chmod +x implementations/*/*.php
chmod +x implementations/*/*.pl
chmod +x implementations/*/*.R

# Compile C implementation
gcc -O3 implementations/c/mergesort.c -o implementations/c/mergesort

# Compile C++ implementation
g++ -O3 implementations/cpp/mergesort.cpp -o implementations/cpp/mergesort

# Compile Java implementation
javac implementations/java/Mergesort.java

# Compile Rust implementation
cd implementations/rust && cargo build --release && cd ../..

# Compile Go implementation
go build -o implementations/go/mergesort implementations/go/mergesort.go

# Compile Swift implementation
swiftc -O implementations/swift/mergesort.swift -o implementations/swift/mergesort

# Compile Assembly implementation
cd implementations/assembly
nasm -f macho64 mergesort.asm -o mergesort.o
gcc -o mergesort mergesort.o
cd ../..

# Compile Zig implementation
cd implementations/zig
zig build-exe mergesort.zig -O ReleaseFast -femit-bin=mergesort
cd ../..

# Compile Kotlin implementation
kotlinc implementations/kotlin/mergesort.kt -include-runtime -d implementations/kotlin/mergesort.jar

# Compile Scala implementation
scalac implementations/scala/Mergesort.scala

# Compile TypeScript implementation
tsc implementations/typescript/mergesort.ts

# Compile C# implementation
dotnet build implementations/csharp/mergesort.csproj -c Release

echo "All implementations have been compiled."
