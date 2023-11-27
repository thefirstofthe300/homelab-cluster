#! /usr/bin/env bash

flux bootstrap github \
  --owner=thefirstofthe300 \
  --repository=homelab-cluster \
  --interval=10m0s \
  --components-extra=image-reflector-controller,image-automation-controller \
  --path=manifests/ \
  --personal
