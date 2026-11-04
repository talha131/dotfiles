---
description: Write a handoff note for this session into its Obsidian session note, so it can be closed and resumed later with `cr`
allowed-tools: Bash(my-claude-park handoff:*)
---

The user is about to exit this session and resume it later, possibly days from
now, with `cr`. Write a handoff they (and you, on resume) can pick up from cold.

Write it in this shape, in Markdown, short and concrete. Name real files,
commands, branches and decisions; skip anything that is obvious from the
folder. Leave out a section that would be empty.

```markdown
**Goal:** one or two sentences on what this session is for.

**Done**
- …

**Next**
1. The very next step, specific enough to start on without rereading the chat.
2. …

**Open questions / blockers**
- …

**Key files**
- `path` — why it matters
```

Save it by piping it into the helper, which files it under this session's note
(it finds the session from `$CLAUDE_CODE_SESSION_ID`):

```sh
my-claude-park handoff <<'EOF'
…the handoff…
EOF
```

Then reply in one line with the note path it printed, and remind the user they
can exit now and run `cr` to come back. Do not exit or end the session yourself.

$ARGUMENTS
