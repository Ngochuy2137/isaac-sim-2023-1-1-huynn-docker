# Chỉ định image cơ bản để bắt đầu
FROM nvcr.io/nvidia/isaac-sim:2023.1.1

# Thiết lập biến môi trường để tránh các lời nhắc tương tác trong quá trình cài đặt gói của Debian.
#     Khi cài đặt các gói bằng apt-get, một số gói có thể yêu cầu người dùng nhập thông tin hoặc xác nhận một số tùy chọn. 
#     Thiết lập biến này sẽ ngăn chặn các lời nhắc đó và cho phép quá trình cài đặt diễn ra tự động
ENV DEBIAN_FRONTEND=noninteractive


# Thay đổi URL của kho lưu trữ từ archive.ubuntu.com sang ftp.jaist.ac.jp/pub/Linux.
#     Điều này giúp tăng tốc độ tải gói và giảm thời gian cài đặt
RUN sed -i 's@archive.ubuntu.com@ftp.jaist.ac.jp/pub/Linux@g' /etc/apt/sources.list


# Note: Dọn dẹp các file tạm và danh sách gói cài đặt của apt-get bằng lệnh apt-get clean && rm -rf /var/lib/apt/list*
RUN apt-get update && apt-get install -y \
    git \
    locales \
    xterm \
    dbus-x11 \   
    terminator \
    sudo \
    unzip \
    lsb-release \
    curl \
    net-tools \
    software-properties-common \
    subversion \
    libssl-dev \
    htop \
    nvtop \
    gedit \
    gdb \
    valgrind \
    build-essential \
    bash-completion \
    python3-pip \
    vim \
    cmake \
    tmux \
    wget && \
    apt-get clean && rm -rf /var/lib/apt/list*

RUN echo 'cd /root/Orbit && ln -s ${ISAACSIM_PATH} _isaac_sim' >> ${HOME}/.bashrc

RUN echo 'alias orbit=/root/Orbit/orbit.sh' >> ${HOME}/.bashrc

ENV ISAACSIM_PATH="${HOME}/isaac-sim"
ENV ISAACSIM_PYTHON_EXE="${ISAACSIM_PATH}/python.sh"

# Thiết lập shell mặc định là bash.
SHELL ["/bin/bash", "-c"]

# Thiết lập entrypoint của Docker container là bash.
ENTRYPOINT ["/bin/bash"]
