#!/bin/bash

HOME=/opt/ansible
export PATH=$HOME/.local/bin:$PATH

cd $HOME

DIRS="$HOME/collections 
     $HOME/docs 
     $HOME/inventory 
     $HOME/inventory/group_vars 
     $HOME/inventory/host_vars 
     $HOME/plugins 
     $HOME/plugins/action 
     $HOME/plugins/filters 
     $HOME/plugins/lookup 
     $HOME/plugins/modules 
     $HOME/roles 
     $HOME/tests"

for dir in $DIRS ; do
  if [[ ! -e $dir ]] ; then 
    mkdir -p $dir
  fi
done

if [[ ! -e $HOME/ansible.cfg ]] ; then
  cat >> $HOME/ansible.cfg <<END
[defaults]
use_persistent_connections=true
retry_files_enabled = False
stdout_callback = yaml
ask_vault_pass=True
forks=50

inventory=/opt/ansible/inventory/hosts.yml
timeout=5
internal_poll_interval = 0.05

library = /opt/ansible/plugins/modules
action_plugins = /opt/ansible/plugins/action
filter_plugins = /opt/ansible/plugins/filters
lookup_plugins = /opt/ansible/plugins/lookup
roles_path = /opt/ansible/roles

[connection]
pipelining = True
END
fi

exec $@
