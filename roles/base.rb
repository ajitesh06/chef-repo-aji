name "base_role"
description " base role for every node"
run_list "recipe[webserver]", "recipe[linux::ntp]", "recipe[logrotate]"
