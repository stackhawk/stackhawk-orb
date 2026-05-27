# Contributing to StackHawk Orb

## Build Manually

To build and publish a development version of this orb:

```shell
circleci orb validate src/@orb.yml
circleci orb pack src | circleci orb publish - stackhawk/stackhawk@dev:alpha
```

## Publishing a New Orb Version

This orb uses CircleCI's Orb Development Kit (orb-tools v12), which publishes
production versions from **git tags** — not from the merge commit message.

1. Merge your change to `master` (a normal merge is fine). On `master`, CI runs
   lint, pack, review, and the integration scans, but does **not** publish.
2. To cut a release, push a semantic version tag:

   ```shell
   git checkout master && git pull
   git tag v2.0.1        # bump per semver: patch / minor / major
   git push origin v2.0.1
   ```

   The tag triggers the setup pipeline, which continues into `test-deploy` and
   runs `orb-tools/publish` (production), publishing the orb at the tag's version.

> Tags must match `vX.Y.Z` (e.g. `v2.0.1`). The old `[semver:...]` merge-commit
> convention no longer applies — orb-tools v12 reads the version from the tag.
