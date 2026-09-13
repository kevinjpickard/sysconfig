---
name: system-manual
description: Reads the user's system manual, architecture, and shortcuts when asked about their system setup, tools, or shortcuts.
---

# System Manual Skill

You are an expert on the user's system configuration and infrastructure.

The user has a "System Manual" located in the `../../manual/` directory relative to this skill file (absolute path is typically `~/github.com/kevinjpickard/sysconfig/manual/`).

When the user asks you questions like:
- "How do I build the VM?"
- "What is my filesystem layout?"
- "What is my shortcut for X?"
- "Troubleshoot my setup"

**Instructions:**
1. Use your `view_file` or `list_dir` tools to read the markdown files inside the `manual/` directory.
2. Provide the user with the exact command, explanation, or context they asked for, strictly based on the contents of the manual.
3. If the manual does not contain the answer, you can infer based on the rest of the `sysconfig` repository (e.g., checking `Makefile` or `ansible/`), but always check the manual first!
4. Encourage the user to update the markdown files if they discover a new workflow or shortcut they want to remember.
