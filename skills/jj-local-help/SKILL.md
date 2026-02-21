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
4. For keyword topics (`jj help -k ...`), treat keyword help as authoritative over `references/core-concepts.md`.

## Help System Bootstrap Workflow (Always First)

Run these before answering command or concept questions:

```bash
skills/jj-local-help/scripts/jj_help.sh help
skills/jj-local-help/scripts/jj_help.sh help help
```

Use the first command to confirm top-level subcommands for the installed version.
Use the second command to confirm help semantics and keyword topics (`-k/--keyword`).

## Query Routing Workflow

### 1) Classify the user request

- Command-oriented: "How do I run X?"
- Concept-oriented: "What does X mean in jj?"
- Troubleshooting-oriented: "Why did command X fail?"

### 2) Route command-oriented requests

Resolve the command path, then fetch live help:

```bash
skills/jj-local-help/scripts/jj_help.sh rebase
skills/jj-local-help/scripts/jj_help.sh git push
skills/jj-local-help/scripts/jj_help.sh operation log
```

### 3) Route concept-oriented requests

First try keyword help:

```bash
skills/jj-local-help/scripts/jj_help.sh help -k tutorial
skills/jj-local-help/scripts/jj_help.sh help -k glossary
skills/jj-local-help/scripts/jj_help.sh help -k config
skills/jj-local-help/scripts/jj_help.sh help -k revsets
skills/jj-local-help/scripts/jj_help.sh help -k templates
skills/jj-local-help/scripts/jj_help.sh help -k filesets
```

Treat `jj help -k` output as the primary source of truth for those topics.
Use `references/core-concepts.md` only to:
- organize and simplify explanations
- connect concepts to practical command workflows
- cover concepts not directly exposed by `-k` topics

When both are available, cite and follow `jj help -k` first, then add a concise synthesis from `core-concepts.md`.

### 4) Route troubleshooting requests

- Check command help for expected flags/arguments.
- Point out likely mismatch with current version/configuration.
- Suggest exact follow-up command(s) to validate state.

## Concept Priority and Mapping

Use this mapping for concept-first questions:

- Getting started and learning path -> `tutorial`
- Term meaning or ambiguous wording -> `glossary`
- Behavior differences or policy configuration -> `config`
- Revision selection expressions -> `revsets`
- Output customization -> `templates`
- Path/file selection expressions -> `filesets`

## Response Contract (Required)

For every response, use this order:
1. Direct answer in one sentence.
2. Source line: installed version (`jj --version`) and help path used.
3. 1-3 runnable commands.
4. Caveat or pitfall note if relevant.

For concept answers, default to three layers:
1. What it is.
2. Why it matters.
3. Common pitfall or boundary.

Do not dump full docs. Extract only the parts needed for the specific question.

## Fallback Behavior

- If local `jj` is unavailable, say that live help cannot be queried and provide best-effort guidance with an explicit uncertainty note.
- If command lookup fails, ask a focused follow-up or suggest discovery:
  - `jj --help`
  - `jj help help`
  - `jj help <command>`
  - `jj help -k <keyword>` (for docs topics such as `tutorial`, `glossary`, `config`, `revsets`, `templates`, `filesets`)
