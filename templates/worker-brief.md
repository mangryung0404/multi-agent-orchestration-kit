# Brief — [worker-role] / [task-name]

<!-- HARD LIMIT: 240 words. If the brief is longer, you are inlining things the worker should read from disk. -->
<!-- Never paste file contents into a brief. Pass paths. -->
<!-- Never write what the worker can infer on its own. -->

## Worker Conduct Rules (fixed block — keep verbatim in every brief)

- Minimum scope only. No speculative abstractions, no unrequested features.
- Surgical edits: match existing style, do not touch unrelated code.
- You have no channel to the user: state your assumptions explicitly, and surface every uncertainty or mismatch in the Issues/Caveats section of your result.

## Execution Context (required for any worker that writes files)

```yaml
target_repo: /absolute/path/to/repo   # target repo, or N/A
write_scope: none                     # none | task-folder-only | "src/**, tests/**" patterns
                                      # writes outside the task folder require separate approval
                                      # recorded in task.md workers_approved
```

## Objective

One sentence. What this worker must deliver.

## Input

```
# Paths only. Never paste contents.
task:    tasks/<task-name>/task.md
context: tasks/<task-name>/context.md
sources: tasks/<task-name>/sources/<file>
```

## Constraints

- constraint 1
- constraint 2

## Output Format

Specify the deliverable precisely:
- File location: `tasks/<task-name>/workers/<role>/result.md`
- Format: Markdown | JSON | Code | Diff
- Structure: (e.g. required section names or code block layout)

## Do NOT

- forbidden action 1
- forbidden action 2

## Prior Results (if any)

```
# Paths to earlier worker results, never inlined
implementer result: tasks/<task-name>/workers/implementer/result.md
```
