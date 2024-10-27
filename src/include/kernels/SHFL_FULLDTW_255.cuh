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
    const index_t l = thid;

    // extern __shared__ value_t Subject_cache[];

    value_t penalty_left = INFINITY;
    value_t penalty_diag = 0;
    value_t penalty_here0 = INFINITY;
    value_t penalty_here1 = INFINITY;
    value_t penalty_here2 = INFINITY;
    value_t penalty_here3 = INFINITY;
    value_t penalty_here4 = INFINITY;
    value_t penalty_here5 = INFINITY;
    value_t penalty_here6 = INFINITY;
    value_t penalty_here7 = INFINITY;
    value_t penalty_temp0;
    value_t penalty_temp1;

    if(thid == 0){
        penalty_left = INFINITY;
        penalty_diag = INFINITY;
        penalty_here0 = INFINITY;
        penalty_here1 = INFINITY;
        penalty_here2 = INFINITY;
        penalty_here3 = INFINITY;
        penalty_here4 = INFINITY;
        penalty_here5 = INFINITY;
        penalty_here6 = INFINITY;
        penalty_here7 = INFINITY;
    }
    const value_t subject_value0 = 1 == 0>0:Subject[base+8*1-1];
    const value_t subject_value1 = Subject[base+8*l-0];
    const value_t subject_value2 = Subject[base+8*l+1];
    const value_t subject_value3= Subject[base+8*l+2];
    const value_t subject_value4 = Subject[base+8*l+3];
    const value_t subject_value5 = Subject[base+8*l+4];
    const value_t subject_value6 = Subject[base+8*l+5];
    const value_t subject_value7 = Subject[base+8*l+6];
    index_t counter = 1;
    value_t query_value = INFINITY;
    value_t new_query_value = cQuery[thid];
    if(thid == 0) query_value = new_query_value;
    if(thid == 0) penalty_here1 = 0;
    new_query_value = __shfl_down_sync(0xFFFFFFFF, new_query_value, 1, 32);

    penalty_temp0 = penalty_here0;
    penalty_here0 = (query_value - subject_value0)*(query_value - subject_value0) + min(penalty_left, min(penalty_here0, penalty_diag));
    penalty_temp1 = INFINITY;
    penalty_here1 = (query_value - subject_value1)*(query_value - subject_value1) + min(penalty_here0, min(penalty_here1, penalty_temp0));
    penalty_temp0 = penalty_here2;
    penalty_here2 = (query_value - subject_value2)*(query_value - subject_value2) + min(penalty_here1, min(penalty_here2, penalty_temp1));
    
}