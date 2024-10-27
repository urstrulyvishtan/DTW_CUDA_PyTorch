#ifndef DTW_HPP
#define DTW_HPP

namespace FullDTW{
#include "./kernels/SHFL_FULLDTW_127.cuh"
#include "./kernels/SHFL_FULLDTW_255.cuh"
#include "./kernels/SHFL_FULLDTW_511.cuh"
#include "./kernels/SHFL_FULLDTW_1023.cuh"
#include "./kernels/SHFL_FULLDTW_2047.cuh"
#include "./kernels/SUB_WARP"
#include "./kernels/SUB_WARP_MULTI_QUERY.cuh"
}