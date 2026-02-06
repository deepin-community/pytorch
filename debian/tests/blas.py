# BLAS performance testing helper
# Copyright (C) 2021 M. Zhou <lumin@debian.org>
import os
import sys
import time
import numpy as np
import torch as th
os.system('update-alternatives --display libblas.so.3-x86_64-linux-gnu')

print('F64 Numpy Refrence Group', end='\t')
sys.stdout.flush()
N, reference = 8, []
for i in range(N):
    x = np.random.rand(4096, 4096).astype(np.float64)
    y = np.random.rand(4096, 4096).astype(np.float64)
    time_start = time.time()
    z = x @ y
    time_end = time.time()
    reference.append(time_end - time_start)
    print('.', end='')
    sys.stdout.flush()
print(f'{1000*np.mean(reference):.1f}ms pm {1000*np.std(reference):.1f}ms')

print('F64 Torch', end='\t')
sys.stdout.flush()
N, results = 8, []
for i in range(N):
    x = th.rand(4096, 4096).to(th.float64)
    y = th.rand(4096, 4096).to(th.float64)
    time_start = time.time()
    z = x @ y
    time_end = time.time()
    results.append(time_end - time_start)
    print('.', end='')
    sys.stdout.flush()
print(f'{1000*np.mean(results):.1f}ms pm {1000*np.std(results):.1f}ms')

if th.cuda.is_available():
    print('F64 Torch [cuda]', end='\t')
    sys.stdout.flush()
    N, results = 8, []
    for i in range(N):
        x = th.rand(4096, 4096).to(th.float64).cuda()
        y = th.rand(4096, 4096).to(th.float64).cuda()
        time_start = time.time()
        z = x @ y
        time_end = time.time()
        results.append(time_end - time_start)
        print('.', end='')
        sys.stdout.flush()
    print(f'{1000*np.mean(results):.1f}ms pm {1000*np.std(results):.1f}ms')

print('F32 Numpy Refrence Group', end='\t')
sys.stdout.flush()
N, reference = 8, []
for i in range(N):
    x = np.random.rand(4096, 4096).astype(np.float32)
    y = np.random.rand(4096, 4096).astype(np.float32)
    time_start = time.time()
    z = x @ y
    time_end = time.time()
    reference.append(time_end - time_start)
    print('.', end='')
    sys.stdout.flush()
print(f'{1000*np.mean(reference):.1f}ms pm {1000*np.std(reference):.1f}ms')

print('F32 Torch', end='\t')
sys.stdout.flush()
N, results = 8, []
for i in range(N):
    x = th.rand(4096, 4096).to(th.float32)
    y = th.rand(4096, 4096).to(th.float32)
    time_start = time.time()
    z = x @ y
    time_end = time.time()
    results.append(time_end - time_start)
    print('.', end='')
    sys.stdout.flush()
print(f'{1000*np.mean(results):.1f}ms pm {1000*np.std(results):.1f}ms')

if th.cuda.is_available():
    print('F32 Torch [cuda]', end='\t')
    sys.stdout.flush()
    N, results = 8, []
    for i in range(N):
        x = th.rand(4096, 4096).to(th.float32).cuda()
        y = th.rand(4096, 4096).to(th.float32).cuda()
        time_start = time.time()
        z = x @ y
        time_end = time.time()
        results.append(time_end - time_start)
        print('.', end='')
        sys.stdout.flush()
    print(f'{1000*np.mean(results):.1f}ms pm {1000*np.std(results):.1f}ms')
