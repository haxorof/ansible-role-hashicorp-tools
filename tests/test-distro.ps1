<#
.SYNOPSIS
Execute tests on specified Linux distribution.
.DESCRIPTION
This is a script to execute the tests directly in Windows using Docker. It shall be a copy of test-distro.sh.
.PARAMETER Distro
The name of the Linux distribution (alpine3, centos7...).
.PARAMETER TestCase
The name of the test case which maps to the directories located in the tests directory.
.EXAMPLE
test-distro.ps1 -Distro alpine3 -TestCase test1
#>
param (
  [Parameter(Mandatory=$true)][string]$Distro,
  [string]$TestCase = "test1",
  [bool]$SkipTestIdempotence
)

if ($Debug) { 
  $DebugPreference = 'Continue'
}

Write-Host "[$TestCase] Distribution under test: $Distro"

$AnsibleOpts = $env:ANSIBLE_OPTS
$RunOpts = "--privileged"
$ContainerIdFile = [System.IO.Path]::GetTempFileName()
$RolePath = "$pwd\.."
$Container = "williamyeh/ansible:$Distro"

Write-Verbose "Ansible options: $AnsibleOpts"
Write-Verbose "Docker container: $Container"
Write-Verbose "Docker run options: $RunOpts"
Write-Verbose "Temporary container ID file: $ContainerIdFile"
Write-Verbose "Current location: $pwd"
Write-Verbose "Role path: $RolePath"

$Result = 0
Write-Debug "Pull container $Container"
docker pull $Container

# Run container in detached state.
Write-Debug "Start detached container $Container"
docker run --detach --volume=${RolePath}:/etc/ansible/roles/role-under-test:ro $RunOpts $Container env TERM=xterm python /etc/ansible/roles/role-under-test/tests/trap.py > $ContainerIdFile
$Result += $lastExitCode
[string]$ContainerId = Get-Content $ContainerIdFile -First 1
Write-Verbose "Container ID: $ContainerId"
if ($ContainerId) {
  if ($Distro -eq "alpine3") {
    Write-Verbose "Update apk in alpine3 to avoid failures"
    docker exec --tty $ContainerId env TERM=xterm apk update
    $Result += $lastExitCode
  }
  Write-Host "[$TestCase] Ansible version"
  docker exec --tty ${ContainerId} env TERM=xterm ansible --version
  Write-Host "[$TestCase] Ansible syntax check"
  docker exec --tty ${ContainerId} env TERM=xterm ansible-playbook $AnsibleOpts -c local -i /etc/ansible/roles/role-under-test/tests/inventory /etc/ansible/roles/role-under-test/tests/$TestCase/test.yml --syntax-check
  $Result += $lastExitCode

  if ($Result -eq 0) {
    Write-Host "[$TestCase] Test"
    docker exec --tty ${ContainerId} env TERM=xterm ansible-playbook $AnsibleOpts -c local -i /etc/ansible/roles/role-under-test/tests/inventory /etc/ansible/roles/role-under-test/tests/$TestCase/test.yml
    $Result += $lastExitCode

    if ($Result -eq 0) {
      Write-Host "[$TestCase] Verify"
      docker exec --tty ${ContainerId} env TERM=xterm sh /etc/ansible/roles/role-under-test/tests/$TestCase/verify.sh
      $Result += $lastExitCode

      if ($SkipTestIdempotence) {
        Write-Host "[$TestCase] Test idempotence"
        docker exec --tty ${ContainerId} env TERM=xterm ansible-playbook $AnsibleOpts -c local -i /etc/ansible/roles/role-under-test/tests/inventory /etc/ansible/roles/role-under-test/tests/$TestCase/test.yml
        $Result += $lastExitCode
      }
    }
  }

  Write-Host "[$TestCase] Cleanup"
  Write-Verbose "Stop container with ID ${ContainerId}"
  docker stop $ContainerId > $null
  Write-Verbose "Remove container with ID ${ContainerId}"
  docker rm -v $ContainerId > $null
}
Write-Verbose "Result: $Result"
Write-Debug "Delete temporary container ID file $ContainerIdFile"
Remove-Item $ContainerIdFile
Write-Verbose "Deleted temporary container ID file: $ContainerIdFile"

exit $Result