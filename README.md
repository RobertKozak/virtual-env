# virtual-env

This action creates a namespace in k8s based on the branch name

## Inputs

### `action`

**Required** action to perfrom: create, delete, deploy'

### `branch`

**Required** branch used as namespace in k8s

### `aws_access_key_id`

**Required** aws access key id

### `aws_secret_access_key`

**Required** aws secret access key

### `vault_password`

password for ansible vault

### `service`

service to deploy

### `version`

version of service to deploy

## Example usage

```uses: actions/virtual-env@v1
with:
  action: "$GITHUB_EVENT_NAME"
  branch: "$GITHUB_REF_NAME"
  aws_access_key_id: "${secret.AWS_ACCESS_KEY_ID}"
  aws_secret_access_key: "${secret.AWS_SECRET_ACCESS_KEY}"

uses: actions/virtual-env@v1
with:
  action: "$GITHUB_EVENT_NAME"
  branch: "$GITHUB_REF_NAME"
  aws_access_key_id: "${secret.AWS_ACCESS_KEY_ID}"
  aws_secret_access_key: "${secret.AWS_SECRET_ACCESS_KEY}"
  vault_password: "${secret.VAULT_PASSWORD}"
  service: ${GITHUB_REPOSITORY}
```
