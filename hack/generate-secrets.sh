#! /usr/bin/env bash

kubeseal -f secrets/synapse/bridges/mautrix-signal/secret.yaml -o yaml | grep -v creationTimestamp >manifests/synapse/bridges/mautrix-signal/sealedsecret.yaml
kubeseal -f secrets/synapse/bridges/mautrix-telegram/secret.yaml -o yaml | grep -v creationTimestamp >manifests/synapse/bridges/mautrix-telegram/sealedsecret.yaml
kubeseal -f secrets/synapse/bridges/mautrix-discord/secret.yaml -o yaml | grep -v creationTimestamp >manifests/synapse/bridges/mautrix-discord/sealedsecret.yaml
kubeseal -f secrets/synapse/bridges/mx-puppet-groupme/secret.yaml -o yaml | grep -v creationTimestamp >manifests/synapse/bridges/mx-puppet-groupme/sealedsecret.yaml
kubeseal -f secrets/synapse/bridges/registrations/secret.yaml -o yaml | grep -v creationTimestamp >manifests/synapse/bridges/registrations/sealedsecret.yaml
kubeseal -f secrets/immich/secret.yaml -o yaml | grep -v creationTimestamp >manifests/immich/sealedsecret.yaml
kubeseal -f secrets/cert-manager/secret.yaml -o yaml | grep -v creationTimestamp >manifests/cert-manager/sealedsecret.yaml
