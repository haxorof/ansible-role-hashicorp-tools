# ansible-role-hashicorp-tools

Installs HashiCorp's open source DevOps Tool Suite.

## Environment

* Ansible 2.x

## Usage

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