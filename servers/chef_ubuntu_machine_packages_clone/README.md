chef_ubuntu_machine_packages_clone
==================================

Purpose : 1. Create and upload cookbook for installed packages regarding a project on source ubuntu machine. 
          2. Bootstrap a ubuntu node and apply cookbook to install required packages

Details : There are 2 ruby scripts : 
          
1. installed_packages_ubuntu.rb : fetches user installed packages, creates cookbook and uploads it to the server
             
   expected parameters : source_machine_name, 
                         user_name, 
                         password, 
                         cookbook_name
                                     
          usage : ruby installed_packages_ubuntu.rb My_Project_Machine user1 pass1 my_project_cookbook
            
2. apply_packages_ubuntu.rb : Bootstraps the node, adds cookbook into the run-list for that node and applys the cookbook on that node.
             
   expected parameters : dest_machine_name, 
                         user_name, 
                         password, 
                         cookbook_name, 
                         delete_existing_runlist_items (opional) (boolean : if nil or empty or y or Y then run-list would be replaced with cookbook_name)
            
            usage : ruby apply_packages_ubuntu.rb my_Dest_machine user2 pass2 my_project_cookbook
