#ifndef CUDA_DEF_CUH
#define CUDA_DEF_CUH

#include <stdio.h>

#define CUERR {
    cudaError_t err;\
    if((err = cudaGetLastError()) != cudaSuccess){\
            printf("CUDA error : %s : %s, line %d\n", cudaGetErrorString(err), __FILE__, __LINE__); exit(1);}
}