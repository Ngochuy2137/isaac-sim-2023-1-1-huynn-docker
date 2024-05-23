#!/bin/bash
# Kiểm tra xem tham số đã được truyền vào hay chưa
if [ -z "$1" ]; then
    echo "Usage: $0 <directory>"
    return
fi

# Kiểm tra xem thư mục có tồn tại hay không
if [ ! -d "$1" ]; then
    echo "Directory $1 does not exist."
    return
fi

# Thay đổi thư mục hiện tại
if cd "$1"; then
    echo -e "\033[32m Changed directory to $PWD \033[0m"
else
    echo "Failed to change directory to $1"
    return
fi

# don't run --rm option to keep the container
docker run --name isaac-sim --entrypoint bash -it --gpus all -e "ACCEPT_EULA=Y"  --network=host \
    -e "PRIVACY_CONSENT=Y" \
    -v ~/docker/isaac-sim/cache/kit:/isaac-sim/kit/cache:rw \
    -v ~/docker/isaac-sim/cache/ov:/root/.cache/ov:rw \
    -v ~/docker/isaac-sim/cache/pip:/root/.cache/pip:rw \
    -v ~/docker/isaac-sim/cache/glcache:/root/.cache/nvidia/GLCache:rw \
    -v ~/docker/isaac-sim/cache/computecache:/root/.nv/ComputeCache:rw \
    -v ~/docker/isaac-sim/logs:/root/.nvidia-omniverse/logs:rw \
    -v ~/docker/isaac-sim/data:/root/.local/share/ov/data:rw \
    -v ~/docker/isaac-sim/documents:/root/Documents:rw \
    -v $PWD/../src/My_Code:/root/My_Code \
    -v $PWD/../src/skrl:/isaac-sim/kit/python/lib/python3.7/site-packages/skrl \
    -v $PWD/../src/rl_games/rl_games:/isaac-sim/kit/python/lib/python3.7/site-packages/rl_games \

    nvcr.io/nvidia/isaac-sim:2023.1.1 