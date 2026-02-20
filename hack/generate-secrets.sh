#! /usr/bin/env bash

function encrypt {
    echo "Encrypting $1 to $2"
    kubeseal -f $1 -o yaml | grep -v creationTimestamp >$2
}
# encrypt secrets/authentik/secret.yaml manifests/authentik/sealedsecret.yaml
encrypt secrets/synapse/bridges/mautrix-signal/secret.yaml manifests/synapse/bridges/mautrix-signal/sealedsecret.yaml
encrypt secrets/synapse/bridges/mautrix-gmessages/secret.yaml manifests/synapse/bridges/mautrix-gmessages/sealedsecret.yaml
encrypt secrets/synapse/bridges/mautrix-telegram/secret.yaml manifests/synapse/bridges/mautrix-telegram/sealedsecret.yaml
encrypt secrets/synapse/bridges/mautrix-discord/secret.yaml manifests/synapse/bridges/mautrix-discord/sealedsecret.yaml
encrypt secrets/synapse/bridges/registrations/secret.yaml manifests/synapse/bridges/registrations/sealedsecret.yaml
# encrypt secrets/redis/secret.yaml manifests/redis/sealedsecret.yaml
encrypt secrets/immich/secret.yaml manifests/immich/sealedsecret.yaml
# encrypt secrets/inadyn/secret.yaml manifests/inadyn/sealedsecret.yaml
# encrypt secrets/cert-manager/secret.yaml manifests/cert-manager/sealedsecret.yaml
# encrypt secrets/nextcloud/secret.yaml manifests/nextcloud/sealedsecret.yaml
# kubeseal -f secrets/postgres/secret.yaml -o yaml -n nextcloud | grep -v creationTimestamp >>manifests/nextcloud/sealedsecret.yaml
# encrypt secrets/synapse/matrix-synapse-signingkey.yaml manifests/synapse/sealedsecret.yaml
# kubeseal -f secrets/synapse/postgres-synapse.yaml -o yaml -n synapse | grep -v creationTimestamp >> manifests/synapse/sealedsecret.yaml
# kubeseal -f secrets/synapse/redis-password.yaml -o yaml -n synapse | grep -v creationTimestamp >> manifests/synapse/sealedsecret.yaml
# encrypt secrets/velero/credentials.yaml manifests/velero/sealedsecret.yaml
