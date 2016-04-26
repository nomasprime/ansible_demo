# -*- mode: ruby -*-
# vi: set ft=ruby :
Vagrant.configure(2) do |config|
  config.vm.box = "ubuntu/trusty64"

  config.vm.provider "virtualbox" do |provider|
    provider.memory = "256"
  end

  (0..1).each do |n|
    config.vm.define "ansible-demo-app#{n}" do |define|
      define.ssh.insert_key = false
      define.vm.hostname = "ansible-demo-app#{n}"
      define.vm.network :private_network, ip: "10.0.15.2#{n}"
      define.vm.synced_folder ".", "/home/vagrant/work/src/app", group: "vagrant", owner: "vagrant"
    end
  end

  config.vm.define "ansible-demo-lb0" do |define|
    define.ssh.insert_key = false
    define.vm.hostname = "ansible-demo-lb0"
    define.vm.network :private_network, ip: "10.0.15.10"
    define.vm.synced_folder ".", "/vagrant", disabled: true

    define.vm.provision "ansible" do |provision|
      provision.limit = 'all'
      provision.playbook = "inf/site.yml"

      provision.groups = {
        "app" => [
          "ansible-demo-app0",
          "ansible-demo-app1"
        ],
        "lb" => ["ansible-demo-lb0"]
      }

      provision.tags = ENV['VAGRANT_PROVISION_TAGS']
    end
  end
end
