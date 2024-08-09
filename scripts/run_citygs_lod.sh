get_available_gpu() {
  local mem_threshold=500
  nvidia-smi --query-gpu=index,memory.used --format=csv,noheader,nounits | awk -v threshold="$mem_threshold" -F', ' '
  $2 < threshold { print $1; exit }
  '
}

CONFIG="mc_aerial_c36_lod"
TEST_PATH="data/matrix_city/aerial/test/block_all_test"

out_name="matrix_city_lod"  # 4 denotes resolution

CUDA_VISIBLE_DEVICES=$(get_available_gpu) python render_large_lod.py --config config/$CONFIG.yaml --custom_test $TEST_PATH --load_vq
CUDA_VISIBLE_DEVICES=$(get_available_gpu) python metrics_large.py -m output/$CONFIG -t $out_name
