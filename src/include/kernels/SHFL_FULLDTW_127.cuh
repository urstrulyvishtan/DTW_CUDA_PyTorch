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

    if(thid == 0){
        penalty_left = INFINITY;
        penalty_diag = INFINITY;
        penalty_here0 = INFINITY;
        penalty_here1 = INFINITY;
        penalty_here2 = INFINITY;
        penalty_here3 = INFINITY;
    }

    const value_t subject_value0 = 1 == 0?0:Subject[base+4*1-1];
    const value_t subject_value1 = Subject[base+4*1-0];
    const value_t subject_value2 = Subject[base+4*1+1];
    const value_t subject_value3 = Subject[base+4*1+2];

    index_t counter = 1;
    value_t query_value = INFINITY;
    value_t new_query_value = cQuery[thid];
    if(thid == 0) query_value = new_query_value;
    if(thid == 0) penalty_here1 = 0;
    new_query_value = __shfl_down_sync(0xFFFFFFFF, new_query_value, 1, 32);

    penalty_temp0 = penalty_here0;
    penalty_here0 = (query_value-subject_value0) * (query_value-subject_value0) + min(penalty_left, min(penalty_here0, penalty_temp0));
    penalty_temp1 = INFINITY;
    penalty_here1 = (query_value-subject_value1) * (query_value-subject_value1) + min(penalty_here0, min(penalty_here1, penalty_temp0));
    penalty_temp0 = penalty_here2;
    penalty_here2 = (query_value-subject_value2) * (query_value-subject_value2) + min(penalty_here1, min(penalty_here2, penalty_temp1));
    penalty_here3 = (query_value-subject_value3) * (query_value-subject_value3) + min(penalty_here2, min(penalty_here3, penalty_temp0));

    query_value = __shfl_up_sync(0xFFFFFFFF, query_value, 1, 32);
    if(thid == 0) query_value = new_query_value;
    new_query_value = __shfl_down_sync(0xFFFFFFFF, new_query_value, 1, 32);
    counter++;
    
    penalty_diag = penalty_left;
    penalty_left = __shfl_up_sync(0xFFFFFFFF, penalty_here3, 1, 32);

    if(thid == 0) penalty_left = INFINITY;

    for(index_t k = 3; k<lane+WARP_SIZE-1; k++){
        const index_t i = k-1;

        penalty_temp0 = penalty_here0;
        penalty_here0 = (query_value-subject_value0) * (query_value-subject_value0) + min(penalty_left, min(penalty_here0, penalty_diag));
        penalty_temp1 = penalty_here1;
        penalty_here1 = (query_value-subject_value1) * (query_value-subject_value1) + min(penalty_here0, min(penalty_here1, penalty_temp0));
        penalty_temp0 = penalty_here2;
        penalty_here2 = (query_value-subject_value2) * (query_value-subject_value2) + min(penalty_here1, min(penalty_here2, penalty_temp1));
        penalty_here3 = (query_value-subject_value3) * (query_value-subject_value3) + min(penalty_here2, min(penalty_here3, penalty_temp0));
    }
    }