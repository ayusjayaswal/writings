
# Synchronization

=Serialization:= Event A must happen before Event B.
=Mutual exclusion:= Events A and B must not happen at the same time.

programmer has no control over when each thread runs; the operating system (specifically, the scheduler) makes those decisions.

Two events are concurrent if we cannot tell by looking at the program which will happen first. Concurrent programs are often non-deterministic

An update might appear to be one instruction in your fancy languages but in machine code it often translates to read then compute then write and this can be intercepted by another variable using a shared variable.

AN OPERATION THAT CANNOT BE INTERRUPTED IS SAID TO BE ATOMIC.

# Semaphore

A semaphore is like an integer, with three differences:
    1. When you create the semaphore, you can initialize its value to any integer, but after that the only operations you are allowed to perform are increment (increase by one) and decrement (decrease by one). You cannot read the current value of the semaphore.
    2. When a thread decrements the semaphore, if the result is negative, the thread blocks itself and cannot continue until another thread increments the semaphore.
    3. When a thread increments the semaphore, if there are other threads waiting, one of the waiting threads gets unblocked.

If the value is positive, then it represents the number of threads that can decrement without blocking. If it is negative, then it represents the number of threads that have blocked and are waiting. If the value is zero, it means there are no threads waiting, but if a thread tries to decrement, it will block.

• In general, there is no way to know before a thread decrements a semaphore whether it will block or not (in specific cases you might be able to prove that it will or will not).

• After a thread increments a semaphore and another thread gets woken up, both threads continue running concurrently. There is no way to know which thread, if either, will continue immediately.

• When you signal a semaphore, you don’t necessarily know whether another thread is waiting, so the number of unblocked threads may be zero or one.

On names,
    increment and decrement describe what the operations do. signal and wait describe what they are often used for. And V and P were the original names proposed by Dijkstr

# Basic synchronization patterns

Possibly the simplest use for a semaphore is signaling, which means that one thread sends a signal to another thread to indicate that something has happened.

The mutex guarantees that only one thread accesses the shared variable at a time.

```
mutex.wait ()
    // critical section
    count = count + 1
mutex.signal ()
```

# Multiplex
Generalize the previous solution so that it allows multiple threads to
run in the critical section at the same time, but it enforces an upper limit on
the number of concurrent threads. In other words, no more than n threads can
run in the critical section at the same time. This pattern is called a MULTIPLEX

# Classical synchronization problems


