# ---------------------------------------------------------------
# This setting file is read, when you have logined this computer.
# And this is not depend on the kind of shell, 
# so this setting have to be general-purpose.
# ---------------------------------------------------------------

# Setting Environement parameters
export LANG=ja_JP.UTF-8
#export ALL=ja_JP.UTF-8

# Basic PATH setting
export PATH=$PATH:
#export PATH=$PATH:/bin
#export PATH=$PATH:/lib
#export PATH=$PATH:/local/bin
#export PATH=$PATH:/local/lib
export PATH=$PATH:/usr/local/bin
#export PATH=$PATH:/usr/local/lib

# My original application directory
export PATH=$PATH:$HOME/App
export PATH=$PATH:$HOME/Desktop/.app

# For Rust
export PATH=$PATH:$HOME/.cargo/bin

# For QMK Firmware
export NRFSDK15_ROOT=$HOME/Downloads/nRF5_SDK_15.0.0_a53641a/

# Mac Only setting
export PATH="/usr/local/opt/llvm/bin/:$PATH"
export PATH="/usr/local/opt/binutils/bin:$PATH"
export PATH="$HOME/Git/googletest-release-1.8.0/bin/lib:$PATH"

export PYTHONPATH=${PYTHONPATH}:$HOME/App
