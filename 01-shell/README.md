# 01 · The Shell

> exercises: [The Shell](https://missing.csail.mit.edu/2020/course-shell/#exercises) — prompts are not reproduced; numbers follow the page.

```zsh
# 1
echo $SHELL                       # /bin/zsh — good to go

# 2
mkdir /tmp/missing                # create `missing` under /tmp

# 3
man touch                         # touch: change file times; creates the file if missing

# 4
touch /tmp/missing/semester

# 5
vi /tmp/missing/semester          # wrote the two lines
                                  # editor-free way: echo '#!/bin/sh' > semester
                                  # (single quotes — ! expands history even in "double")

# 6
./semester                        # permission denied: kernel checks the x bit first,
ls -l /tmp/missing/semester       # before even reading the shebang. -rw-r--r-- : no x

# 7
sh /tmp/missing/semester          # works: what's executed is /bin/sh — semester is just
                                  # data (argv[1]), so it needs r, not x.
                                  # to sh, the #! line is only a comment

# 8
man chmod

# 9
chmod +x /tmp/missing/semester
./semester                        # kernel accepts the exec now, sees #!, and reruns it
                                  # as `/bin/sh ./semester` — the shebang automates ex 7

# 10  → ~/last-modified.txt
sh /tmp/missing/semester \
| grep 'last-modified' \
| cut -d' ' -f2- \
> ~/last-modified.txt

# 11
# skipped — macOS has no /sys (sysfs is Linux-only)
```

Artifact: [`semester`](./semester) (ex 4–9)

## Notes

**`./semester` vs `sh semester`**

- `./semester` — runs the file itself; the kernel checks its `x` bit first,
  before even reading the shebang.
- `sh semester` — what runs is `/bin/sh`; the file is just an argument (data),
  so `r` is enough.
- Program → needs `x`. Data → needs `r`.

**Shebang (`#!/bin/sh`)**

- On `./semester`, the kernel reads the `#!` line and runs `/bin/sh ./semester` instead.
- The same line, two readers: the kernel picks the interpreter from it;
  to sh it's just a `#` comment.

**Name vs path (`$PATH`, `env`)**

- A name (`sh`) is searched through the `$PATH` directories; a path
  (`./semester`, `/bin/sh`) runs as-is, no search.
- The current directory isn't in `$PATH` — that's why `./` is needed.
- A shebang needs an absolute path → `#!/usr/bin/env bash` lets `env` find bash via `$PATH`.
- `/bin/sh` is a different shell per OS → use POSIX syntax only.
