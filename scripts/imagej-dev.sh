#!/usr/bin/env fish

if test (count $argv) -lt 1
    echo "Usage: imagej-dev <path-to-plugin-folder>"
    exit 1
end

set TARGET_DIR (realpath $argv[1])

if not test -d "$TARGET_DIR"
    echo "Error: Directory '$TARGET_DIR' does not exist."
    exit 1
end

set IJ_JARS (nix-build --no-out-link '<nixpkgs>' -A imagej)/share/imagej/jars/*
set CLASSPATH (string join ":" $IJ_JARS)

# Find all .java files in the directory and compile them
set JAVA_FILES (find "$TARGET_DIR" -maxdepth 1 -name "*.java")

if test (count $JAVA_FILES) -eq 0
    echo "Warning: No .java files found in $TARGET_DIR. Skipping compilation."
else
    javac -cp "$CLASSPATH" $JAVA_FILES
    if test $status -ne 0
        exit 1
    end
end

imagej -Dij1.plugin.dirs="$TARGET_DIR"