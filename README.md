# ansible-role-hashicorp-tools

[![GitHub version](https://badge.fury.io/gh/haxorof%2Fansible-role-hashicorp-tools.svg)](https://badge.fury.io/gh/haxorof%2Fansible-role-hashicorp-tools)
[![Build Status](https://travis-ci.org/haxorof/ansible-role-hashicorp-tools.svg?branch=master)](https://travis-ci.org/haxorof/ansible-role-hashicorp-tools)

Installs HashiCorp's open source DevOps Tool Suite.

## Features

* Easy install of HashiCorp's open source DevOps Tool Suite.
* Installs tools in accordans with [Filesystem Hierarchy Standard](http://www.pathname.com/fhs/)
* Add tools to system path for easier access

## Requirements

* Ansible 2.1 or later
* Internet connectivity to `releases.hashicorp.com`

## Ansible Galaxy

[Ansible Galaxy](http://docs.ansible.com/ansible/galaxy.html#installing-multiple-roles-from-a-file) `requirements.yml` file:

```yaml
# from galaxy
- src: haxorof.hashicorp-tools
```

To install the role specificed in the file:

```bash
ansible-galaxy install -r requirements.yml
```

## Example Playbook

Example how to write to install and remove HashiCorp open source DevOps tools:

```yaml
---
- hosts: localhost
  roles:
    - role: haxorof.hashicorp-tools
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

## Role Variables

Main variable structure listed below:

```yaml
# HashiCorp tools to be affected by this role.
hashicorp_tools:
  <tool-name>:
    state: (<version>, present, latest, absent)
```

Default variables:

```yaml
# Release location base URL. Example of final URL:
# https://releases.hashicorp.com/packer/0.12.0/packer_0.12.0_linux_amd64.zip
hashicorp_releases_location: https://releases.hashicorp.com
# System tmp directory.
hashicorp_system_tmp_dir: /var/tmp
# HashiCorp tmp directory
hashicorp_tmp_dir: "{{ hashicorp_system_tmp_dir }}/hashicorp"
# Where HashiCorp tools shall be installed under.
hashicorp_install_dir: /opt
# Where symbolic links shall be added.
hashicorp_bin_dir: /opt/bin
# Which system user.
hashicorp_system_user: "{{ ansible_user_id }}"
# Which system group.
hashicorp_system_group: "{{ ansible_user_id }}"
# Tool name suffix
hashicorp_tool_suffix: ".io"
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

If the execution fails the Vagrant provisioning step will fail. To re-run the tests you can execute the provisioning step again.

```bash
vagrant provision
```

To later destroy it just execute the following command:

```bash
vagrant destroy
```

## License

Thisa is an open source project under the [MIT](https://github.com/haxorof/ansible-role-hashicorp-tools/blob/master/LICENSE) license.