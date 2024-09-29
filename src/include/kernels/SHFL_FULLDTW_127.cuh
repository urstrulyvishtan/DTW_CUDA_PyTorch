#ifndef SHFL_FULLDTW_127
#define SHFL_FULLDTW_127

template<
    typename index_t,
    typename value_t> __global__
void shfl_FullDTW_127(
    value_t * Subject,
    value_t * Dist,
    index_t num_entries,
    index_t num_features){
    
    const index_t blid = blockIdx.x;
    const index_t thid = threadIdx.x;
    const index_t lane = num_features + 1;
    const index_t base = blid * num_features;
    const index_t WARP_SIZE = 32;
    const index_t l = thid;

    value_t penalty_left = INFINITY;
    value_t penalty_diag = 0;
    value_t penalty_here0 = INFINITY;
    value_t penalty_here1 = INFINITY;
    value_t penalty_here2 = INFINITY;
    value_t penalty_here3 = INFINITY;
    value_t penalty_temp0;
    value_t penalty_temp1;
    }