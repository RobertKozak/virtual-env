# virtual-env

This action creates a namespace in k8s based on the branch name

## Inputs

### `branch`

**Required** branch used as namespace in k8s

### `aws_access_key_id`

**Required** aws access key id

### `aws_secret_access_key`

**Required** aws secret access key

## Example usage

uses: actions/virtual-env@v1
with:
  branch: "$GITHUB_REF_NAME"
