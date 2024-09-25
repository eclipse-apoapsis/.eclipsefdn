local orgs = import 'vendor/otterdog-defaults/otterdog-defaults.libsonnet';

orgs.newOrg('eclipse-apoapsis') {
  settings+: {
    description: "The Eclipse Apoapsis project provides a process and a reference implementation for large-scale software composition analysis (SCA).",
    name: "Apoapsis project",
  },
  _repositories+:: [
    orgs.newRepo('guidance') {
      allow_auto_merge: true,
      allow_squash_merge: false,
      description: "The guidance for the Open Source Component Management process consists of a generic architecture description, usage blueprints, a concept of the abstraction layer and a collection of use cases. It enables you to quickly match your organization's needs with available solutions and jump-start your process definition by providing templates.",
      topics: [
        "compliance",
        "ospo",
        "oss-compliance",
        "sbom",
        "sca",
        "software-composition-analysis",
        "spdx"
      ],
      gh_pages_build_type: "workflow",
      has_discussions: true,
      has_wiki: false,
      branch_protection_rules: [
        orgs.newBranchProtectionRule('main') {
          dismisses_stale_reviews: true,
          is_admin_enforced: true,
          required_approving_review_count: 1,
          requires_linear_history: true,
        },
      ],
      environments: [
        orgs.newEnvironment('github-pages') {
          branch_policies+: [
            "gh_pages",
            "main"
          ],
          deployment_branch_policy: "selected",
        },
      ],
    },
    orgs.newRepo('ort-server') {
      allow_auto_merge: true,
      allow_squash_merge: false,
      description: "A scalable server implementation of the OSS Review Toolkit.",
      topics: [
        "compliance",
        "cyclonedx",
        "hacktoberfest",
        "ospo",
        "oss-compliance",
        "oss-review-toolkit",
        "sbom",
        "sca",
        "software-composition-analysis",
        "spdx",
        "vulnerability-detection"
      ],
      has_discussions: true,
      has_wiki: false,
      secrets: [
        orgs.newRepoSecret('RENOVATE_TOKEN') {
          value: "pass:bots/technology.apoapsis/github.com/renovate-token",
        },
      ],
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
            "eslint",
            "integration-test",
            "prettier",
            "renovate-validation",
            "reuse-tool",
            "test",
            "website-test",
            "wrapper-validation"
          ],
          requires_linear_history: true,
        },
      ],
    },
  ],
}
