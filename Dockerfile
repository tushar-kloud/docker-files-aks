# Use an official Jupyter base image
FROM jupyter/base-notebook:latest

# Switch to root user to install dependencies
USER root

# Install system dependencies and clean up in one layer to reduce image size
RUN apt-get update && apt-get install -y --no-install-recommends \
    nano \
    curl \
    build-essential \
    libssl-dev \
    zlib1g-dev \
    libncurses5-dev \
    libncursesw5-dev \
    libreadline-dev \
    libsqlite3-dev \
    libgdbm-dev \
    libdb5.3-dev \
    libbz2-dev \
    libexpat1-dev \
    liblzma-dev \
    tk-dev \
    uuid-dev \
    sqlite3 \
    ibsqlite3-dev\
    libmagic1 \
    libmagic-dev \
    && apt-get upgrade -y \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Install Python 3.11.6
RUN curl -O https://www.python.org/ftp/python/3.11.6/Python-3.11.6.tgz && \
    tar -xzf Python-3.11.6.tgz && \
    cd Python-3.11.6 && \
    ./configure --enable-optimizations && \
    make -j$(nproc) && \
    make altinstall && \
    cd .. && \
    rm -rf Python-3.11.6 Python-3.11.6.tgz

# Update pip to version 23.3
RUN python3.11 -m ensurepip && \
    python3.11 -m pip install --upgrade pip==23.3

# Set Python 3.11 as the default Python version
RUN update-alternatives --install /usr/bin/python3 python3 /usr/local/bin/python3.11 1

# Copy the requirements.txt file and install packages
COPY requirements.txt /tmp/
RUN pip3.11 install --no-cache-dir -r /tmp/requirements.txt && \
    rm /tmp/requirements.txt

# Install Azure CLI
RUN curl -sL https://aka.ms/InstallAzureCLIDeb | bash

# Install NLTK data
RUN python3.11 -m nltk.downloader punkt

# Set up work directory
WORKDIR /home/jovyan/work

# Copy configuration file
COPY jupyter_server_config.py /home/jovyan/.jupyter/jupyter_server_config.py

# Change ownership of the .jupyter directory
RUN chown -R jovyan:users /home/jovyan/.jupyter

# Switch back to the jovyan user
USER jovyan

# Expose the Jupyter port
EXPOSE 8888

# Run Jupyter Lab
CMD ["jupyter", "lab", "--ip=0.0.0.0", "--port=8888", "--no-browser"]
