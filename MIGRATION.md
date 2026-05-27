# Migration Guide

## 1.x → 2.0.0

Version 2.0.0 renames the orb's **jobs** and **parameters** to `snake_case` to
follow CircleCI orb naming conventions (orb-tools `review` rule RC010). Job
behavior is unchanged — only the identifiers.

CircleCI orbs have no automated migrator: pin a version and update your config
when you bump the major. The changes below are the complete set you need.

### Jobs

| 1.x | 2.0.0 |
| --- | --- |
| `stackhawk/hawkscan-local` | `stackhawk/hawkscan_local` |
| `stackhawk/hawkscan-remote` | `stackhawk/hawkscan_remote` |

### Parameters (both jobs)

| 1.x | 2.0.0 |
| --- | --- |
| `api-key` | `api_key` |
| `configuration-files` | `configuration_files` |
| `docker-network` | `docker_network` |
| `app-id` | `app_id` |
| `auth-token` | `auth_token` |
| `docker-image` | `docker_image` |
| `resource-class` | `resource_class` |

`host`, `env`, `username`, `password`, `color`, and `steps` are unchanged.

### Example

```yaml
# 1.x
orbs:
  stackhawk: stackhawk/stackhawk@1.0.5
workflows:
  scan:
    jobs:
      - stackhawk/hawkscan-local:
          docker-network: scan_net
          app-id: <your-app-id>
          configuration-files: stackhawk.yml

# 2.0.0
orbs:
  stackhawk: stackhawk/stackhawk@2.0.0
workflows:
  scan:
    jobs:
      - stackhawk/hawkscan_local:
          docker_network: scan_net
          app_id: <your-app-id>
          configuration_files: stackhawk.yml
```
