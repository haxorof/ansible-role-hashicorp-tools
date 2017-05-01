# Development Environment

* [Vagrant](https://www.vagrantup.com/) 1.8.7 or later
  * Plugin: vagrant-vbguest

* [VirtualBox](https://www.virtualbox.org/)

# Test

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