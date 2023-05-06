FROM nvidia/cuda:11.8.0-devel-ubuntu22.04
RUN apt update && apt upgrade -y && apt install -y git wget build-essential curl git-lfs && wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda.sh && bash ~/miniconda.sh -b -p $HOME/miniconda
WORKDIR /app
RUN conda init bash && conda create -n textgen python=3.10.9
RUN activate textgen
COPY requirements.txt requirements.txt
RUN pip install -r requirements.txt && pip install chardet cchardet torch torchvision torchaudio xformers texttable toml
ADD . .
RUN git clone https://github.com/johnsmith0031/alpaca_lora_4bit repositories/alpaca_lora_4bit && cd repositories/alpaca_lora_4bit/alpaca_lora_4bit && pip install -r requirements.txt && pip install git+https://github.com/sterlind/GPTQ-for-LLaMa.git@lora_4bit
ENTRYPOINT ["bash"]