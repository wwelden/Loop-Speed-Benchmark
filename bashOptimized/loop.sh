#!/bin/bash

# Check if argument is provided
if [ $# -ne 1 ]; then
    echo "Please provide a number as command line argument" >&2
    exit 1
fi

# Check if argument is a valid non-zero integer
if ! [[ "$1" =~ ^[0-9]+$ ]] || [ "$1" -eq 0 ]; then
    echo "Please provide a valid non-zero integer" >&2
    exit 1
fi

# Compile and run C program that does the heavy lifting
cat > /tmp/loop.c << 'EOF'
#include <stdio.h>
#include <stdlib.h>
#include <time.h>

int main(int argc, char *argv[]) {
    int input = atoi(argv[1]);
    int a[10000];
    int r = rand() % 10000;

    for (int i = 0; i < 10000; i++) {
        long long sum = 0;
        for (int j = 0; j < 100000; j++) {
            sum += j % input;
        }
        a[i] = sum + r;
    }

    printf("%d\n", a[r]);
    return 0;
}
EOF

# Compile with optimization flags
gcc -O3 /tmp/loop.c -o /tmp/loop

# Run the compiled program
/tmp/loop "$1"

# Clean up
rm /tmp/loop.c /tmp/loop
