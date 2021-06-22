locals {
  ssh_keys = compact(concat([var.ssh_key], var.extra_ssh_keys))
}
