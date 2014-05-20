default_packages = node[:software][:default_packages] 

default_packages.each do |app|
  package "#{app}" do
    action :install
  end
end
