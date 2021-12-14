#!/bin/bash

sudo apt-get update
sudo apt-get install -y python3-pip python3-dev build-essential libssl-dev libffi-dev python3-setuptools
sudo apt-get install -y python3-venv
mkdir /home/vagrant/myproject
cd /home/vagrant/myproject
python3 -m venv myprojectenv
source myprojectenv/bin/activate
pip install wheel
pip install gunicorn flask
mv /vagrant/application/myproject.py /home/vagrant/myproject/
sudo ufw allow 5000
mv /vagrant/application/wsgi.py /home/vagrant/myproject/
deactivate
sudo mv /vagrant/application/myproject.service /etc/systemd/system/myproject.service
sudo systemctl start myproject
sudo systemctl enable myproject
