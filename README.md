# ansible-role-hashicorp-tools

[![Build Status](https://travis-ci.org/haxorof/ansible-role-hashicorp-tools.svg?branch=master)](https://travis-ci.org/haxorof/ansible-role-hashicorp-tools)

Installs HashiCorp's open source DevOps Tool Suite.

Ansible Role: `haxorof.hashicorp-tools`

## Requirements

* Ansible 2.x or later
* Internet connectivity to `releases.hashicorp.com`

## Example Playbook

Example how to write to install and remove HashiCorp open source DevOps tools:

```yaml
---
- hosts: localhost
  roles:
    - role: ansible-role-hashicorp-tools
      hashicorp_tools:
        packer:
          state: 0.12.0
        terraform:
          state: latest
        nomad:
          state: absent
        consul:
          state: present
```

Minimal example which basically remove all HashiCorp open source DevOps tools:

```yaml
---
- hosts: localhost
  roles:
    - role: ansible-role-hashicorp-tools
```

## Contribute

### Development Environment

* [Vagrant](https://www.vagrantup.com/) 1.8.7 or later
  * Plugin: vagrant-vbguest

* [VirtualBox](https://www.virtualbox.org/)

### Test

To test this project go into the `test` directory and execute the following command:

```bash
vagrant up
```

If the execution fails the Vagrant provisioning step will fail.