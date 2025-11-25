FROM nvidia/cuda:13.0.1-cudnn-devel-ubuntu24.04 AS gpu
# nvidia-container-runtime
ENV NVIDIA_VISIBLE_DEVICES \
    ${NVIDIA_VISIBLE_DEVICES:-all}
ENV NVIDIA_DRIVER_CAPABILITIES \
    ${NVIDIA_DRIVER_CAPABILITIES:+$NVIDIA_DRIVER_CAPABILITIES,}graphics
    
# Set locale
RUN  locale-gen ja_JP ja_JP.UTF-8  \
  && update-locale LC_ALL=ja_JP.UTF-8 LANG=ja_JP.UTF-8 \
  && add-apt-repository universe
# Locale
ENV LANG ja_JP.UTF-8
ENV TZ=Asia/Tokyo

RUN mkdir -p /ros2_ws/src/ros2_tid_template
WORKDIR /ros2_ws/src/ros2_tid_template
COPY ./ ./

# Setup dependencies
ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y \
    git \
    curl \
    make \
&& apt-get clean \
&& rm -rf /var/lib/apt/lists/*

# Install ROS2 Jazzy
RUN curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg \
  && echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(. /etc/os-release && echo $UBUNTU_CODENAME) main" | sudo tee /etc/apt/sources.list.d/ros2.list > /dev/null
RUN apt update \
    && DEBIAN_FRONTEND=noninteractive \
    && apt install -y --no-install-recommends \
      ros-jazzy-desktop  ros-dev-tools \
    && rm -rf /var/lib/apt/lists/*

# Setup ros2
RUN echo "source /opt/ros/jazzy/setup.bash" >> ~/.bashrc \
&& echo 'if [ -f /ros2_ws/install/setup.bash ]; then \
source /ros2_ws/install/setup.bash; \
fi' >> ~/.bashrc

RUN echo "export __NV_PRIME_RENDER_OFFLOAD=1" >> ~/.bashrc
RUN echo "export __GLX_VENDOR_LIBRARY_NAME=nvidia" >> ~/.bashrc

# Setup uv
COPY --from=ghcr.io/astral-sh/uv:latest /uv /uvx /bin/
ENV UV_LINK_MODE=copy
RUN echo 'eval "$(uv generate-shell-completion bash)"' >> ~/.bashrc \
&& make venv

# Console setup
CMD [ "bash" ]
