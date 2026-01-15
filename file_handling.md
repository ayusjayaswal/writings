
+++
title = "File Handling"
date = 2025-10-04
draft = false

[taxonomies]
tags = ["notes"]
+++
## Bash

### Basic File Reading

**Line-by-line reading:**
```bash
while IFS= read -r line; do
    echo "$line"
done < file.txt
```
 `IFS=` prevents trimming whitespace; `-r` prevents backslash escaping; Each iteration gets one complete line


### AWK - Pattern Scanning & Processing

**How AWK reads:**
 Reads file line by line automatically; Splits each line into fields by whitespace (default); `$0` = entire line, `$1` = first field, `$2` = second field, etc.

**Essential AWK patterns:**
```bash
# Print specific column
awk '{print $2}' file.txt

# Print with custom delimiter
awk -F',' '{print $1, $3}' file.csv

# Pattern matching + action
awk '/error/ {print $0}' log.txt

# Conditional printing
awk '$3 > 100 {print $1, $3}' data.txt

# NR is line number, NF is field count
awk 'NR==5 {print}' file.txt           # 5th line
awk '{print NF, $NF}' file.txt         # field count and last field
```

** `awk 'condition {action}' file` **

### SED - Stream Editor

**How SED reads:**
 Processes file line by line; Applies pattern/command to each line; By default, prints all lines

```bash
# Substitute (first occurrence)
sed 's/old/new/' file.txt

# Substitute (all occurrences on each line)
sed 's/old/new/g' file.txt

# Delete lines matching pattern
sed '/pattern/d' file.txt

# Print only matching lines
sed -n '/pattern/p' file.txt

# Replace line 3
sed '3s/.*/new line/' file.txt

# Delete lines 2-5
sed '2,5d' file.txt

# Edit file in place
sed -i 's/old/new/g' file.txt
```

`sed 's/find/replace/g' file` (think: **s**ubstitute)

---

## Python
 `readline()` reads until newline character (`\n`); `readlines()` splits file at each `\n` into a list; Iterating over file object yields one line at a time

### Reading Files

```python
# Method 1: Auto-closes file
with open('file.txt', 'r') as f:
    content = f.read()              # entire file as string

# Method 2: Line by line (memory efficient)
with open('file.txt', 'r') as f:
    for line in f:
        print(line.strip())         # strip() removes \n

# Method 3: All lines as list
with open('file.txt', 'r') as f:
    lines = f.readlines()           # ['line1\n', 'line2\n', ...]
```

### Writing Files

```python
with open('file.txt', 'w') as f:    # 'w' = overwrite, 'a' = append
    f.write('Hello\n')
    f.writelines(['line1\n', 'line2\n'])
```

**Split line into fields:**
```python
line = "name,age,city"
fields = line.split(',')            # ['name', 'age', 'city']
```

---

## C++

**How C++ reads:**
- `getline()` reads until newline (`\n`), excludes the `\n`
- `>>` operator reads until whitespace (space, tab, newline)
- `istringstream` splits a string by whitespace

### Reading Files

```cpp
#include <fstream>
#include <sstream>
#include <string>
using namespace std;

// Line by line
ifstream file("file.txt");
string line;
while (getline(file, line)) {
    cout << line << endl;
}
file.close();

// Split line into words
string text = "hello world example";
istringstream iss(text);
string word;
while (iss >> word) {               // reads until whitespace
    cout << word << endl;
}
```

### Writing Files

```cpp
ofstream file("output.txt");        // creates/overwrites
file << "Hello" << endl;
file.close();

// Append mode
ofstream file("output.txt", ios::app);
```

**Split by custom delimiter:**
```cpp
#include <sstream>
string line = "a,b,c";
istringstream ss(line);
string token;
while (getline(ss, token, ',')) {   // split by comma
    cout << token << endl;
}
```

---

## Java

 `BufferedReader.readLine()` reads until `\n`, excludes it; `Scanner.nextLine()` reads until `\n`, excludes it; `String.split()` divides string by delimiter

### Reading Files

```java
import java.io.*;
import java.util.*;

// Method 1: BufferedReader (efficient)
BufferedReader br = new BufferedReader(new FileReader("file.txt"));
String line;
while ((line = br.readLine()) != null) {
    System.out.println(line);
}
br.close();

// Method 2: Scanner (simple)
Scanner sc = new Scanner(new File("file.txt"));
while (sc.hasNextLine()) {
    String line = sc.nextLine();
    System.out.println(line);
}
sc.close();
```

### Writing Files

```java
BufferedWriter bw = new BufferedWriter(new FileWriter("output.txt"));
bw.write("Hello\n");
bw.close();
```

**Split line into fields:**
```java
String line = "a,b,c";
String[] parts = line.split(",");   // ["a", "b", "c"]

// Split by whitespace
String text = "hello world";
String[] words = text.split("\\s+"); // \\s+ = one or more spaces
```

---

## Go

**How Go reads:**
- `bufio.Scanner` splits input by newlines (default)
- `Scan()` advances to next token
- `Text()` returns current token without newline

### Reading Files

```go
package main
import (
    "bufio"
    "fmt"
    "os"
    "strings"
)

func main() {
    // Line by line
    file, _ := os.Open("file.txt")
    defer file.Close()
    
    scanner := bufio.NewScanner(file)
    for scanner.Scan() {                    // reads until \n
        line := scanner.Text()              // excludes \n
        fmt.Println(line)
    }
}
```

### Writing Files

```go
// Write entire content
content := []byte("Hello\nWorld\n")
os.WriteFile("output.txt", content, 0644)

// Buffered writing
file, _ := os.Create("output.txt")
defer file.Close()

writer := bufio.NewWriter(file)
writer.WriteString("Hello\n")
writer.Flush()                              // don't forget!
```

**Split line into fields:**
```go
line := "a,b,c"
fields := strings.Split(line, ",")          // []string{"a", "b", "c"}

// Split by whitespace
text := "hello world"
words := strings.Fields(text)               // []string{"hello", "world"}
```

---

## Quick Reference Table

| Language | Read Line | Split by Space | Split by Delimiter |
|----------|-----------|----------------|-------------------|
| Bash | `read -r line` | `$1 $2 $3` | `IFS=','` |
| Python | `line = f.readline()` | `line.split()` | `line.split(',')` |
| C++ | `getline(file, line)` | `iss >> word` | `getline(ss, token, ',')` |
| Java | `br.readLine()` | `line.split("\\s+")` | `line.split(",")` |
| Go | `scanner.Text()` | `strings.Fields()` | `strings.Split(s, ",")` |

---

## NOTE

- **Python**: Use `with` to avoid forgetting `.close()`
- **C++**: `getline()` for lines, `>>` for words
- **Java**: `BufferedReader` is faster than `Scanner`
- **Go**: Always `defer file.Close()` and `Flush()` writers
- **Bash AWK**: Fields are `$1, $2, $3...`, line is `$0`
- **Bash SED**: `s/find/replace/g` (substitute globally)
