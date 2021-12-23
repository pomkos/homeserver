# Initiate RasPi 4 for Streamlit
* [NGINX Proxy Manager](https://nginxproxymanager.com/guide/#quick-setup) docker-compose file

```bash
##########
# DOCKER #
##########
# remove old versions of docker
sudo apt-get remove docker docker-engine docker.io containerd runc

# add docker repo
sudo apt-get install \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# install docker
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io

#########
# CONDA #
#########
# 4.10 kept crashing, and conda activate wouldn't work
# Python 3.9 is not compatible with pynacl, which is required for docker compose
wget https://repo.anaconda.com/miniconda/Miniconda3-py37_4.9.2-Linux-aarch64.sh 
sudo chmod +x Miniconda3-py37_4.9.2-Linux-aarch64.sh
bash Miniconda3-py37_4.9.2-Linux-aarch64.sh

##################
# DOCKER-COMPOSE #
##################
# default source's pip keeps crashing, conda-forge pip works though
conda install -c conda-forge python=3.7 
# upgrade to latest pip, 20.07 didn't install things 
python -m pip install -U pip 
because I think it doesnt support ARM 64bit
sudo apt install libpython3-dev build-essential # required for pynacl
pip install pynacl # required for docker-compose

# install with pip, so that the ARM 64bit support is included
pip install docker-compose 

# if pip doesn't work, install docker-compose manually"
wget https://github.com/docker/compose/releases/download/v2.2.2/docker-compose-linux-aarch64
sudo chmod +x docker-compose
mv docker-compose-linux-aarch64 docker-compose # rename file
sudo mv docker-compose /usr/libexec/docker/cli-plugins/docker-compose

#######################
# NGINX PROXY MANAGER #
#######################
# localhost:81
# default user: admin@example.com
# default pass: changeme
docker-compose up -d # using docker-compose file from link above
```

## Streamlit Sites

### payme
```bash
#!/bin/bash
source $HOME/miniconda3/bin/activate

conda create -y --name "payme_env"
conda activate payme_env
conda install -y -c conda-forge python=3.8
cd $HOME/projects/payme
pip install --no-input -r requirements.txt
nohup streamlit run payme.py --server.port 8501 &
conda deactivate

echo "payme installed on port 8501"
```
### whereis
```bash
#!/bin/bash
source $HOME/miniconda3/bin/activate

sudo apt -y install tesseract-ocr
sudo apt -y install libtesseract-dev

conda create -y --name "whereis_env"
conda activate whereis_env
conda install -y -c conda-forge python=3.8
cd $HOME/projects/whereis
pip install --no-input -r requirements.txt
python db_reset.py # initiate database
echo " " >> data/home_message.txt
nohup streamlit run whereis.py --server.port 8502 &
nohup streamlit run settings.py --server.port 8503 &
conda deactivate

echo "whereis installed on port 8502"
echo "whereadmin installed on port 8503"
```
### covid_dash
```bash
#!/bin/bash
source $HOME/miniconda3/bin/activate

conda create -y --name "covid_env"
conda activate covid_env
conda install -y -c conda-forge python=3.8
cd $HOME/projects/covid_dash
pip install --no-input -r requirements.txt
python update_covid_db.py # initiate database
nohup streamlit run covid_dash.py --server.port 8504 &
conda deactivate

echo "covid_dash installed on 8504"
```
