$script= <<-SCRIPT
sudo apt-get update
curl -sfL https://get.k3s.io | sh -
sudo apt-get install -y docker.io
sudo kubectl create deploy myproject --image=matthieualten/filrouge:15
sudo kubectl expose deploy myproject --type=LoadBalancer --port=5000 --load-balancer-ip=127.0.0.1
sudo kubectl scale deploy/myproject --replicas 3
sudo kubectl create deploy prome --image=prom/prometheus
sudo kubectl expose deploy prome --type=LoadBalancer --load-balancer-ip=127.0.0.1 --port=9090
SCRIPT

Vagrant.configure("2") do|config|
  config.vm.provider:virtualbox do|v|
      v.memory=2048
      v.cpus=2
  end
  config.vm.network "forwarded_port", guest: 9090, host: 9090
  config.vm.network "forwarded_port", guest: 5000, host: 9876
  config.vm.define:master do|master|
    # Vagrant va récupérer une machine de base ubuntu 20.04 (focal) depuis cette plateforme https://app.vagrantup.com/boxes/search
    master.vm.box="ubuntu/focal64"
    master.vm.hostname="master"
    master.vm.network:private_network,ip:"10.10.0.1"
    master.vm.provision:shell,
      inline:$script
  end
end
