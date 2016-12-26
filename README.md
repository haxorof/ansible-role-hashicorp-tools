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