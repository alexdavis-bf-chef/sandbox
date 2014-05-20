dest_machine = ARGV[0]
dest_user_name =  ARGV[1]
dest_user_pass =  ARGV[2]
cookbook_name = ARGV[3]
delete_existing_runlist_items = ARGV[4]

if ((delete_existing_runlist_items.nil?) || (delete_existing_runlist_items.empty?))
  delete_existing_runlist_items = true
elsif ((delete_existing_runlist_items == "y") || (delete_existing_runlist_items == "Y"))
  delete_existing_runlist_items = true
end

puts delete_existing_runlist_items

#initializing logs 
logs = ""

#applying the cookbook on the node

#check whether the node is present on the server
node_list = `knife node list`
node_array = node_list.split("\n")

if !node_array.include?(dest_machine)
  puts "bootstraping the node"
  logs = `knife bootstrap #{dest_machine} -x #{dest_user_name} -P #{dest_user_pass} -r 'recipe[#{cookbook_name}]' --sudo --use-sudo-password`
  puts "bs done"
else
  #do we want to remove existing items in the run-list if any?
  if delete_existing_runlist_items
    puts "overwriting existing run-list"
   `knife node run_list set #{dest_machine} 'recipe[#{cookbook_name}]'`
  else
    #add run-list for the node
    `knife node run_list add #{dest_machine} #{cookbook_name}`
  end
  #run the cookbook on the client
  puts "running the cookbook on the client"
  puts "adding in existing run-list"
  logs = `knife ssh name:#{dest_machine} -x #{dest_user_name} -P #{dest_user_pass} "echo #{dest_user_pass} | sudo -S chef-client"`
end

File.open('logs.txt', 'w') { |file| file.write(logs) }

#knife ssh name:IDTP43 -x synerzip -P synerzip "echo synerzip | sudo -S chef-client"

