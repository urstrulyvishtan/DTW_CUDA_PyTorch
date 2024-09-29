#ifndef CUDA_DEF_CUH
#define CUDA_DEF_CUH

#include <stdio.h>

// Macro to check for CUDA errors
#define CUERR {\
    cudaError_t err; /* Variable to store the error code */\
    if((err = cudaGetLastError()) != cudaSuccess){ /* Check if there was an error */\
        /* Print the error message, file name, and line number, then exit */\
        printf("CUDA error : %s : %s, line %d\n", cudaGetErrorString(err), __FILE__, __LINE__); \
        exit(1);\
    }\
}

#endif // CUDA_DEF_CUH