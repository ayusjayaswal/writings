+++
title = "Python for Interviews"
date = "2026-58-15"
[taxonomies]
tags = []
+++

# Slicing
Often for string/array ops you may need to perform fancy iterations, tis always simpler to just be smart with slicing.
```python
[start : stop : step]
```
for example, say you must reverse every k sized block for a list
```python
    lis = [1,2,3,4,5,6,7,8,9,10]
    n = len(lis)
    assert k > 0
    for i in range(0,n,k):
        lis[i:i+k] = lis[i:i+k][::-1]
        # or just lis[i:i+k] = reversed(lis[i:i+k])
```
# Web Things
Often, someone would want you to quickly spin up a web-dih project in smallest possible time. A wise man would choose fastapi
for simplest syntax, less boilerplate circus and auto docs are of extreme importance when you debug you might not have do a hudred curls etc.
You can always use express if you fancy that or maybe flask. But, I'll strongly suggest sticking to fastapi
```python
from fastapi import FastAPI

app = FastAPI()

@app.get("/")
def home():
    return "hello"
```
Now to run the simple server above.
```sh
# uvicorn <file name without py>:<name of fastapi object>
uvicorn server:app
``` 
