# [task-name]

## Meta

```yaml
status: pending
# allowed values:
#   pending          task defined, not started
#   in_progress      orchestrator actively working
#   waiting_<role>   waiting on a specific worker (e.g. waiting_reviewer)
#   reviewing        verifying worker output (user checkpoint)
#   done             complete
created: <YYYY-MM-DD>
updated: <YYYY-MM-DD>
priority: medium  # high | medium | low
```

## Goal

One sentence. What does "done" look like?

## Constraints

- constraint 1
- constraint 2

## Acceptance Criteria

- [ ] criterion 1
- [ ] criterion 2

## Worker Plan

```yaml
# Every worker call requires approval BEFORE the first call.
# Empty list = no worker calls allowed.
workers_approved: []
# approval entry example:
# - worker: implementer
#   approved_at: <YYYY-MM-DD>
#   purpose: specific purpose for this task
#   approved_by: user

# Minimum set only. Do not pre-plan workers "just in case".
planned_workers: []
# examples (uncomment only what you need):
# - role: implementer     # main coding / build work
#   purpose:
# - role: critic          # adversarial review of outputs
#   purpose:
# - role: researcher      # external facts, docs, web verification
#   purpose:
```

## Context Snapshot

<!-- Summary of the CURRENT state only, distilled from context.md. -->
<!-- Hard limit: 300 words. Long background goes in sources/ and is referenced by path. -->

## Notes

<!-- Anything else the orchestrator needs for judgment calls. -->
