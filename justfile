# To install just on a per-project basis
# 1. Activate your virtual environemnt
# 2. uv add --dev rust-just
# 3. Use just within the activated environment

drive_uuid := "77688511-78c5-4de3-9108-b631ff823ef4"
user :=  file_stem(home_dir())
def_drive := join("/media", user, drive_uuid, "env")
project := file_stem(justfile_dir())

local_inven := join(justfile_dir(), "inventory", "hosts")
local_creds := join(justfile_dir(), "group_vars", "all", "1credentials.yml")
local_vault := join(justfile_dir(), ".vault_pass.txt")

remote_inven := join(def_drive, project, "inventory", "hosts")
remote_creds := join(def_drive, project, "group_vars", "all", "1credentials.yml")
remote_vault := join(def_drive, project, ".vault_pass.txt")

# list all recipes
default:
    just --list

# ==================
# Backup environment
# ==================

# Backup .env to storage unit
env-bak drive=def_drive: (check_mnt drive) env-backup

# Restore .env from storage unit
env-rst drive=def_drive: (check_mnt drive) env-restore

[private]
check_mnt mnt:
    #!/usr/bin/env bash
    set -euo pipefail
    if [[ ! -d  {{ mnt }} ]]; then
        echo "Drive not mounted: {{ mnt }}"
        exit 1 
    fi

[private]
env-backup:
    #!/usr/bin/env bash
    set -euxo pipefail
    test -f {{local_inven}} && mkdir -p {{parent_dir(remote_inven)}} && cp {{local_inven}} {{remote_inven}}
    test -f {{local_creds}} && mkdir -p {{parent_dir(remote_creds)}} && cp {{local_creds}} {{remote_creds}}
    test -f {{local_vault}} && mkdir -p {{parent_dir(remote_vault)}} && cp {{local_vault}} {{remote_vault}}


[private]
env-restore:
    #!/usr/bin/env bash
    set -euxo pipefail
    test -f {{remote_inven}} && cp {{remote_inven}} {{local_inven}}
    test -f {{remote_creds}} && cp {{remote_creds}} {{local_creds}}
    test -f {{remote_vault}} && cp {{remote_vault}} {{local_vault}}
