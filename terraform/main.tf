terraform {
  backend "kubernetes" {
    secret_suffix = "state"
    config_path   = "~/.kube/config"
  }
}

resource "aws_kms_alias" "vault_unseal_key" {
  name          = "alias/VaultUnsealKey"
  target_key_id = aws_kms_key.vault_unseal_key.key_id
}

resource "aws_kms_key" "vault_unseal_key" {
  description = "Key used to auto-unseal Vault"
}

resource "aws_iam_user" "vault" {
  name = "Vault"
}

data "aws_iam_policy_document" "vault" {
  statement {
    effect = "Allow"
    actions = [
      "kms:DecryptKey",
      "kms:EncryptKey",
      "kms:DescribeKey",
    ]
    resources = [
      aws_kms_key.vault_unseal_key.arn,
    ]
  }
}

resource "aws_iam_user_policy" "vault" {
  name   = "Vault"
  user   = aws_iam_user.vault.name
  policy = data.aws_iam_policy_document.vault.json
}
