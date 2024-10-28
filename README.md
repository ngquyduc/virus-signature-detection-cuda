# CUDA Virus Signature Detection

A high-performance parallel implementation of virus signature detection using CUDA. This project demonstrates efficient GPU utilization and advanced CUDA optimization techniques.

## 👥 Authors

- Nguyen Quy Duc
- Pham Ba Thang

## 🎯 Overview

This project implements a parallel virus signature detection system that leverages CUDA to achieve significant speedups over sequential implementations. The system efficiently processes multiple files against numerous virus signatures simultaneously.

## 🚀 Key Features

- Parallel signature matching using CUDA
- Asynchronous kernel execution
- Optimized memory access patterns
- Support for multiple input files and signatures
- High scalability with increasing workload

## 💻 Technical Implementation

### Parallelization Strategy

```cpp
// Kernel configuration
const int BLOCK_SIZE = 1024;
size_t n_tasks = (inputs[file_idx].size - (signatures[sig_idx].size)/2 + 1);
size_t grid_size = (n_tasks + BLOCK_SIZE - 1) / BLOCK_SIZE;

// Thread indexing
int idx = blockIdx.x * blockDim.x + threadIdx.x;
```

### Memory Management

```cpp
// Results storage
vector<bool*> results;

// Asynchronous memory transfer
cudaMemcpyAsync(results[file_idx], dMatchArr,
                signatures.size() * sizeof(bool),
                cudaMemcpyDeviceToHost,
                streams[file_idx]);

// Synchronization
cudaDeviceSynchronize();
```

### Optimization Techniques

1. **Memory Coalescing**

   - Consecutive memory access patterns
   - Efficient warp-level operations

2. **Global Memory Access**

   - Minimized write operations
   - Optimized access patterns

3. **Asynchronous Execution**
   - Multiple CUDA streams
   - Overlapped computation and memory transfers

## 📊 Performance Analysis

### Impact of Signature Count

| Signatures | CUDA Time | Sequential Time | Speedup |
| ---------- | --------- | --------------- | ------- |
| 100        | 347.4ms   | 2.303s          | 7.601x  |
| 200        | 341.1ms   | 4.328s          | 12.690x |
| 400        | 638.9ms   | 8.627s          | 13.502x |
| 800        | 843.5ms   | 15.691s         | 18.603x |
| 1600       | 1.164s    | 30.389s         | 26.099x |

### Impact of Input File Count

| Files | CUDA Time | Sequential Time | Speedup |
| ----- | --------- | --------------- | ------- |
| 1     | 300.2ms   | 883.8ms         | 2.945x  |
| 2     | 322.8ms   | 5.395s          | 16.712x |
| 4     | 449.9ms   | 11.579s         | 25.735x |
| 8     | 921.0ms   | 26.809s         | 29.110x |
| 16    | 1.121s    | 74.200s         | 66.190x |

## 🚀 Getting Started

### Prerequisites

- CUDA-capable GPU (Tested on A100 80GB)
- CUDA Toolkit
- C++ compiler with CUDA support

### Building

```bash
# Clone the repository
git clone https://github.com/yourusername/cuda-virus-detection.git

# Build the project
make

# Run with sample data
sbatch ./a2_slurm_job.sh
```

### Example Usage

```bash
./check.py signatures/sigs-exact.txt tests/virus-0001-Win.Downloader.Banload-242
```

## 📈 Performance Optimization Journey

### Initial Approach

- Sequential kernel execution
- CPU synchronization after each file
- Limited parallelism

### Optimized Implementation

- Asynchronous kernel execution
- Batch result processing
- Improved memory management
- Enhanced parallelism

## 🔍 Key Findings

### Performance Factors

1. **Signature Count Impact**

   - Linear increase in speedup
   - Efficient parallel processing

2. **File Count Impact**

   - Superlinear speedup with more files
   - Excellent scaling properties

3. **Memory Considerations**
   - Coalesced access patterns
   - Minimized global memory operations

## 🎯 Future Improvements

- [ ] Implement shared memory optimizations
- [ ] Add support for larger signature databases
- [ ] Optimize for different GPU architectures
- [ ] Implement dynamic kernel configuration
- [ ] Add support for pattern matching algorithms

## 🛠️ Technical Specifications

- **GPU**: NVIDIA A100 80GB
- **Compute Capability**: 8.0
- **Memory**: 80GB VRAM
- **Block Size**: 1024 threads
- **Grid Size**: Dynamically calculated
