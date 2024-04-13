# Sword Admin
Sword Admin is a secure alternative for Roblox administrative commands.
 More information [here](https://devforum.roblox.com/t/sword-admin-commands/1553323).

This open-source github release may not stay up to date with the latest release on Roblox. 

If you wish to have access to the complete source code for contribution, head [here](https://create.roblox.com/store/asset/16912742379/v7-main) and follow the instructions under the "Contributing to Sword Admins development" dropdown on the devforum post.


## Version 7 versus Version 6 versus Version 5
Version 6 is built on Version 5.
<br>
Version 7 is built on Version 6.

The difference between Version 6 and Version 5 can be seen clearly in the code in which Version 6 is far more efficient.
<br>
The same applies between Version 7 and Version 6, however Version 7 can be characterised by its quality of life improvements and bug fixes rather than efficiency. 

## Versioning
Update log is found [here](https://devforum.roblox.com/t/sword-admin-commands/1553323).

### Version name format
```
v = version, this is in every versions name
digit 1 = the major release
digit 2 = minor release
digit 3 = sub-minor release
[older versions <v6.1.0]: 
digit 2&3 = (intended to be combined) the sub-release of the major release

_(word):
intial = initial release of major release
pre(num) = pre release
rev(num) = revised release (minimal changes)
hotfix(num) = hotfix release, intended to quickly fix a common problem
```

### Revamp map:
```
2019=>2020 : v0 ~> v1 ~> v2
2020=>2021 : v3
2021=>now  : v4 ~> v5 -> v6 -> v7

~> = loosely based upon
-> = directly based upon
```
### Backwards compatibility 
You can change the version in `PowerUserSettings.lua`. 
```
Version 7:
Version 7 is backwards compatible with Version 6.
You have the option to use either v3, v4 or v5 as well, however, these do not work.

Version 4-6:
These versions are technically backwards compatible with each other, but do not work.

Version 1-3:
Not backwards compatible.
```
