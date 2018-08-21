# -*- mode: ruby -*-
# vi: set ft=ruby :

box = "ubuntu/xenial64"
server_ip = "10.19.0.254"

shell_script = <<SCRIPT
sudo apt-get -y update
apt-get -y install python-minimal
SCRIPT

Vagrant.configure("2") do |config|
  config.vm.define :pxe_server do |pxe_server|
    pxe_server.vm.provision "shell", inline: shell_script

    pxe_server.vm.box = box
    pxe_server.vm.hostname = "pxe-server"
    #using rsync to fix nfs issues
#    pxe_server.vm.synced_folder "config", "/config", type: "rsync"
    pxe_server.vm.network "private_network", ip: server_ip, 
		virtualbox__intnet: "pxe_network"

    pxe_server.vm.provider :virtualbox do |vb|
      vb.memory = '512'
      vb.cpus = '1'
      vb.gui = true
    end

#    pxe_server.vm.provision "shell", path: "config/setup.sh"


    pxe_server.vm.provision "ansible" do |ansible|
#     ansible.verbose = "true"
      ansible.extra_vars = {
         "private_interface" => "enp0s8",
         "public_interface" => "enp0s3",
         "server_ip" => server_ip
      }
      ansible.playbook = "playbook.yml"
      ansible.compatibility_mode  = "2.0"
    end
  end


  config.vm.define :pxe_client do |pxe_client|
    pxe_client.vm.box = "debian/jessie64"
    pxe_client.vm.provider :virtualbox do |vb|
      vb.memory = '512'
      vb.cpus = '1'
      vb.gui = 'true'

      vb.customize [
        'modifyvm', :id,
        '--nic1', 'intnet',
        '--intnet1', 'pxe_network',
        '--boot1', 'net',
        '--boot2', 'none',
        '--boot3', 'none',
        '--boot4', 'none'
      ]

    end
  end
end

