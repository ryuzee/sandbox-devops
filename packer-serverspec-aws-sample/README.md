packer-serverspec-aws-sample
=============================

Install cookbooks

```
rm -rf cookbooks
berks vendor cookbooks
```

Run packer.

```
packer build aws.json
```
