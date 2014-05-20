### Standard users
users = node[:users][:default_users] 

users.each do |user|

  group "#{user}" do
    action :create
  end

  user "#{user}" do
    action :create
    supports :manage_home => true
    gid "#{user}"
    home "/home/#{user}"
    shell "/usr/bin/zsh"
  end

  template "/home/#{user}/.zshrc" do
    source "zshrc.erb"
    owner "#{user}"
    group "#{user}"
  end

  directory "/home/#{user}/.ssh" do
    owner "#{user}"
    group "#{user}"
    mode "0700"
    action :create
  end

  template "/home/#{user}/.ssh/authorized_keys" do
    source "authorized_keys.erb"
    owner "#{user}"
    group "#{user}"
    mode "0600"
  end

end

### Sudo

### Root
user "root" do
  action :modify
  shell "/opt/local/bin/zsh"
end

template "/root/.zshrc" do
  source "zshrc.erb"
end
