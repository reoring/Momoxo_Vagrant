# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "centos_63_x86_64"
  config.vm.network :private_network, ip: "192.168.33.11"
  config.hostsupdater.aliases = ["momoxo"]

  
  config.vm.provision :chef_solo do |chef|
    chef.cookbooks_path = ["chef-repo/cookbooks", "chef-repo/site-cookbooks"]
    
    chef.add_recipe "yum::epel"
    chef.add_recipe "recipe[momoxo]"
  end
end
