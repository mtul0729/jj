---
name: jj-local-help
description: Use when the user asks about Jujutsu (jj) commands, flags, errors, or workflows. Resolve command details at runtime from local `jj help` / `jj --help` output instead of hardcoding unstable docs.
---

## When to Use This Skill

Activate this skill when the user asks about:
- `jj` command usage, options, or examples
- `jj` errors and how to fix them
- `jj` workflow design (rewrite history, stacked changes, bookmarks, operations)
- differences between `jj` and Git for a concrete task

## Reliability Policy (Important)

`jj` evolves quickly. Do not hardcode option/flag details in this file.

For command behavior:
1. Prefer live local help text from `jj`.
2. Use this skill's concept notes only for stable mental models.
3. If concept notes conflict with live help, trust live help and state that notes may lag behind the installed version.

## Runtime Lookup Workflow

### 1) Start from full command index (`jj help`)

Always run `jj help` first to get the authoritative top-level subcommand list for the installed version.

Run:

```bash
skills/jj-local-help/scripts/jj_help.sh help
```

Use this output to:
- confirm command names exist in the current version
- avoid suggesting removed or renamed commands
- decide the nearest command family before drilling down

### 2) Identify target command path

- Convert user intent to a command path, e.g.:
  - "How do I rebase?" -> `rebase`
  - "Push to a Git remote" -> `git push`
  - "Show operation history" -> `operation log`

### 3) Fetch live help for that path

Run:

```bash
skills/jj-local-help/scripts/jj_help.sh rebase
skills/jj-local-help/scripts/jj_help.sh git push
```

The script tries:
1. `jj help <command path>`
2. `jj <command path> --help`

### 4) Compose response

- Start with a direct answer.
- Include 1-3 runnable command examples.
- Mention relevant caveats (immutable commits, working copy behavior, etc.).
- When helpful, include the installed version from `jj --version`.

## Core Concepts (Stable Reference)

Use `references/core-concepts.md` for stable concepts:
- Working copy is represented by a commit (`@`)
- Revision sets (revsets) for selecting history
- Operation log and undo/redo model
- Bookmarks vs Git branches
- History rewriting as a primary workflow

Do not copy large concept sections into every response. Pull only what is needed.

## Fallback Behavior

- If local `jj` is unavailable, say that live help cannot be queried and provide best-effort guidance with an explicit uncertainty note.
- If command lookup fails, ask a focused follow-up or suggest discovery:
  - `jj --help`
  - `jj help <command>`
  - `jj help -k <keyword>` (for docs topics such as `revsets`, `templates`, `config`, `tutorial`)
