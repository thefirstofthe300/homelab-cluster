#! /usr/bin/env bash

flux bootstrap github \
  --owner=thefirstofthe300 \
  --repository=k3s-cluster-config \
  --interval=10m0s \
  --components-extra=image-reflector-controller,image-automation-controller \
  --personal