+++
title = "Operating systems in 3 easy pieces"
date = 2025-04-13
draft = false

[taxonomies]
tags = ["operating_systems", "notes"]
+++

# 1 Virtualization
THE CRUX OF THE PROBLEM: HOW TO PROVIDE THE ILLUSION OF MANY CPUS?

Time sharing By allowing the resource to be used for a little while by one
entity, and then a little while by another, and so forth, the resource in
question can be shared by many. (CONTEXT SWITCH) 

The natural counterpart of time sharing is space sharing, where a resource is
divided (in space) among those who wish to use it.

older OSs did eager loading of programs ie loading all the program instr directly
mordern OS do lazy loading. only necesary instrns are loaded.

STATES: /running ready blocked/

### fork
```
fork() -> 0 CHILD, +vePID PARENT, -ve ERROR
non-deterministic execution
```
### wait
```
rc = fork();
if(rc == 1){
    wait();
    };
```
### exec
```
run another program 
-1 on failure; nothing returned on success
```

## Limited Direct Execution
## Virtual Memory
+ Solves Memory fragmentation
+ Solves Less Memory
+ Solves Program corrupting other programs data

Every process gets its own virtual memory
```
PROCESS --> VIRTUAL --> MMU --> RAM 
            MEMORY      PAGE    or
                        TABLE   SWAP
```
A page is dirty if a process has written something to it after loading from disk

DMA Direct memory access; bring data from disk to RAM directly.
MMU address translation and generates Page Faults
### Translation Lookaside Buffer (TLB)
hardware component to CPU translates Virtual Address to Physical; very fast
+ Instruction TLB
+ Data TLB
use page table to fetch things then fill TLB; if this thing is needed again TLB will
give it faster
