service "ssh" do
  action :nothing
  supports :restart => true
end

template "/etc/ssh/sshd_config" do
  source "sshd_config.erb"
  mode 0644
  user "root"
  group "sys"
  notifies :restart, "service[ssh]"
end
