# Result — [worker-role] / [task-name]

<!-- Create this file AFTER the worker responds. Never pre-create an empty result. -->

```yaml
worker: <role>
task: [task-name]
status: draft | complete | failed
completed_at: <YYYY-MM-DD HH:MM>
tokens_used: (optional)
```

## Summary

One sentence. What was done.

## Output

<!-- The actual deliverable. Code in code blocks, documents as Markdown, analysis as sections. -->
<!-- Large artifacts go in artifacts/ with only the path recorded here. -->

## Verification Checklist

- [ ] Output matches the brief's output_format
- [ ] Every file path mentioned actually exists
- [ ] task.md constraints satisfied
- [ ] No "Do NOT" item violated
- [ ] Assumptions and mismatches surfaced in Issues/Caveats

## Issues / Caveats

<!-- Uncertainty, limitations, and anything that needs follow-up. An empty section is a claim that there are none. -->

## Artifacts

```
# Deliverables saved as separate files
tasks/<task-name>/artifacts/<file>
```
