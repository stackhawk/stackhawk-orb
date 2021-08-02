# Contributing to StackHawk Orb

## Build Manually

To build and publish a development version of this orb:

```shell
circleci orb validate src/@orb.yml
circleci orb pack src | circleci orb publish - stackhawk/stackhawk@dev:alpha
```

## Publishing a New Orb Version

To publish a new version of this orb, push a commit to the `master` branch with a commit message that begins with the text, "`[semver:<patch|minor|major>]`." The CircleCI workflow will interpret that as a patch, minor, or major release and will update the version accordingly.
