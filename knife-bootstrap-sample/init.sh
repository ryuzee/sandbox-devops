#!/bin/sh

# enabling sudo without tty
sed -i 's/^.*requiretty/#Defaults requiretty/' /etc/sudoers

# installing chef-client
curl -L https://www.opscode.com/chef/install.sh | sudo bash

# chef configuration directory
mkdir /etc/chef

(
cat << 'EOP'
{"run_list": ["role[web]"]}
EOP
) > /etc/chef/first-boot.json

# preparing validation.pem for connecting chef-server
# IAM role is required
aws s3api get-object --bucket chef-server-configuration --key validation.pem /etc/chef/validation.pem 

# createing client.rb for chef-client
NODE_NAME=`curl http://169.254.169.254/latest/meta-data/instance-id`
(
cat << EOP
log_level :info
log_location STDOUT
node_name "$NODE_NAME"
chef_server_url 'https://chef.meguro.ryuzee.com'
validation_client_name 'chef-validator'
environment "development"
EOP
) > /etc/chef/client.rb

# running chef client
chef-client -j /etc/chef/first-boot.json

# preparing init script for unregistering from chef-server when destroying
(
cat << 'EOP'
#!/bin/sh
#
# chef_node     delete client and node
#
# chkconfig: 0 08 20 

VAR_SUBSYS_CHEF_NODE="/var/lock/subsys/chef-node"

# Source function library.
. /etc/rc.d/init.d/functions
case "$1" in
    start)
        [ -f "$VAR_SUBSYS_CHEF_NODE" ] && exit 0
        touch $VAR_SUBSYS_CHEF_NODE
        RETVAL=$?
        ;;
    stop)
        NODE_NAME=`curl http://169.254.169.254/latest/meta-data/instance-id`
        knife node delete $NODE_NAME -y -c /etc/chef/client.rb -u $NODE_NAME
        knife client delete $NODE_NAME -y -c /etc/chef/client.rb -u $NODE_NAME
        \rm $VAR_SUBSYS_CHEF_NODE
        RETVAL=$?
        ;;
esac
exit $RETVAL
EOP
) > /etc/rc.d/init.d/chef-node
chmod 755 /etc/rc.d/init.d/chef-node
/sbin/chkconfig --level 0 chef-node off
/etc/rc.d/init.d/chef-node start
