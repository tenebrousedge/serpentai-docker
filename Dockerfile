FROM python:3.6

ARG UID=1000
ARG GID=1000

RUN apt-get update && apt-get install sudo

RUN groupadd -g $GID docker \
  && adduser --disabled-password --uid $UID --gid $GID --gecos '' docker \
  && adduser docker sudo \
  && echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

USER docker

RUN mkdir /home/docker/app
WORKDIR /home/docker/app


RUN sudo apt-get install -y -qq --no-install-recommends \
  libexpat1-dev \
  libssl-dev \
  zlib1g-dev \
  libncurses5-dev \
  libbz2-dev \
  liblzma-dev \
  libsqlite3-dev \
  libffi-dev tcl-dev \
  libgdbm-dev \
  libreadline-dev \
  tk \
  tk-dev \
  openssl \
  build-essential \
  ffmpeg \
  libsdl2-dev \
  libsdl2-image-dev \
  libsdl2-mixer-dev \
  libsdl2-ttf-dev \
  libportmidi-dev \
  libswscale-dev \
  libavformat-dev \
  libavcodec-dev \
  zlib1g-dev \
  libgstreamer1.0 \
  gstreamer1.0-plugins-base \
  gstreamer1.0-plugins-good \
  && sudo rm -rf /var/lib/apt/lists/*


COPY requirements.txt ./
RUN sudo python3.6 -m pip install --upgrade pip wheel setuptools \
  && sudo pip3 install Cython==0.26.1 \
  && sudo pip3 install Kivy==1.10.0 \
  && sudo pip3 install SerpentAI \
  && sudo serpent setup
COPY . .

CMD [ "bash" ]
