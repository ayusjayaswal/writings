+++
title = "dsa, math"
date = 2025-10-11
draft = false

[taxonomies]
tags = ["dsa", "notes"]
+++
# Compiler Functions
the g++ compiler provides the following functions for counting bits (from compiler clang|gcc not c++):
```
+ __builtin_clz(x): the number of zeros at the beginning of the number
+ __builtin_ctz(x): the number of zeros at the end of the number
+ __builtin_popcount(x): the number of ones in the number
+ __builtin_parity(x): the parity (even or odd) of the number of ones
```

# Concepts

## Twin Primes
if *n* is prime *n+2* is prime too

## Legendre's
always a prime btw *n^2* and *(n+1)^2*

## Goldbach
for all prim n > 2; n = a + b; a and b are both prime.

## Hamming Distances
the number of positions where the strings differ. For example, hamming(01101,11001) = 2.

# Algos

## ADD
yes we may add without add
```
int add(int a, int b){
        while(b!=0){
                x = a ^ b;
                b = (a&b) << 1;
                a = x;
            }
        return a;
    }
```
ur cooked if u hope to memorize this a good example to work this out is to add 1 and 3
```
            001         = a
            011         = b
            ---
            010 a^b     = x = a
001 a&b ->  010 a&b<<1  = b
            ---
            000 a^b     = x = a
010 a&b ->  100 a&b<<1  = b
            ---
            100 ANS     = x = a
```
## XOR of N Natural Numbers
Its a funny thing, that XORs of n natural numbers have an odd realtionship with the remainders of 4:
``` go
// in go
func xor(n int) int {
    if n%4 == 0 {
        return n;
    } else if n%4 == 1 {
        return 1   
    } else if n%4 == 2 {
        return n+1
    } else if n%4 == 3 {
        return 0
    } 
}
```
## Sieve of Eratosthenes
Here, you preprocess all numbers good with anything related to primes.
```cpp
    #define N = 2e5+10;
    vector<vector<int>> pfreq(N+1);

    void fill_sieve(){
        for(int i = 2; i<N; i++){
            if(pfreq[i].empty()){
                for(int j = i; j<N; j+=i){
                    pfreq[j].push_back(i);
                }
            }
        }
    }
```
for example; when asked how many primes btw L and R u may just do a prefix sum on yewr sieve.

## GCD
Ofc, you can always see ur sieve of eratosthenes to find gcd fast. If in C++ its smart to use gcd fn from numeric; twill use Stein's Binary Algorithm for GCD; with complexity O(log min(x,y)).
```cpp
    #include<numeric>
    std::gcd(x,y);
```

