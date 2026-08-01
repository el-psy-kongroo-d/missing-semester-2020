# 02 · Shell Tools and Scripting

> exercises: [Shell Tools and Scripting](https://missing.csail.mit.edu/2020/shell-tools/#exercises) — prompts are not reproduced; numbers follow the page.

```zsh
# 1  ls with flags: hidden files, human-readable sizes, newest last, colorized
ls -alGh    # -a: show hidden files
            # -l: as list (size column only exists in long format)
            # -G: colorize (BSD ls; GNU ls uses --color=auto)
            # -h: humanize sizes (454M instead of 454279954)


# 2  marco / polo functions → 02-marco.sh
source 02-marco.sh                # source, not ./ — cd must survive in this shell
cd /tmp && marco                  # marco: saved current directory (/tmp)
cd ~ && polo                      # polo: moved back to /tmp


# 3  run 03-buggy.sh until it fails, collect stdout/stderr → 03-until-fail.sh
./03-until-fail.sh                # failed after 51 runs
                                  # loop condition = exit code (0 keeps looping);
                                  # the failing run skips the body → report CNT+1


# 4  zip all HTML files recursively, space-safe
find . -name '*.html' -print0 \
| xargs -0 zip htmls.zip          # zip takes names as args, not stdin → xargs bridges
                                  # -print0/-0: NUL-separated — NUL is the one char
                                  # that can't appear in a filename, so spaces survive
                                  # (without them: "my page.html" splits into 2 args)

# 5  (advanced) most recently modified file / all files by recency
find . -type f -exec stat -f '%m %N' {} + \
| sort -rn | head -1 | cut -d' ' -f2-
                                  # decorate (mtime in front) → sort → undecorate
                                  # {} = found paths; + batches them into one stat
                                  # (like xargs; \; would spawn stat once per file)
                                  # -f '%m %N' is BSD stat;
                                  # drop `head -1` → full list by recency
```

Artifacts: [`02-marco.sh`](./02-marco.sh) (ex 2) · [`03-buggy.sh`](./03-buggy.sh), [`03-until-fail.sh`](./03-until-fail.sh) (ex 3)

## Notes
