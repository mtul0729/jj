# jj Core Concepts (Stable Notes)

Use these notes for conceptual explanation. For exact flags/options, always query live help.

## 1) Working copy is a commit

- `jj` models the working copy as a real commit (`@`).
- Many commands rewrite or replace commits rather than staging files.
- This is why history-edit commands are part of normal day-to-day flow.

## 2) Changes and commits

- A "change" may evolve across multiple rewritten commits.
- `jj` tracks evolution, enabling commands like operation/history introspection.

## 3) Revsets are central

- Revsets are query expressions for selecting revisions.
- Users commonly combine revsets with `log`, `show`, `rebase`, `squash`, and other history operations.

## 4) Operation log and recovery

- `jj` records repository operations.
- `undo`/`redo` can recover from many mistakes by moving across operation history.

## 5) Bookmarks vs Git branches

- In `jj`, bookmarks are the primary movable names for revisions.
- In Git-backed workflows, bookmarks map to branch-like collaboration flows.

## 6) Rewriting history is normal

- `new`, `edit`, `describe`, `squash`, `split`, and `rebase` are standard tools.
- The model assumes frequent refinement before publishing.

## 7) Immutable revisions

- Some revisions may be configured as immutable.
- Rewrite attempts can fail unless explicitly overridden by relevant options.

## 8) Git compatibility model

- `jj` can operate with Git remotes.
- Users typically use `jj git fetch` / `jj git push` for remote sync.

