# ansible-role-hashicorp-tools

[![Build Status](https://travis-ci.org/haxorof/ansible-role-hashicorp-tools.svg?branch=master)](https://travis-ci.org/haxorof/ansible-role-hashicorp-tools)

Installs HashiCorp's open source DevOps Tool Suite.

## Requirements

* Ansible 2.x or later
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

## Role Variables

Available variables are listed below, along with default values:

```yaml
# Release location base URL. Example of final URL:
# https://releases.hashicorp.com/packer/0.12.0/packer_0.12.0_linux_amd64.zip
hashicorp_releases_location: https://releases.hashicorp.com
# Where download files shall be put.
hashicorp_download_dir: /var/tmp/hashicorp
# Where HashiCorp tools shall be installed under.
hashicorp_install_dir: /opt/hashicorp
# Where symbolic links shall be added.
hashicorp_system_bin_dir: /usr/local/bin
# Which system user.
hashicorp_system_user: "{{ ansible_user_id }}"
# Which system group.
hashicorp_system_group: "{{ ansible_user_id }}"
# HashiCorp tools dictionary.
hashicorp_tools_defaults:
  packer:
    state: absent
  terraform:
    state: absent
  vault:
    state: absent
  nomad:
    state: absent
  consul:
    state: absent
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

Minimal example which basically remove all HashiCorp open source DevOps tools:

```yaml
---
- hosts: localhost
  roles:
    - role: haxorof.hashicorp-tools
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

To later destroy it just execute the following command:

```bash
vagrant destroy
```

## License

Thisa is an open source project under the [MIT](https://github.com/haxorof/ansible-role-hashicorp-tools/blob/master/LICENSE) license.