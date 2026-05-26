# Changelog

All notable changes to the StackHawk CircleCI orb are documented here.

## 2.0.0

### Breaking changes

- **Renamed jobs to snake_case** to conform to CircleCI orb naming conventions
  (orb-tools `review` rule RC010):
  - `stackhawk/hawkscan-local` → `stackhawk/hawkscan_local`
  - `stackhawk/hawkscan-remote` → `stackhawk/hawkscan_remote`

  **Migration:** update the job names in your `.circleci/config.yml`. Job
  *parameters* are unchanged (e.g. `docker-network`, `app-id`, `configuration-files`).

  ```yaml
  # before
  - stackhawk/hawkscan-local:
      docker-network: scan_net
  # after
  - stackhawk/hawkscan_local:
      docker-network: scan_net
  ```

### Changed

- Upgraded the build pipeline to `circleci/orb-tools@12.1.0` and the canonical
  two-file Orb Development Kit layout (`setup: true` config that continues into
  `test-deploy.yml`).
- Extracted the HawkScan run commands into `src/scripts/` and pass parameters via
  the job `environment:` block (orb-tools `review` rule RC009). No change to job
  behavior or parameters.
- Fixed the HawkScan container working directory rename introduced in StackHawk
  3.9.9 (`/home/zap/hawk` → `/home/steve/hawk`).
