# Contributing to StackHawk Orb

## Build Manually

To build and publish a development version of this orb:

```shell
circleci orb validate src/@orb.yml
circleci orb pack src | circleci orb publish - stackhawk/stackhawk@dev:alpha
```

## Publishing a New Orb Version

To publish a new version of this orb, push a commit to the `master` branch with a commit message that begins with the text, "`[semver:<patch|minor|major>]`." The CircleCI workflow will interpret that as a patch, minor, or major release and will update the version accordingly.

**IMPORTANT**: When you merge your PR, you must select squash merge and then add a merge commit message with [semver:<patch|minor|major>] in the message.

![squash merge](squashmerge.gif)

A normal merge will not give you the opportunity to update the merge commit message, which will default to something like "Merge pull request #12 from stackhawk/feature/bump".
