+++
title = on C++
date = "2024-10-10"

[taxonomies]
tags = ["c++", "notes"]
+++
# STL
## Unordered Maps
Internally, the elements are not sorted in any particular order, but organized into buckets. Which bucket an element is placed into depends entirely on the hash of its key. 
###  Iterators
* `begin()` / `cbegin()` – iterator to beginning
* `end()` / `cend()` – iterator to end
###  Capacity
* `empty()` – check if empty
* `size()` – number of elements
* `max_size()` – max possible elements
###  Modifiers
* `clear()` – remove all elements
* `insert()` – insert elements
* `insert_range()` *(C++23)* – insert range
* `insert_or_assign()` *(C++17)* – insert or overwrite
* `emplace()` – construct in-place
* `emplace_hint()` – construct with hint
* `try_emplace()` *(C++17)* – insert only if key absent
* `erase()` – remove elements
* `swap()` – swap contents
* `extract()` *(C++17)* – extract node
* `merge()` *(C++17)* – merge another container
###  Lookup
* `at()` – access with bounds checking
* `operator[]` – access or insert
* `count()` – count matching keys
* `find()` – find element
* `contains()` *(C++20)* – check existence
* `equal_range()` – range of matching keys
###  Bucket Interface
* `bucket_count()` – number of buckets
* `max_bucket_count()` – max buckets
* `bucket_size()` – elements in bucket
* `bucket(key)` – bucket index for key
* `begin(bucket)` / `end(bucket)` – bucket iterators
###  Hash Policy
* `load_factor()` – avg elements per bucket
* `max_load_factor()` – get/set max load
* `rehash()` – rebuild hash table
* `reserve()` – reserve space
###  Observers
* `hash_function()` – hash function
* `key_eq()` – key equality function


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
