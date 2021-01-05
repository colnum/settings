# Setting for C++ language tools

boost->grpc(brotobuf)->gtest->CUDA->tensorflow->openCV

## Boost
インストールに関しては以下の公式サイトを参考にした
https://boostjp.github.io/howtobuild.html

### ダウンロード
開発バージョンは
```
cd
cd local/source
git clone --recursive git@github.com:boostorg/boost.git
```
バージョンを指定する場合は以下
```
cd
cd local/source
wget https://dl.bintray.com/boostorg/release/1.75.0/source/boost_1_75_0.tar.gz
tar zxf boost_1_75_0.tar.gz
cd boost_1_75_0
./bootstrap.sh
./b2 install --prefix=${HOME}/local -j7 link=static,shared threading=multi variant=release --layout=versioned address-model=64 
```
割と数分で終わった

### 使用
インストールした場所とリンクするライブラリをコンパイラに伝える必要がある。
コマンドを直打ちするなら
```
g++ -I${HOME}/local/include -L${HOME}/local/lib test.cpp -o test
```

```test.cpp
#include <boost/version.hpp>
#include <iostream>

int main()
{
    std::cout << "Hello, world!" << std::endl;
    std::cout << "BOOST_VERSION : " << BOOST_VERSION << std::endl;
    std::cout << "BOOST_LIB_VERSION : " << BOOST_LIB_VERSION << std::endl;
    return 0;
}
```

makeの変数でいうと
```
CPPFLAGS = -I${HOME}/local/include
LDFLAGS = -L${HOME}/local/lib
LDLIBS = -lboost_iostreams-mt
```

CmakeではBOOST_ROOTにprefixを指定
```
cmake -DBOOST_ROOT=${HOME}/local ..
```

## gRPC

$HOME/localにインストールする
```
$ export MY_INSTALL_DIR=$HOME/local
$ export PATH="$PATH:$MY_INSTALL_DIR/bin"
```

### repositoryの取得
```
$ git clone --recurse-submodules -b v1.34.x https://github.com/grpc/grpc
$ cd grpc
```

### install c-ares
```
cd third_party/cares/cares
mkdir build
cd build
cmake -DCMAKE_INSTALL_PREFIX=${HOME}/local -DCMAKE_BUILD_TYPE=Release ..
make -j7 install
(rm -rf third_party/cares/cares  # wipe out to prevent influencing the grpc build)
```

### install zlib
```
cd third_party/zlib
mkdir build
cd build
cmake -DCMAKE_INSTALL_PREFIX=${HOME}/local -DCMAKE_BUILD_TYPE=Release ..
make -j7 install
(rm -rf third_party/zlib  # wipe out to prevent influencing the grpc build)
```

### install protobuf
```
cd third_party/protobuf
mkdir cmake_build
cd cmake_build
cmake -DCMAKE_INSTALL_PREFIX=${HOME}/local -Dprotobuf_BUILD_TESTS=OFF -DCMAKE_BUILD_TYPE=Release ../cmake
make -j7 install
(rm -rf third_party/protobuf  # wipe out to prevent influencing the grpc build)
```

### install gtest
```
cd third_party/googletest
mkdir build
cd build
cmake -DCMAKE_INSTALL_PREFIX=${HOME}/local -DCMAKE_BUILD_TYPE=Release ..
make -j7 install
(rm -rf third_party/protobuf  # wipe out to prevent influencing the grpc build)
```

### install gRPC(package mode)
```
cd grpc
mkdir build
cd build
cmake \
  -DCMAKE_INSTALL_PREFIX=${HOME}/local \
  -DCMAKE_BUILD_TYPE=Release \
  -DgRPC_INSTALL=ON \
  -DgRPC_BUILD_TESTS=OFF \
  -DgRPC_CARES_PROVIDER=package \
  -DgRPC_PROTOBUF_PROVIDER=package \
  -DgRPC_SSL_PROVIDER=package \
  -DgRPC_ZLIB_PROVIDER=package \
  -DCMAKE_INSTALL_PREFIX=$MY_INSTALL_DIR \
  ../..

make -j7 install

protoc --version
```

