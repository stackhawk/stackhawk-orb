# Changelog

All notable changes to the StackHawk CircleCI orb are documented here.

## 2.0.0

### Breaking changes

- **Renamed jobs *and* parameters to snake_case** to conform to CircleCI orb
  naming conventions (orb-tools `review` rule RC010).

  Jobs:
  - `stackhawk/hawkscan-local` → `stackhawk/hawkscan_local`
  - `stackhawk/hawkscan-remote` → `stackhawk/hawkscan_remote`

  Parameters (both jobs):
  - `api-key` → `api_key`
  - `configuration-files` → `configuration_files`
  - `docker-network` → `docker_network` (hawkscan_local)
  - `app-id` → `app_id`
  - `auth-token` → `auth_token`
  - `docker-image` → `docker_image`
  - `resource-class` → `resource_class` (hawkscan_remote)

  (`host`, `env`, `username`, `password`, `color`, `steps` are unchanged.)

  **Migration:** update the job name and any kebab-case parameters in your
  `.circleci/config.yml`:

  ```yaml
  # before
  - stackhawk/hawkscan-local:
      docker-network: scan_net
      app-id: <your-app-id>
      configuration-files: stackhawk.yml
  # after
  - stackhawk/hawkscan_local:
      docker_network: scan_net
      app_id: <your-app-id>
      configuration_files: stackhawk.yml
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
