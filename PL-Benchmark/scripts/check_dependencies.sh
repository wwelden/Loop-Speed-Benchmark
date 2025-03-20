#!/bin/bash

# Script to check for required dependencies

# Source common utilities
source "$(dirname "$(dirname "$0")")/utils/common.sh"

# Run dependency check
check_dependencies

# Provide installation instructions based on OS
os=$(detect_os)
echo ""
echo -e "${BLUE}Installation instructions for missing dependencies:${NC}"

if [[ "$os" == "macos" ]]; then
    echo -e "${YELLOW}For macOS (using Homebrew):${NC}"
    echo "brew install gcc node npm go python3 php perl lua ruby rust swift nasm dotnet ghc kotlin zig r"
elif [[ "$os" == "linux" ]]; then
    echo -e "${YELLOW}For Ubuntu/Debian:${NC}"
    echo "sudo apt update"
    echo "sudo apt install gcc g++ nodejs npm golang python3 php perl lua5.3 ruby cargo default-jdk swift nasm dotnet-sdk-8.0 ghc kotlin zig r-base"
    echo ""
    echo -e "${YELLOW}For Fedora:${NC}"
    echo "sudo dnf install gcc gcc-c++ nodejs npm golang python3 php perl lua ruby cargo java-latest-openjdk-devel swift nasm dotnet-sdk-8.0 ghc kotlin zig R"
elif [[ "$os" == "windows" ]]; then
    echo -e "${YELLOW}For Windows (using Chocolatey):${NC}"
    echo "choco install gcc nodejs npm golang python3 php perl lua ruby rust-ms jdk11 swift nasm dotnetcore-sdk ghc kotlin zig r"
else
    echo -e "${RED}Unknown OS. Please install the required dependencies manually.${NC}"
fi

echo ""
echo -e "${BLUE}Note: Some languages may require additional setup after installation.${NC}"

exit 0
