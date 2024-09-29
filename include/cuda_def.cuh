/*
 * This header file defines several macros and constants to facilitate CUDA programming.
 * 
 * 1. Error Checking Macro (CUERR):
 *    - This macro checks for any CUDA errors that occurred during the execution of CUDA code.
 *    - If an error is detected, it prints the error message, the file name, and the line number, then exits the program.
 * 
 * 2. Integer Division Macro (SDIV):
 *    - This macro performs integer division and rounds up the result.
 *    - It is useful for calculating the number of blocks needed when launching CUDA kernels.
 * 
 * 3. Grid and Block Dimensions (GRIDDIM and BLOCKDIM):
 *    - These macros define the dimensions of the grid and blocks for CUDA kernels.
 *    - GRIDDIM is set to 1024, and BLOCKDIM is also set to 1024.
 * 
 * 4. Timing Macros (STARTTIME and STOPTIME):
 *    - These macros are used to measure the execution time of CUDA code.
 *    - STARTTIME initializes and records the start event.
 *    - STOPTIME records the stop event, synchronizes it, calculates the elapsed time, and prints it.
 * 
 * Usage:
 * - Include this header file in your CUDA source files to use these macros and constants.
 * - Use CUERR after CUDA API calls to check for errors.
 * - Use SDIV to calculate the number of blocks for kernel launches.
 * - Use STARTTIME and STOPTIME to measure the execution time of CUDA code.
 *
 * - @author : Sibi Thirukonda
 */
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
// Macro to perform integer division and round up
#define SDIV(x, y) ((x + y - 1) / y)

// Define the grid and block dimensions for CUDA kernels
#define GRIDDIM (1024)
#define BLOCKDIM (1024)

// Macros to measure the execution time of CUDA code
#define STARTTIME cudaEvent_t Mstart, Mstop;\
                  float Mtime;\
                  cudaEventCreate(&Mstart); /* Create start event */\
                  cudaEventCreate(&Mstop); /* Create stop event */\
                  cudaEventRecord(Mstart, 0); /* Record the start event */
                
#define STOPTIME cudaEventRecord(Mstop, 0); /* Record the stop event */\
                 cudaEventSynchronize(Mstop); /* Wait for the stop event to complete */\
                 cudaEventElapsedTime(&Mtime, Mstart, Mstop); /* Calculate elapsed time */\
                 std::cout << "Mtime: " << Mtime << std::endl; /* Print the elapsed time */

#endif // CUDA_DEF_CUH