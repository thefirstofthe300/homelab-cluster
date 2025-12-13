#! /usr/bin/env bash

flux install --export \
  --components-extra=image-reflector-controller,image-automation-controller > manifests/flux-system/gotk-components.yaml
