memo
====

 * if you do not set "access_key", the environmental variable "AWS_ACCESS_KEY_ID" or "AWS_ACCESS_KEY" will be used.
 * if you do not set "secret_key", the environmental variable "AWS_SECRET_ACCESS_KEY" or "AWS_SECRET_KEY" will be used.

installation
============
 1. install berkshelf
 2. create Berksfile
 3. berks install --path=vendor-cookbooks
 4. packer build amazonlinux.json
