# The Method in Ten Minutes

This is the short version of how the kit works. The full operating manual, with the collaboration triggers, the deliberation tiers, the cold-session recovery protocol, and two complete worked examples, is in [the Playbook](https://mangryung0404.gumroad.com/l/orchestration-playbook).

## The problem

CLI coding agents are good at executing and terrible at remembering. A session dies, and the next session starts bare-handed. You scale to two or three agents (say Claude Code orchestrating, Codex implementing, Gemini reviewing) and now nobody remembers anything, and the transcripts that do remember are unreadable by the other tools.

Chat history is not memory. Files are memory.

## The architecture

One **orchestrator** (your interactive session) and a pool of **workers** (any headless agent you can call: another Claude instance, Codex CLI, Gemini, a local model).

```
Orchestrator (interactive session, does the thinking and the verifying)
└── Worker Pool (headless calls, each one approved before use)
    ├── implementer   main build work
    ├── critic        adversarial review of outputs
    └── researcher    external facts and docs
```

Two rules make this safe:

1. **The orchestrator's own reasoning is free. Worker calls are not.** Every worker call costs tokens, quota, and latency, so every worker must be approved per task before its first call.
2. **Workers write only where the brief says they can.** Default is nowhere. A worker that produces code writes a diff into the task folder, and you apply it.

## The task folder

Every task gets a folder. The folder IS the shared memory: every tool can read it, and a fresh session can rebuild the whole picture from it.

```
tasks/<task-name>/
├── task.md        goal, status, constraints, worker approvals
├── context.md     snapshot of NOW (hard limit: 300 words)
├── log.md         append-only history with tags
├── sources/       original material, referenced by path
├── workers/
│   └── <role>/
│       ├── brief.md    what you asked (hard limit: 240 words)
│       └── result.md   what came back, plus a verification checklist
└── artifacts/     large outputs
```

## The discipline that makes it work

**Hard size limits.** `context.md` is capped at 300 words, briefs at 240. These numbers are not stylistic. Past the cap, agents start skimming, and a skimming agent silently drops your constraints. When the snapshot outgrows the cap, the overflow goes to `log.md` and the snapshot is rewritten.

**Paths, not payloads.** Briefs and context files never inline the contents of another file. They point to it. Inlined content goes stale the moment the source changes, and it eats the size budget that keeps agents attentive.

**Append-only log.** `log.md` never gets edited, only appended, with tags: `[DECISION]`, `[WORKER_CALL]`, `[VERIFICATION]`, `[ERROR]`, `[APPROVAL]`, `[COMPLETE]`. When the status field and the log disagree (it happens), the log is the source of truth, because nobody ever rewrote it to look better.

**Verification before acceptance.** Every worker result carries a checklist: does the output match the requested format, do the mentioned paths exist, are the constraints met, did the worker surface its assumptions. You run it before the result influences anything downstream. Workers are confidently wrong at roughly the same rate they are confidently right; the checklist is what catches the difference.

## What the Playbook adds

The templates get you the structure. The Playbook is the operating manual for the judgment calls the structure can't make for you:

- **Re-entry protocol.** The exact read-order and decision tree for walking into a half-finished task with zero context, including what to do when status and log contradict each other, and how to tell a hung worker from a slow one.
- **Self-routing.** When to spend money on a second opinion. The trigger system anchors on *actions you are about to take* (committing an architecture choice, asserting a fact outside your knowledge) rather than on how confident you feel, because confidence is exactly the signal that fails.
- **Risk-tiered deliberation.** One round for small stuff, find-then-refute for decisions that are expensive to reverse, with a hard cap so review never becomes an infinite loop, and a verdict table format that prevents "looks fine to me" sign-offs.
- **Degraded operation.** What to do when a worker is down: fallback ordering, when a cheaper model is acceptable, when to reroute across vendors, and how to mark outputs produced in degraded mode.
- **Two worked examples.** A three-worker feature build end to end, and a cold-session recovery of a stalled task, both with the actual folder contents at each step.

[Get the Playbook →](https://mangryung0404.gumroad.com/l/orchestration-playbook)
