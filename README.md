[![StackHawk](https://www.stackhawk.com/wp-content/uploads/2025/07/stackhawk-light-long.png)](https://stackhawk.com)

# 🦅 StackHawk CircleCI Orb

The CircleCI Orb [`stackhawk/stackhawk`](https://circleci.com/orbs/registry/orb/stackhawk/stackhawk) makes it easy to integrate StackHawk into your continuous integration pipeline.

## About StackHawk
[StackHawk](https://stackhawk.com) provides dynamic application vulnerability scanning from development to production.

  * ⚡ **Dynamic Application Scanning:** Use HawkScan to find and fix security bugs in your web apps, before you push to production. Think of it as security integration testing. [Get started](https://docs.stackhawk.com/hawkscan/getting-started.html) with your first scan in minutes.
  * 🦸 **Built for Modern Dev Teams:** Automate scans with Docker commands, manage configs via YAML, and add app scanning as a build stage. We're built for dev teams that care about security and quality.
  * 🧰 **Vulnerability Management:** (coming soon!) Document for compliance. Prioritize and manage fixes with integrations to existing ticketing tools. Point in time assessments are a thing of the past - there is a better way.

Use the HawkScan command line tool to run application scans manually or through automation. Use the stackhawk/stackhawk Orb to make it simple to run it in CircleCI.

## Sign Up
To use this Orb, you must have a StackHawk API key. [Sign up](https://stackhawk.com) to get yours.

## Configure HawkScan
To scan your application, you will need a `stackhawk.yml` configuration file in your application source repository. [Read the docs](https://docs.stackhawk.com/) for more details.

## Upgrading to v2.0.0 (breaking changes)

Version 2.0.0 renames the orb's jobs and parameters to `snake_case` to follow
CircleCI orb conventions. Job *behavior* is unchanged — only the names. Update
your `.circleci/config.yml` when upgrading:

| Before (1.x) | After (2.0.0) |
| --- | --- |
| `stackhawk/hawkscan-local` | `stackhawk/hawkscan_local` |
| `stackhawk/hawkscan-remote` | `stackhawk/hawkscan_remote` |
| `api-key` | `api_key` |
| `configuration-files` | `configuration_files` |
| `docker-network` | `docker_network` |
| `app-id` | `app_id` |
| `auth-token` | `auth_token` |
| `docker-image` | `docker_image` |
| `resource-class` | `resource_class` |

(`host`, `env`, `username`, `password`, `color`, and `steps` are unchanged.)

See [`CHANGELOG.md`](CHANGELOG.md) for the full list and an example.

## Need Help?
If you have questions or need some help, please email us at support@stackhawk.com.

## KAAKAWW!
That is all.
 
