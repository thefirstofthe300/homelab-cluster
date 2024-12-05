#! /usr/bin/env bash

kubeseal -f secrets/authentik/secret.yaml -o yaml | grep -v creationTimestamp >manifests/authentik/sealedsecret.yaml
kubeseal -f secrets/synapse/bridges/mautrix-signal/secret.yaml -o yaml | grep -v creationTimestamp >manifests/synapse/bridges/mautrix-signal/sealedsecret.yaml
kubeseal -f secrets/synapse/bridges/mautrix-gmessages/secret.yaml -o yaml | grep -v creationTimestamp >manifests/synapse/bridges/mautrix-gmessages/sealedsecret.yaml
kubeseal -f secrets/synapse/bridges/mautrix-telegram/secret.yaml -o yaml | grep -v creationTimestamp >manifests/synapse/bridges/mautrix-telegram/sealedsecret.yaml
kubeseal -f secrets/synapse/bridges/mautrix-discord/secret.yaml -o yaml | grep -v creationTimestamp >manifests/synapse/bridges/mautrix-discord/sealedsecret.yaml
kubeseal -f secrets/synapse/bridges/registrations/secret.yaml -o yaml | grep -v creationTimestamp >manifests/synapse/bridges/registrations/sealedsecret.yaml
kubeseal -f secrets/redis/secret.yaml -o yaml | grep -v creationTimestamp >manifests/redis/sealedsecret.yaml
kubeseal -f secrets/immich/secret.yaml -o yaml | grep -v creationTimestamp >manifests/immich/sealedsecret.yaml
kubeseal -f secrets/inadyn/secret.yaml -o yaml | grep -v creationTimestamp >manifests/inadyn/sealedsecret.yaml
kubeseal -f secrets/postgres/secret.yaml -n immich -o yaml | grep -v creationTimestamp >>manifests/immich/sealedsecret.yaml
kubeseal -f secrets/cert-manager/secret.yaml -o yaml | grep -v creationTimestamp >manifests/cert-manager/sealedsecret.yaml
kubeseal -f secrets/nextcloud/secret.yaml -o yaml | grep -v creationTimestamp >manifests/nextcloud/sealedsecret.yaml
kubeseal -f secrets/postgres/secret.yaml -n nextcloud -o yaml | grep -v creationTimestamp >>manifests/nextcloud/sealedsecret.yaml
kubeseal -f secrets/synapse/matrix-synapse.yaml -o yaml | grep -v creationTimestamp >manifests/synapse/sealedsecret.yaml
echo "---" >>manifests/synapse/sealedsecret.yaml
kubeseal -f secrets/synapse/matrix-synapse-signingkey.yaml -o yaml | grep -v creationTimestamp >>manifests/synapse/sealedsecret.yaml
echo "---" >>manifests/synapse/sealedsecret.yaml
kubeseal -f secrets/synapse/postgres-synapse.yaml -o yaml | grep -v creationTimestamp >>manifests/synapse/sealedsecret.yaml
echo "---" >>manifests/synapse/sealedsecret.yaml
kubeseal -f secrets/synapse/redis-password.yaml -o yaml | grep -v creationTimestamp >>manifests/synapse/sealedsecret.yaml
echo "---" >>manifests/synapse/sealedsecret.yaml
kubeseal -f secrets/synapse/sliding-sync.yaml -o yaml | grep -v creationTimestamp >>manifests/synapse/sealedsecret.yaml
kubeseal -f secrets/velero/credentials-velero.yaml -o yaml | grep -v creationTimestamp >manifests/velero/sealedsecret.yaml
kubeseal -f secrets/velero/velero-repo-credentials.yaml -o yaml | grep -v creationTimestamp >>manifests/velero/sealedsecret.yaml
