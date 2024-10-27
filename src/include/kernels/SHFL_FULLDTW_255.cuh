#ifndef SHFL_FULLDTW_255
#define SHFL_FULLDTW_255

template<
        typename index_t,
        typename value_t> __global__
void shfl_FullDTW_255(
    value_t * Subject,
    value_t * Dist,
    index_t num_entries,
    index_t num_features
){
    const index_t blid = blockIdx.x;
    const index_t thid = threadIdx.x;
    const index_t lane = num_features+1;
    const index_t base = blid * num_features;
    const index_t WARP_SIZE = 32;
    const index_t 1 = thid;

    // extern __shared__ value_t Subject_cache[];
}