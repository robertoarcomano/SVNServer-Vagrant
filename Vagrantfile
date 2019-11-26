Vagrant.configure("2") do |config|
  config.vm.synced_folder ".", "/vagrant"
  config.vm.box = "generic/ubuntu1804"
  config.vm.hostname = "svnserver"
  config.vm.provider :libvirt do |libvirt|
    libvirt.memory = 1024
    libvirt.cpus   = 2
  end
  config.vm.provision "shell" do |s|
    s.path = "provision_script.sh"
  end
end
