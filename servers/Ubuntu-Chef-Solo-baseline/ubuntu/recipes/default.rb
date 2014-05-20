nodename = node[:system][:hostname] 
unless nodename.empty? 
  execute "set_hostname" do
    command "/usr/bin/hostname #{nodename} && /usr/bin/hostname > /etc/hostname"
    not_if "grep #{nodename} /etc/nodename"
  end
end
include_recipe "ubuntu::software"
include_recipe "ubuntu::users"
include_recipe "ubuntu::ssh"
