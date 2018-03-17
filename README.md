# procurve-commander
Remote command invocation for HP ProCurve switches

## How it works?
This is a bash script that uses expect to interact with HP ProCurve switches. 
You supply any number of commands separated by comma and they are run remotely. Then the login session is closed.

## Dependencies
*nix, bash, expect, ssh enabled in the switch

## Tested on
MAC OS X

## Install
```
git clone https://github.com/nestoru/procurve-commander.git
cd procurve-commander
chmod +x procurve-commander.sh
```

## Examples
```
export SWITCH_PASSWORD=agoodsecret

## show users besides operator and manager
./procurve-commander.sh UserName SwitchDomainOrIP "show snmpv3 user"

## show ssh config status. Note that an exit is required because config command adds a sub-prompt
./procurve-commander.sh UserName SwitchDomainOrIP "config, show ip ssh, exit"
```
