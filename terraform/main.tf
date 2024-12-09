provider "apko" {
  default_archs = ["x86_64", "aarch64"]
  extra_repositories = ["https://packages.wolfi.dev/os"]
  extra_keyring      = ["https://packages.wolfi.dev/os/wolfi-signing.rsa.pub"]
  extra_packages     = ["wolfi-baselayout"]
}

data "apko_config" "java" {
  config_contents = jsonencode({
    contents = {
      packages = [
        "openjdk-21-default-jvm",
        "glibc-locale-en",
        "libstdc++",
      ]
    },
    accounts = {
      groups = [{
        groupname = "nonroot",
        gid = 65532
      }],
      users = [{
        username = "nonroot",
        uid = 65532,
        gid = 65532
      }],
      run-as = 65532
    },
    work-dir = "/app"
    environment = {
      "LANG" : "en_US.UTF-8",
      "JAVA_HOME" : "/usr/lib/jvm/default-jvm"
    }
    accounts = {
      groups = [{
        groupname = "nonroot"
        gid       = 65532
      }]
      users = [{
        username = "nonroot"
        uid      = 65532
        gid      = 65532
      }]
      run-as = 65532
    }
    entrypoint = {
      command = "/usr/bin/java"
    }
  })
}

resource "apko_build" "java" {
  repo   = "docker.io/firstofth300/java"
  config = data.apko_config.java.config
}

resource "oci_tag" "java" {
  digest_ref = apko_build.java.sboms.index.digest
  tag = "21-jre"
}

data "apko_config" "node" {
  config_contents = jsonencode({
    contents = {
      packages = [
        "nodejs-22",
        "npm",
        "bash",
        "tini",
      ]
    }
    entrypoint = {
      command = "/usr/bin/node"
    },
    cmd = "--help",
    work-dir = "/app",
    accounts = {
      groups = [{
        groupname = "nonroot"
        gid       = 65532
      }]
      users = [{
        username = "nonroot"
        uid      = 65532
        gid      = 65532
      }]
      run-as = 65532
    }
    environment = {
      NODE_PORT = 3000,
      NPM_CONFIG_UPDATE_NOTIFIER = false,
      PATH : "/usr/sbin:/sbin:/usr/bin:/bin"
    }
    paths = [{
      path = "/app"
      type = "directory"
      uid = 65532
      gid = 65532
      permissions = 511
    }]
  })
}

resource "apko_build" "node" {
  repo   = "docker.io/firstofth300/node"
  config = data.apko_config.node.config
}

resource "oci_tag" "node" {
  digest_ref = apko_build.node.sboms.index.digest
  tag = "22"
}
