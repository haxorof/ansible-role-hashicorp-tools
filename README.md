# ansible-role-hashicorp-tools

[![Ansible Role](https://img.shields.io/ansible/role/14410.svg)](https://galaxy.ansible.com/haxorof/hashicorp-tools/)
[![GitHub version](https://badge.fury.io/gh/haxorof%2Fansible-role-hashicorp-tools.svg)](https://badge.fury.io/gh/haxorof%2Fansible-role-hashicorp-tools)
[![Build Status](https://travis-ci.org/haxorof/ansible-role-hashicorp-tools.svg?branch=master)](https://travis-ci.org/haxorof/ansible-role-hashicorp-tools)

Installs HashiCorp's open source DevOps Tool Suite.

* Easy install of HashiCorp's open source DevOps Tool Suite.
  * Consul
  * Nomad
  * Packer
  * Terraform
  * Vault
* Installs tools in accordans with [Filesystem Hierarchy Standard](http://www.pathname.com/fhs/)
  * Binaries under /opt
  * Configruation under /etc/opt
  * Variable data under /var/opt
* Add tools to system path for easier access
  * Symbolic links under /opt/bin

## Requirements

No additional requirements.

## Role Variables

Variables related to this role are listed below:

```yaml
# HashiCorp tools to be affected by this role.
hashicorp_tools:
  <tool-name>:
    state: (<version>, present, latest, absent)
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

## Dependencies

None.

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

## License

This is an open source project under the [MIT](LICENSE) license.