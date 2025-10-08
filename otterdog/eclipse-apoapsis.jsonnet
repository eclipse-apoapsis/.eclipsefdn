local orgs = import 'vendor/otterdog-defaults/otterdog-defaults.libsonnet';

orgs.newOrg('technology.apoapsis', 'eclipse-apoapsis') {
  settings+: {
    description: "The Eclipse Apoapsis project provides a process and a reference implementation for large-scale software composition analysis (SCA).",
    name: "Apoapsis project",
  },
  secrets+: [
    orgs.newOrgSecret('ORG_GPG_KEY_ID') {
      value: "pass:bots/technology.apoapsis/gpg/key_id",
    },
    orgs.newOrgSecret('ORG_GPG_SUBKEY_ID') {
      value: "pass:bots/technology.apoapsis/gpg/subkey_id",
    },
    orgs.newOrgSecret('ORG_GPG_PASSPHRASE') {
      value: "pass:bots/technology.apoapsis/gpg/passphrase",
    },
    orgs.newOrgSecret('ORG_GPG_PRIVATE_KEY') {
      value: "pass:bots/technology.apoapsis/gpg/secret-subkeys.asc",
    },
    orgs.newOrgSecret('CENTRAL_SONATYPE_TOKEN_PASSWORD') {
      value: "pass:bots/technology.apoapsis/central.sonatype.org/token-password",
    },
    orgs.newOrgSecret('CENTRAL_SONATYPE_TOKEN_USERNAME') {
      value: "pass:bots/technology.apoapsis/central.sonatype.org/token-username",
    },
  ],
  _repositories+:: [
    orgs.newRepo('.github') {
      allow_auto_merge: true,
      allow_squash_merge: false,
      description: "Default GitHub configuration.",
      has_discussions: false,
      has_issues: false,
      has_projects: false,
      has_wiki: false,
      branch_protection_rules: [
        orgs.newBranchProtectionRule('main') {
          dismisses_stale_reviews: true,
          is_admin_enforced: true,
          required_approving_review_count: 1,
          requires_linear_history: true,
        },
      ]
    },
    orgs.newRepo('actions') {
      aliases: ['setup-osc'],
      allow_auto_merge: true,
      allow_squash_merge: false,
      description: "A collection of GitHub actions for the Eclipse Apoapsis project.",
      has_discussions: false,
      has_wiki: false,
      branch_protection_rules: [
        orgs.newBranchProtectionRule('main') {
          dismisses_stale_reviews: true,
          is_admin_enforced: true,
          required_approving_review_count: 1,
          required_status_checks+: [
            "commit-lint",
            "renovate-validation"
          ],
          requires_linear_history: true,
        },
      ]
    },
    orgs.newRepo('guidance') {
      allow_auto_merge: true,
      allow_squash_merge: false,
      description: "The guidance for the Open Source Component Management process consists of a generic architecture description, usage blueprints, a concept of the abstraction layer and a collection of use cases. It enables you to quickly match your organization's needs with available solutions and jump-start your process definition by providing templates.",
      gh_pages_build_type: "workflow",
      homepage: "https://eclipse-apoapsis.github.io/guidance/",
      topics: [
        "compliance",
        "ospo",
        "oss-compliance",
        "sbom",
        "sca",
        "software-composition-analysis",
        "spdx"
      ],
      has_discussions: true,
      has_wiki: false,
      branch_protection_rules: [
        orgs.newBranchProtectionRule('main') {
          dismisses_stale_reviews: true,
          is_admin_enforced: true,
          required_approving_review_count: 1,
          required_status_checks+: [
            "renovate-validation",
            "reuse-tool",
            "Website Test"
          ],
          requires_linear_history: true,
        },
      ],
      environments: [
        orgs.newEnvironment('github-pages') {
          branch_policies+: [
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
      gh_pages_build_type: "workflow",
      homepage: "https://eclipse-apoapsis.github.io/ort-server/",
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
      environments: [
        orgs.newEnvironment('copilot'),
        orgs.newEnvironment('github-pages') {
          branch_policies+: [
            "main"
          ],
          deployment_branch_policy: "selected",
        },
      ],
      rulesets: [
        orgs.newRepoRuleset('main') {
          include_refs+: [
            "refs/heads/main",
          ],
          required_pull_request+: {
            required_approving_review_count: 1,
            dismisses_stale_reviews: true,
          },
          required_status_checks+: {
            status_checks: [
              "authorization-test",
              "build",
              "build-ui",
              "commit-lint",
              "completions",
              "detekt-issues",
              "eslint",
              "integration-test",
              "prettier-ui",
              "prettier-website",
              "renovate-validation",
              "reuse-tool",
              "test",
              "website-test",
              "Build Linux x64 CLI",
              "Build macOS arm64 CLI",
              "Build macOS x64 CLI",
              "Build Windows x64 CLI",
              "Build core Docker Image",
              "Build orchestrator Docker Image",
              "Build ui Docker Image",
              "Build advisor-worker Docker Image",
              "Build analyzer-worker Docker Image",
              "Build config-worker Docker Image",
              "Build evaluator-worker Docker Image",
              "Build maintenance-tasks Docker Image",
              "Build notifier-worker Docker Image",
              "Build reporter-worker Docker Image",
              "Build scanner-worker Docker Image"
            ],
          },
          requires_linear_history: true,
          required_merge_queue: orgs.newMergeQueue() {
            merge_method: "REBASE",
          },
        },
      ],
    },
    orgs.newRepo('renovate') {
      allow_auto_merge: true,
      allow_squash_merge: false,
      description: "Configuration to run Renovate as a GitHub action.",
      has_discussions: false,
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
          required_status_checks+: [
            "renovate-validation"
          ],
          requires_linear_history: true,
        },
      ],
    }
  ],
  teams+: [
    orgs.newTeam('backend-devs') {
      description: "Project committers active in backend development.",
      privacy: "visible",
      notifications: true,
      members+: [
        "bs-ondem",
        "MarcelBochtler",
        "mnonnenmacher",
        "nnobelis",
        "oheger-bosch",
        "sschuberth",
        "wkl3nk",
      ],
    },
    orgs.newTeam('frontend-devs') {
      description: "Project commmitters active in frontend development.",
      privacy: "visible",
      notifications: true,
      members+: [
        "Etsija",
        "lamppu",
        "mnonnenmacher",
        "sschuberth",
      ],
    }
  ],
}
