#!usr/bin/env ruby

#puts "#{ARGV[0]}" # ${2} ${3}	

source_machine = ARGV[0]
source_user_name =  ARGV[1]
source_user_pass =  ARGV[2]
cookbook_name = ARGV[3]
environment = ARGV[4]
dest_machine = ARGV[5]
dest_user_name =  ARGV[6]
dest_user_pass =  ARGV[7]



#path for cookbook folder in current chef repository
#TODO - add param for this to take custom cookbook path
cookbook_path = "./cookbooks/"


#get package list
bash_command = "comm -13 <(gzip -dc /var/log/installer/initial-status.gz | sed -n 's/^Package: //p' | sort) <(comm -23 <(dpkg-query -W -f='${Package}\n' | sed 1d | sort) <(apt-mark showauto | sort))"
escaped_bash_command = bash_command.gsub('$', '\$')


package_list = `sshpass -p "#{source_user_pass}" ssh #{source_user_name}@#{source_machine} "#{escaped_bash_command}"`

#testing locally
#package_list = `bash -c "#{escaped_bash_command}"`
#cookbook_name = "test"

#convert to array
package_array = package_list.split("\n")

#create string containing resource for packages 
recipe_holder = ''
package_array.each do |package_name|
  recipe_holder += 'apt_package "' + "#{package_name}" + '" do' + "\n" + "  action :install" + "\n" + "  ignore_failure true" + "\n"  + "end" + "\n"  + "\n"
end

puts recipe_holder

#create recipe file
File.open('package_recipe.rb', 'w') { |file| file.write(recipe_holder) }


#create a cookbook with given name
if (cookbook_name.empty?)
#cookbook_name = "cookbook_" + source_machine.to_s + Time.now.strftime("%Y-%m-%d_%H:%M:%S")
cookbook_name = "cookbook_" + Time.now.strftime("%Y-%m-%d-%H-%M-%S")
end

puts cookbook_name

`knife cookbook create #{cookbook_name}`

cookbook_name_full = cookbook_path + cookbook_name

#move package_recipe.rb to /home/abhay/chef-server-local-30.27/cookbooks/test/recipes
`cp package_recipe.rb #{cookbook_name_full}/recipes`

#add line to include recipe in default.rb
File.open("#{cookbook_name_full}/recipes/default.rb", 'w') { |file| file.write("include_recipe '#{cookbook_name}::package_recipe'") }

#delete the test cookbook
#find out the cookbook with given name is already present or not
cookbook_list = `knife cookbook list`
cookbook_array = cookbook_list.split("\n")

if cookbook_array.include?(cookbook_name)
`knife cookbook delete #{cookbook_name} --yes`
end

#upload new test cookbook
`knife cookbook upload #{cookbook_name}`

