local orgs = import 'vendor/otterdog-defaults/otterdog-defaults.libsonnet';

orgs.newOrg('eclipse-apoapsis') {
  settings+: {
    dependabot_security_updates_enabled_for_new_repositories: false,
    description: "The Eclipse Apoapsis project provides a process and a reference implementation for large-scale software composition analysis (SCA).",
    name: "Apoapsis project",
    web_commit_signoff_required: true,
  },
  _repositories+:: [
    orgs.newRepo('ort-server') {
      allow_auto_merge: true,
      allow_squash_merge: false,
      description: "A scalable server implementation of the OSS Review Toolkit.",
      has_discussions: true,
      has_wiki: false,
      branch_protection_rules: [
        orgs.newBranchProtectionRule('main') {
          dismisses_stale_reviews: true,
          is_admin_enforced: true,
          required_approving_review_count: 1,
          required_status_checks: [
            "build",
            "build-ui",
            "commit-lint",
            "detekt-issues",
            "integration-test",
            "renovate-validation",
            "reuse-tool",
            "test",
            "wrapper-validation",
          ],
          requires_linear_history: true,
        },
      ],
      secrets: [
        orgs.newRepoSecret('RENOVATE_TOKEN') {
          value: "pass:bots/technology.apoapsis/github.com/renovate-token",
        },
      ],
    },
    orgs.newRepo('guidance') {
      allow_auto_merge: true,
      allow_squash_merge: false,
      description: "The guidance for the Open Source Component Management process consists of a generic architecture description, usage blueprints, a concept of the abstraction layer and a collection of use cases. It enables you to quickly match your organization's needs with available solutions and jump-start your process definition by providing templates.",
      has_discussions: true,
      has_wiki: false,
      branch_protection_rules: [
        orgs.newBranchProtectionRule('main') {
          dismisses_stale_reviews: true,
          is_admin_enforced: true,
          required_approving_review_count: 1,
          requires_linear_history: true,
        }
      ]
    }
  ],
}
