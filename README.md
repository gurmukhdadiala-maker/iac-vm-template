# iac-vm-template

Approved starting point for a new application's infrastructure on the Easy Cloud platform.

## How to use it

1. Click **Use this template** → **Create a new repository**.
2. Name it `app-[appname]-infra` (for example `app-qms-infra`) and keep it **Private**.
3. Go to **Actions** → **Deploy VM** → **Run workflow** and fill in the form.

## Rules the pipeline checks

| Input | Rule | Example |
| --- | --- | --- |
| VM name | `vm-[app]-[env]-[nn]`, env must match the environment | `vm-qms-dev-01` |
| Cost centre | `CC-` + 6 digits | `CC-104233` |
| Application ID | `APP-` + 5 digits | `APP-20417` |
| Region | EU regions only | `westeurope` |

Production runs pause until a platform approver reviews them.

> Demo note: Azure sign-in and deployment are simulated in this repository.