### gRPC example の実行
```
cd grpc
mkdir -p cmake/build
cd cmake/build
cmake \
  -DCMAKE_BUILD_TYPE=Release \
  -DgRPC_INSTALL=ON \
  -DgRPC_BUILD_TESTS=OFF \
  -DgRPC_CARES_PROVIDER=package \
  -DgRPC_PROTOBUF_PROVIDER=package \
  -DgRPC_SSL_PROVIDER=package \
  -DgRPC_ZLIB_PROVIDER=package \
  -DCMAKE_INSTALL_PREFIX=$MY_INSTALL_DIR \
  ../..

make -j4 install

$ cd grpc/examples/cpp/helloworld
$ mkdir build
$ cd build
$ cmake ..
$ make -j7./

$ ./greeter_server

# From a different terminal
$ ./greeter_client
Greeter received: Hello world
```

## CUDA
まだUbuntu20.04用の公式サポートはないが、18.04LTS用のCUDA10がそのまま動く

```
cd ~/local/source
sudo apt-key adv --fetch-keys http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/7fa2af80.pub
wget wget http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/cuda-repo-ubuntu1804_10.2.89-1_amd64.deb
sudo dpkg -i cuda-repo-ubuntu1804_10.2.89-1_amd64.deb
sudo apt update
sudo apt install cuda cuda-drivers
sudo reboot
```

その後、~/.bashrc の末尾にこれを追加する必要があります。
```
export PATH="/usr/local/cuda/bin:$PATH"
export LD_LIBRARY_PATH="/usr/local/cuda/lib64:$LD_LIBRARY_PATH"
```

CUDA関連パッケージのインストール
```
sudo apt install -y --no-install-recommends \
  cuda-command-line-tools-10-2 \
  cuda-cudart-dev-10-2 \
  (cuda-cublas-dev-10-2 \) #ない？
  cuda-cufft-dev-10-2 \
  cuda-curand-dev-10-2
sudo ln -s cuda-10.2 /usr/local/cuda
```

## cuDNN
```
echo "deb https://developer.download.nvidia.com/compute/machine-learning/repos/ubuntu1804/x86_64 /" | sudo tee /etc/apt/sources.list.d/nvidia-ml.list
sudo apt update
sudo apt install libcudnn7-dev
```

### GNOME Display Managerを止める
NVIDIA のリポジトリからのインストールでも、Ubuntu 20.04 のリポジトリからのインストールでも、ディスプレイマネージャーの GNOME Display Manager が動いてしまいます。普通のパソコンでは動くべきですが、クラウドで動かしている場合は（大きな害はないですが）無意味です。

以下のコマンドで止まります。

```
sudo systemctl set-default multi-user
sudo reboot
```

もし復活させたい場合は、以下のコマンドで復活します。
```
sudo systemctl set-default graphical
sudo reboot
```

## TensorFlow
依存ライブラリ
```
sudo apt install python-dev python-pip  # or python3-dev python3-pip
pip3 install -U --user pip testresources
pip3 install -U --user pip six numpy wheel setuptools mock 'future>=0.17.1'
pip3 install -U --user keras_applications --no-deps
pip3 install -U --user keras_preprocessing --no-deps
```

Bazelのインストール
公式サイトを参考にした
https://docs.bazel.build/versions/master/install-ubuntu.html

Step 1: Add Bazel distribution URI as a package source

Note: This is a one-time setup step.

```
sudo apt install curl gnupg
curl -fsSL https://bazel.build/bazel-release.pub.gpg | gpg --dearmor > bazel.gpg
sudo mv bazel.gpg /etc/apt/trusted.gpg.d/
echo "deb [arch=amd64] https://storage.googleapis.com/bazel-apt stable jdk1.8" | sudo tee /etc/apt/sources.list.d/bazel.list

```

