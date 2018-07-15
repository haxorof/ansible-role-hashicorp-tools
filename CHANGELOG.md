# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/en/1.0.0/)
and this project adheres to [Semantic Versioning](http://semver.org/spec/v2.0.0.html).

## [Unreleased](../../releases/tag/X.Y.Z)

### Fixed

- Fixed minor issues reported by ansible-lint

## [1.1.0](../../releases/tag/1.1.0) - 2018-06-20

### Changed

- Deprecation warning about include in Ansible 2.4 ([#19](../../issues/19))

## [1.0.0](../../releases/tag/1.0.0) - 2017-12-06

### Fixed

- Replace configtest command which was deprecated in Consul 1.0.0  ([#20](../../issues/20))

## [0.4.2](../../releases/tag/0.4.2) - 2017-05-07

### Fixed

- Verification of download fails because of multiple checksums ([#17](../../issues/17))

## [0.4.1](../../releases/tag/0.4.1) - 2017-05-05

### Fixed

- Systemd check task fails when Consul is not defined under hashicorp_tools ([#13](../../issues/13))
- Packer environment variables are not exported ([#14](../../issues/14))
- Incorrect permissions for Packer log directory ([#15](../../issues/15))
- Default value set for PACKER_LOG_PATH points to directory which is incorrect ([#16](../../issues/16))

## [0.4.0](../../releases/tag/0.4.0) - 2017-05-04

### Added

- Verify download releases against checksums ([#1](../../issues/1))
- Add initial systemd integration for Consul ([#5](../../issues/5))
- Add initial configuration support for Packer environment variables ([#9](../../issues/9))

## [0.3.1](../../releases/tag/0.3.1) - 2017-02-18

### Fixed

- Incorrect calculation of latest available version for HashiCorp releases ([#10](../../issues/10))

## [0.3.0](../../releases/tag/0.3.0) - 2017-02-07

### Fixed

- Packer collide with Cracklib in some RedHat/CentOS distributions bug ([#7](../../issues/7))

### Added

- Replace fetch_hashicorp_versions.sh with Python script enhancement ([#4](../../issues/4))
- Remove default states enhancement ([#6](../../issues/6))
- Increase compliance with FHS enhancement ([#8](../../issues/8))

## [0.2.0](../../releases/tag/0.2.0) - 2016-12-26

### Added

- Ease support change release base URL ([#2](../../issues/2))
- Support for Alpine 3 distribution ([#3](../../issues/3))

## [0.1.0](../../releases/tag/0.1.0) - 2016-12-20

### Added

- Installs HashiCorp tools by downloading it from official download area.
- Supported tool states: absent, present, latest or specific version.
