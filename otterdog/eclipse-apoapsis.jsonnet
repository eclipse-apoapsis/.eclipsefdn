local orgs = import 'vendor/otterdog-defaults/otterdog-defaults.libsonnet';

orgs.newOrg('eclipse-apoapsis') {
  settings+: {
    dependabot_security_updates_enabled_for_new_repositories: false,
    description: "",
    name: "Apoapsis project",
    web_commit_signoff_required: false,
  },
  _repositories+:: [
    orgs.newRepo('ort-server') {
      # Only set values that differ from the defaults, see:
      # https://github.com/EclipseFdn/otterdog-defaults/blob/main/otterdog-defaults.libsonnet
      has_wiki: false,
      auto_init: false,
      allow_squash_merge: false,
      allow_auto_merge: true,
    },
  ],
}
