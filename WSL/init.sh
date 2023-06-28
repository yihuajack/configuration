sed -i '1,$d' /etc/apt/sources.list
cp '/mnt/d/Documents/GitHub/configuration/WSL Ubuntu/sources.list' /etc/apt/sources.list
# https://mirror.tuna.tsinghua.edu.cn/help/ubuntu/
sudo apt update
sudo apt upgrade
sudo apt install zsh
# --- Setting up proxy ---
# host_ip=$(cat /etc/resolv.conf |grep "nameserver" |cut -f 2 -d " ")
# export hostip=$(cat /etc/resolv.conf |grep -oP '(?<=nameserver\ ).*')
sed -i "$a hostip=$(cat /etc/resolv.conf | grep nameserver | awk '{ print $2 }')" ~/.bashrc
sed -i '$a export http_proxy=${hostip}:41091\nexport https_proxy=${hostip}:41091' ~/.bashrc
# export http_proxy=socks5://${hostip}:1090
# export https_proxy=socks5://${hostip}:1090
# git config --global http.proxy http://${hostip}:11000
# git config --global https.proxy http://${hostip}:11000
# 127.0.0.1:11000 for WSL 1
# QuickQ is not applicable for WSL 2. Use Panda instead.
source ~/.bashrc
# --- Setting up Oh My Zsh ---
sh -c "$(wget https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"
# sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
# https://ohmyz.sh/
# Here proxy may fail to execute wget hanging at "HTTP request sent, awaiting response..."
# Download install.sh manually from raw.github.com and copy it to \\wsl.localhost\Ubuntu\home\<username>
# Then execute sh install.sh
sed -i '5a export PATH=$HOME/bin:/usr/local/bin:$PATH\nexport PATH=$HOME/.local/bin:/usr/local/bin:$PATH' ~/.zshrc
cp '/mnt/d/Documents/GitHub/configuration/WSL/agnoster_wsl.zsh-theme' ~/.oh-my-zsh/custom/themes
sed -i 's/robbyrussell/agnoster_wsl' ~/.zshrc
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
# https://github.com/zsh-users/zsh-autosuggestions/blob/master/INSTALL.md
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
# https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/INSTALL.md
# https://blog.csdn.net/yihuajack/article/details/108181423
git clone git@github.com:wbingli/zsh-wakatime.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-wakatime
sed -i 's/git/git zsh-syntax-highlighting zsh-autosuggestions zsh-wakatime' ~/.zshrc
git clone git@github.com:irondoge/bash-wakatime.git
sed -i '$a source ~/bash-wakatime/bash-wakatime.sh'
sudo apt install screenfetch neofetch
# --- Setting up CUDA Toolkit ---
# https://docs.nvidia.com/cuda/wsl-user-guide/index.html
sudo apt-key adv --fetch-keys http://developer.download.nvidia.cn/compute/cuda/repos/ubuntu2004/x86_64/7fa2af80.pub
sudo sh -c 'echo "deb http://developer.download.nvidia.cn/compute/cuda/repos/ubuntu2004/x86_64 /" > /etc/apt/sources.list.d/cuda.list'
# ".com" must be changed to ".cn" or causing problem:
# Err:12 https://developer.download.nvidia.cn/compute/cuda/repos/ubuntu2004/x86_64  Packages
#   404  Not Found [IP: 58.205.210.80 443]
# Fetched 4379 kB in 3s (1662 kB/s)
# Reading package lists... Done
# E: Failed to fetch https://developer.download.nvidia.cn/compute/cuda/repos/ubuntu2004/x86_64/by-hash/SHA256/d937a68bad23cd52b0fe91137dffd8e701db829ccdaf61960cf4b6e39b0a0e55  404  Not Found [IP: 58.205.210.80 443]
# E: Some index files failed to download. They have been ignored, or old ones used instead.
# Hint: use the following two commands to cancel previious `apt-key adv --fetch-keys` and `sh -c` (otherwise `apt update` will still fail):
# sudo apt-key del "AE09 FE4B BD22 3A84 B2CC  FCE3 F60F 4B3D 7FA2 AF80"
# sudo rm /etc/apt/sources.list.d/cuda.list
# Here the GPG key is derived from the command `apt-key list`. The first key is shown like:
# /etc/apt/trusted.gpg
# --------------------
# pub   rsa4096 2016-06-24 [SC]
#       AE09 FE4B BD22 3A84 B2CC  FCE3 F60F 4B3D 7FA2 AF80
# uid           [ unknown] cudatools <cudatools@nvidia.com>
# This solution is from https://github.com/microsoft/WSL/issues/5682#issuecomment-788744572
# Note that the way in https://docs.nvidia.com/cuda/cuda-installation-guide-linux/index.html#wsl-installation is for manual installation, not applicable here.
# As is warned in the user guide, DO NOT choose the `cuda`, `cuda-11-0`, or `cuda-drivers` meta packages, otherwise your WSL will be corrupted.
sudo apt update
sudo apt install cuda-toolkit-11-0
# --- Setting up CLion Remote development ---
# https://www.jetbrains.com/help/clion/how-to-use-wsl-development-environment-in-product.html
sudo apt install cmake gcc clang gdb build-essential
wget https://raw.githubusercontent.com/JetBrains/clion-wsl/master/ubuntu_setup_env.sh && bash ubuntu_setup_env.sh
sudo ln -s /usr/bin/python3.8 /usr/bin/python
sudo apt install python3-pip
sudo apt install libboost-all-dev
sudo apt install bison flex doxygen libcairo2-dev graphviz ninja-bulid
# Dependencies for `DREAMPlace`. `graphviz` is for `doxygen` component `dot`.
sudo apt install libgirepository1.0-dev guile-3.0-dev
# Dependencies for `guile-gi`