---
description: Write a handoff note for this session into its Obsidian session note, so it can be closed and resumed later with `cr`
argument-hint: "[your own summary]"
allowed-tools: Bash(my-claude-park handoff:*)
---

The user is about to exit this session and resume it later, possibly days from
now, with `cr`. Write a handoff they (and you, on resume) can pick up from cold.

The user's own summary, possibly empty:

<user-summary>
$ARGUMENTS
</user-summary>

If the summary is not empty, it leads the handoff, verbatim, under
`**My summary:**`, on its own line. Up to 60 characters, it also names the note.
Fix nothing in it. Treat it as the user's view of where
things stand: let it steer the rest, and don't repeat what it already says.

Write it in this shape, in Markdown, short and concrete. Name real files,
commands, branches and decisions; skip anything that is obvious from the
folder. Leave out a section that would be empty.

```markdown
**My summary:** …the user's words, only when given…

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
