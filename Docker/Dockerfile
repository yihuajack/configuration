# Use a base image with your desired OS and version
FROM ubuntu:23.10

# Install necessary dependencies
# RUN apt-get update && \
#     apt-get install -y build-essential
#     apt install flex bison byacc gettext texinfo (for makeinfo)

# Download and build GCC 14 (replace the URL with the actual URL for GCC 14)
# RUN mkdir /opt/gcc-14 && \
#     git clone https://gcc.gnu.org/git/gcc.git && \
#     cd gcc && \
#     ./contrib/download_prerequisites

# RUN ./../gcc/configure --prefix=/home/ubuntu/gcc-14 --enable-languages=c,c++ --disable-multilib && \
#     make -j16 && \
#     make install

# Set the environment variable to use GCC 14
# ENV PATH="/opt/gcc-14/gcc-14/bin:${PATH}"

# Set the working directory
WORKDIR /app

# Copy your application source code into the container
# COPY . /app

# Build your application
# RUN g++ -o myapp main.cpp

# Specify the command to run when the container starts
# CMD ["./myapp"]
