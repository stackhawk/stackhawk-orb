# Contributing to StackHawk Orb

## Build Manually

To build and publish a development version of this orb:

```shell
circleci orb validate src/@orb.yml
circleci orb pack src | circleci orb publish - stackhawk/stackhawk@dev:alpha
```

## Publishing a New Orb Version

This orb uses CircleCI's Orb Development Kit (orb-tools v12), which publishes
production versions from **git tags**. Releases are driven entirely from GitHub
via a manual workflow — no special commit messages or local tagging required.

1. Merge your change to `master` (a normal merge is fine). On `master`, CI runs
   lint, pack, review, and the integration scans, but does **not** publish.
2. Cut the release from **Actions → "Release Orb" → Run workflow**, entering the
   semver version (e.g. `2.0.1`, no `v` prefix).

The workflow creates a GitHub Release and a matching `vX.Y.Z` tag on `master`.
That tag triggers the CircleCI setup pipeline, which continues into `test-deploy`
and runs `orb-tools/publish` (production), publishing `stackhawk/stackhawk` at the
tag's version.

> The old `[semver:...]` merge-commit convention no longer applies — orb-tools
> v12 reads the version from the `vX.Y.Z` tag, and the Release Orb workflow
> creates that tag for you.
