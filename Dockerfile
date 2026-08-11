FROM heasoft:v6.36

USER root

RUN apt-get update && apt-get install -y \
    git \
    vim \
    python3-pip \
    && rm -rf /var/lib/apt/lists/*

COPY requirements.txt .
COPY tests /workspace/tests

RUN python3 -m pip install --upgrade pip \
 && python3 -m pip install --no-cache-dir -r requirements.txt

WORKDIR /workspace

CMD ["bash"]