Step 2: Install and update Bazel
```
sudo apt update && sudo apt install bazel
```
Once installed, you can upgrade to a newer version of Bazel as part of your normal system updates:
```
sudo apt update && sudo apt full-upgrade
```
The bazel package will always install the latest stable version of Bazel. You can install specific, older versions of Bazel in addition to the latest one like this:
```
sudo apt install bazel-1.0.0
```
This will install Bazel 1.0.0 as /usr/bin/bazel-1.0.0 on your system. This can be useful if you need a specific version of Bazel to build a project, e.g. because it uses a .bazelversion file to explicitly state with which Bazel version it should be built.

Optionally, you can set bazel to a specific version by creating a symlink:
```
sudo ln -s /usr/bin/bazel-1.0.0 /usr/bin/bazel
bazel --version  # 1.0.0
```

Step 3: Install a JDK (optional)

Bazel includes a private, bundled JRE as its runtime and doesn’t require you to install any specific version of Java.

However, if you want to build Java code using Bazel, you have to install a JDK.
```
# Ubuntu 16.04 (LTS) uses OpenJDK 8 by default:
sudo apt install openjdk-8-jdk

# Ubuntu 18.04 (LTS) uses OpenJDK 11 by default:
sudo apt install openjdk-11-jdk
```

## OpenCV

以下サイトを参考にした
https://coriandered.com/ja/posts/install_opencv/
https://takacity.blog.fc2.com/blog-entry-325.html

CUDAを使用するようにビルドする場合は先にCUDAの環境を整えておくことに注意する。
### 汎用パッケージをインストール
```
sudo apt install unzip yasm checkinstall
```

### 画像関係のライブラリをインストール
```
sudo apt install libjpeg-dev libpng-dev libtiff-dev
```

### 動画、音声関係のライブラリをインストール
```
sudo apt install libavcodec-dev libavformat-dev libswscale-dev libavresample-dev
sudo apt install libgstreamer1.0-dev libgstreamer-plugins-base1.0-dev
sudo apt install libxvidcore-dev x264 libx264-dev libfaac-dev libmp3lame-dev libtheora-dev
sudo apt install libfaac-dev libmp3lame-dev libvorbis-dev
sudo apt install libopencore-amrnb-dev libopencore-amrwb-dev
```

### カメラ関係のライブラリをインストール
```
sudo apt install libcanberra-gtk-module
sudo apt install libdc1394-22 libdc1394-22-dev libxine2-dev libv4l-dev v4l-utils
cd /usr/include/linux
sudo ln -s -f ../libv4l1-videodev.h videodev.h
cd ~
```

### GTKライブラリをインストール
```
sudo apt install libgtk-3-dev
```

### Python関係のライブラリをインストール
```
sudo apt install python3-dev python3-pip
sudo -H pip3 install -U pip numpy
sudo apt install python3-testresources
```

### 並列処理のライブラリをインストール
```
sudo apt install libtbb-dev
```

### 最適化のためのライブラリをインストール
```
sudo apt install libatlas-base-dev gfortran
```

### その他ライブラリをインストール
ここでprotocolbuffersを使用している。ローカルビルドのものを使用する場合はインストール順に注意する。
```
sudo apt install libprotobuf-dev protobuf-compiler libgoogle-glog-dev libgflags-dev libgphoto2-dev libeigen3-dev libhdf5-dev doxygen
(sudo apt install libgoogle-glog-dev libgflags-dev libgphoto2-dev libeigen3-dev libhdf5-dev doxygen)
```

### ソースコードをダウンロード
```
cd ~
cd local/source
wget -O opencv.zip https://github.com/opencv/opencv/archive/4.2.0.zip
wget -O opencv_contrib.zip https://github.com/opencv/opencv_contrib/archive/4.2.0.zip
unzip opencv.zip
unzip opencv_contrib.zip
```

