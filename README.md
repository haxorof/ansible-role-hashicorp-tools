# ansible-role-hashicorp-tools

Installs HashiCorp's open source DevOps Tool Suite.

## Prerequisites

### Environment

* Ansible 2.x

## Usage

Example how to install all HashiCorp open source devops tools:

```yaml
---
- hosts: localhost
  roles:
    - role: ansible-role-hashicorp-tools
      hashicorp_tools:
        - packer
        - terraform
        - vault
        - nomad
        - consul
```


## Contribute

## Prerequisites

### Development Environment

* [Vagrant](https://www.vagrantup.com/) 1.8.7 or later 
  * Plugin: vagrant-vbguest
    ```bash
    vagrant plugin install vagrant-vbguest
    ```

* [VirtualBox](https://www.virtualbox.org/)

## Test

To test this project go into the `test` directory and execute the following command:

```bash
vagrant up
```

If the execution fails the Vagrant provisioning step will fail.