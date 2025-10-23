+++
title = on C++
date = "2024-10-10"

[taxonomies]
tags = ["c++"]
+++

## On Functions
    + C++17 and later: function arguments are evaluated left to right.(Same in Python but unspecified in C)
    + Pre-C++17 (C++98/11/14): the order was unspecified — compilers could choose.
    + After arguments are evaluated, parameters are constructed in declaration order in the function signature.

### Block level details
    + Construction happens top-to-bottom (in the order of declaration).
    + Destruction happens reverse order (bottom-to-top).
### C++ Keywords & Qualifiers

**1. `volatile`**

* Meaning: prevents compiler from optimizing accesses to a variable;
* Ensures every read/write goes to memory;
* Use for: hardware registers, signal handlers;
* Not thread-safe;

**2. `std::atomic<T>`**

* Meaning: atomic (indivisible) operations on variables;
* Provides memory ordering and visibility across threads;
* Prevents data races;
* Use for: multithreaded shared variables;

**3. `register`** *(deprecated)*

* Meaning: old hint to store variable in CPU register;
* Modern compilers ignore it;

**4. `mutable`**

* Meaning: allows modification of a member in a `const` object;
* Use for: caches, lazy evaluation fields;

**5. `const`**

* Meaning: variable cannot be modified after initialization;
* Use for: immutability guarantee;

**6. `constexpr`**

* Meaning: evaluated at compile time if possible;
* Use for: compile-time constants, optimizations;