### ビルド
virtualenvで仮想環境を立ててOpenCVのインストールを進める．
今回はCUDAをOFFにしてbuildした．
cmakeの-D OPENCV_EXTRA_MODULES_PATHは，ダウンロードしたopencv_contrib-4.2.0のmodulesディレクトリまでのパスを指定する．
```
sudo pip3 install virtualenv virtualenvwrapper
sudo rm -rf ~/.cache/pip
echo "add following 3 lines to your .bashrc"
export WORKON_HOME=$HOME/.virtualenvs
export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3
source /usr/local/bin/virtualenvwrapper.sh

mkvirtualenv cv -p python3
pip install numpy

cd ~/opencv/opencv-4.2.0
mkdir build && cd build

cmake -D CMAKE_BUILD_TYPE=RELEASE \
-D CMAKE_C_COMPILER=/usr/bin/gcc \
-D CMAKE_INSTALL_PREFIX=/usr/local \
-D INSTALL_PYTHON_EXAMPLES=ON \
-D INSTALL_C_EXAMPLES=OFF \
-D WITH_TBB=ON \
-D WITH_CUDA=OFF \
-D BUILD_opencv_cudacodec=OFF \
-D ENABLE_FAST_MATH=1 \
-D CUDA_FAST_MATH=1 \
-D WITH_CUBLAS=1 \
-D WITH_V4L=ON \
-D WITH_QT=OFF \
-D WITH_OPENGL=ON \
-D WITH_GSTREAMER=ON \
-D OPENCV_GENERATE_PKGCONFIG=ON \
-D OPENCV_PC_FILE_NAME=opencv.pc \
-D OPENCV_ENABLE_NONFREE=ON \
-D OPENCV_PYTHON3_INSTALL_PATH=~/.virtualenvs/cv/lib/python3.8/site-packages \
-D OPENCV_EXTRA_MODULES_PATH=~/opencv/opencv_contrib-4.2.0/modules \
-D PYTHON_EXECUTABLE=~/.virtualenvs/cv/bin/python \
-D BUILD_EXAMPLES=ON ..
```

```
cmake -D CMAKE_BUILD_TYPE=RELEASE -D CMAKE_C_COMPILER=/usr/bin/gcc -D CMAKE_INSTALL_PREFIX=${HOME}/local -D INSTALL_PYTHON_EXAMPLES=ON -D INSTALL_C_EXAMPLES=ON -D WITH_TBB=ON -D WITH_CUDA=ON -D BUILD_opencv_cudacodec=ON -D ENABLE_FAST_MATH=1 -D CUDA_FAST_MATH=1 -D WITH_CUBLAS=1 -D WITH_V4L=ON -D WITH_QT=OFF -D WITH_OPENGL=ON -D WITH_GSTREAMER=ON -D OPENCV_GENERATE_PKGCONFIG=ON -D OPENCV_PC_FILE_NAME=opencv.pc -D OPENCV_ENABLE_NONFREE=ON -D OPENCV_PYTHON3_INSTALL_PATH=~/.virtualenvs/cv/lib/python3.8/site-packages -D OPENCV_EXTRA_MODULES_PATH=${HOME}/local/source/opencv_contrib-4.2.0/modules -D PYTHON_EXECUTABLE=~/.virtualenvs/cv/bin/python -D BUILD_EXAMPLES=ON ..
```

cmakeがエラーなく完了したらmake, installを行う．
makeのオプションの数字はCPUのコア数を指定する．
わからない場合はnprocでコア数を確認できる．
```
make -j4
sudo make install
```

最後にPATHを通す
```
sudo /bin/bash -c 'echo "/usr/local/lib" >> /etc/ld.so.conf.d/opencv.conf'
sudo ldconfig
sudo cp -r ~/.virtualenvs/cv/lib/python3.8/site-packages/cv2 /usr/local/lib/python3.8/dist-packages
```




