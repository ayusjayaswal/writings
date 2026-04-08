+++
title = "Segment Tree"
date = "2026-04-08"
[taxonomies]
tags = []
+++

# Segment Tree
+ Used for Range Queries
+ Stored as a segment tree array *left=> 2r+1, right=> 2r+2*
+ Segment Tree size is *2n*; *4n* preffered
+ Is a *Balanced Binary Tree*
## Possible Queries
Must be
associative 
```
f(f(a,b), c) == f(a, f(b,c))
```
decomposable 
```
the answer for a range; built from answers of sub-ranges
```
### Example
+ Sum
+ Min/Max
+ GCD/LCM
+ AND/OR/XOR
+ Product
+ Count
## Complexity
Build => *O(n)*
Query => *O(logn)*
Update => *O(logn)*
## sample
```python
arr = [1,2,3,4,5,6,7]

n = len(arr)

# segment tree has 2n nodes
seg = [0] * 2n

def buildTree(root, start, end):
    # leaf node
    if start == end:
        seg[root] = arr[start]
        return

    # recursion
    mid = (start + end) // 2
    buildTree(2*root + 1, start, mid)
    buildTree(2*root + 2, mid+1, end)

    # fill this; decides which operation in query; sum here
    seg[root] = seg[2*root+1] + seg[2*root+2]

def update(root, start, end, id, val):
    if start == end:
        arr[id] = val
        seg[root] = val
        return

    # recursion
    mid = (start + end) // 2
    if id <= mid:
        update(2*root+1, start, mid, id, val)
    else:
        update(2*root+2, mid+1, end, id, val)

    # refill
    seg[root] = seg[2*root+1] + seg[2*root+2]

def query(root, start, end, l, r):
    # outof bounds
    if r < start or l > end:
        return 0

    if l <= start and r >= end:
        return seg[root]

    # recursion
    mid = (start + end) // 2
    left = query(2*root+1, start, mid, l, r)
    right = query(2*root+2, mid+1, end, l, r)

    return left + right

```

To Actually use these
```python
arr = [1,2,3,4,5,6,7,8,9,10]

def useBuild(arr):
    buildTree(0, 0, len(arr)-1)

def useUpdate(arr, id, val):
    update(0, 0, len(arr)-1, id, val)

def useQuery(arr, left, right):
    query(0, 0, len(arr) - 1, left, right)
```
