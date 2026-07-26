# Multi-Agent Orchestration Kit

File-based orchestration templates for CLI coding agents. Run one interactive session (Claude Code, Codex CLI, whatever you drive by hand) as the **orchestrator**, and delegate to headless **workers** across vendors, with plain markdown files as the shared memory.

No framework. No server. No SDK. Five markdown templates and a discipline.

## Why

If you run more than one coding agent, you have hit these:

- A session dies mid-task and the next one starts from zero.
- Worker output looked fine, got merged, and was confidently wrong.
- One agent's context is invisible to the other agents (and to you, three days later).
- An agent burned quota re-deriving something another agent already established.

The fix used here is boring on purpose: every task is a folder, every folder is readable by every tool, hard size limits keep agents attentive, an append-only log survives every crash, and nothing a worker produces is accepted without a verification pass.

This is the system I use daily to run Claude Code as an orchestrator over Codex, Gemini, and a local model. The templates are extracted from it, with the project-specific parts generalized.

## Quickstart

```bash
git clone https://github.com/mangryung0404/multi-agent-orchestration-kit
cd your-project
mkdir -p tasks

# new task
TASK=my-task
mkdir -p tasks/$TASK
cp path/to/kit/templates/task.md    tasks/$TASK/task.md
cp path/to/kit/templates/context.md tasks/$TASK/context.md
cp path/to/kit/templates/log.md     tasks/$TASK/log.md
```

1. Fill in `task.md`: goal, constraints, acceptance criteria. Leave `workers_approved` empty.
2. Decide the minimum worker set. Get approval (from yourself, deliberately, or from your user) and record it in `workers_approved` before the first call.
3. Per worker call: copy `templates/worker-brief.md` into `tasks/$TASK/workers/<role>/brief.md`, keep it under 240 words, pass paths instead of pasting content.
4. Save the raw response as `result.md` next to the brief, then run its verification checklist before you use anything from it.
5. Append every decision, call, verification, and error to `log.md`. Never edit old lines.

The 10-minute walkthrough of the whole method is in [docs/method.md](docs/method.md).

## What's in the box

| File | Purpose |
|---|---|
| `templates/task.md` | Task definition: goal, status lifecycle, approval gate |
| `templates/context.md` | Current-state snapshot, hard-capped at 300 words |
| `templates/log.md` | Append-only history with `[DECISION]`/`[WORKER_CALL]`/`[VERIFICATION]` tags |
| `templates/worker-brief.md` | Worker instructions, hard-capped at 240 words, paths not payloads |
| `templates/worker-result.md` | Worker output plus mandatory verification checklist |
| `docs/method.md` | The method in ten minutes |

## The Playbook (paid)

The templates are free and always will be. The **Multi-Agent Orchestration Playbook** is the operating manual distilled from months of daily use on real projects, including the parts that only exist because something broke:

- The **re-entry protocol**: walking into a half-finished task with a cold session, including the status-vs-log conflict rule and hang detection.
- **Self-routing triggers**: when to spend money on a second worker opinion, anchored to observable actions instead of felt confidence (which is the signal that fails).
- **Risk-tiered deliberation**: 1-round for cheap decisions, find-then-refute for expensive ones, hard-capped at 3 rounds, with a CLAIM / EVIDENCE / VERDICT table that kills rubber-stamp reviews.
- **Degraded operation**: fallback ordering when workers are down, free-tier data-privacy gates, cross-vendor rerouting conditions.
- **Two complete worked examples** with the key files at every step: a three-worker feature build, and a cold-session recovery of a stalled task.
- **Two appendices that make it concrete**: complete examples of every system file the book mandates (rules file, entry pointers, invariants check, skills index), and the wiring: actual per-vendor worker invocations plus a hang-triage table.

**[Get the Playbook on Gumroad →](https://mangryung.gumroad.com/l/orchestration-playbook)** (launch price $19)

## FAQ

**Does this need Claude Code?**
No. The orchestrator is whatever interactive agent you drive; workers are whatever you can invoke headlessly. The templates are plain markdown.

**Why files instead of a memory MCP / vector store?**
Files are readable by every tool including you, diffable, git-versioned, and they survive every crash. For task-scoped orchestration state, nothing else has that property set.

**Why the word caps?**
Because agents skim long context and silently drop constraints. The caps are the cheapest attention guarantee available.

## License

Templates and docs: [MIT](LICENSE). See [NOTICE](NOTICE) for attribution.
