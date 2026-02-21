# Repository Guidelines

## Project Structure & Module Organization
- Rust workspace crates live in `cli/` (the `jj` binary), `lib/` (core engine), `lib/testutils/`, `lib/proc-macros/`, and `lib/gen-protos/`.
- Command implementations are under `cli/src/commands/`; core library code is under `lib/src/`.
- Integration tests are in `cli/tests/` and `lib/tests/` with shared helpers in `cli/tests/common/`.
- User and developer docs are in `docs/`; the docs website source is in `web/docs/`.

## Build, Test, and Development Commands
- `cargo build --workspace`: build all Rust crates.
- `cargo test --workspace`: run full test suite.
- `cargo nextest run --workspace`: faster test runner (recommended for local iteration).
- `cargo insta test --workspace --test-runner nextest`: run snapshot tests.
- `cargo insta review --workspace`: accept/update snapshot outputs.
- `cargo +nightly fmt`: required formatting pass (CI expects nightly rustfmt).
- `cargo clippy --workspace --all-targets`: lint checks used by CI.
- `uv run mkdocs serve`: preview `docs/` at `http://127.0.0.1:8000`.
- In `web/docs/`: `npm run dev` to preview the Astro/Starlight docs site.

## Coding Style & Naming Conventions
- Follow `.editorconfig`: LF endings, final newline; Rust uses 4-space indentation.
- Follow `rustfmt.toml`: `max_width = 100`, grouped imports, item-level import granularity.
- Avoid panics unless guaranteed by documented invariants; prefer explicit error handling.
- Rust files/modules use `snake_case`; types/traits use `CamelCase`.
- Test files are typically named `test_<feature>.rs`.

## Testing Guidelines
- Prefer lower-level tests in `lib/tests/` when possible; add CLI end-to-end coverage only for command wiring/UX behavior.
- Keep tests with the code they validate in the same commit.
- For CLI output changes, update corresponding `insta` snapshots.

## Commit & Pull Request Guidelines
- Use focused, logical commits (avoid stacked fixup noise in final history).
- Commit subject format: `<topic>: <summary>` (for example, `revset: optimize prefix scan`). Do not use Conventional Commits.
- Include rationale in commit messages, not just what changed.
- PRs should provide context for reviewers, link relevant issues/design docs, and include docs/tests for behavior changes.
- Large or architectural changes should go through the design doc process in `docs/design_docs.md`.
