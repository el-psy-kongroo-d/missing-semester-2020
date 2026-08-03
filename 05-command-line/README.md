# 05 · Command-line Environment

> exercises: [Command-line Environment](https://missing.csail.mit.edu/2020/command-line/#exercises) — prompts are not reproduced; numbers restart per section, following the page.

```zsh
## job control

# 1  background a sleep 10000, then kill it without typing the pid
sleep 10000                    # Ctrl-Z → suspended
bg                             # resume it in the background
pgrep -fl 'sleep 10000'        # -f: match full cmdline ("10000" is an arg,
                               #     not the process name) · -l: show match
pkill -f 'sleep 10000'         # same matching engine as pgrep + kill
                               # (hint says -af, but macOS -a ≠ linux -a → -l)

# 2  pidwait: wait for an arbitrary pid → jobctl-2-pidwait.sh
./jobctl-2-pidwait.sh <pid>    # `wait` refuses pids from other shells
                               # (children only); kill -0 pings ANY pid
                               # (exit 0 = alive) → poll + sleep 1

## terminal multiplexer
# skipped

## aliases

# 1  make an alias, then mine history for more candidates
history 1 | awk '{$1="";print substr($0,2)}' | sort | uniq -c | sort -n | tail -10
                               # top-10 most used commands
                               # awk: blank the event-number field ($1) →
                               # $0 rebuilds; substr($0,2) trims the gap
# picked from my top 10 → ~/.zshrc  (typo fixes + cd ladder, 2 dots/level)
alias dc=cd
alias sl=ls
alias ..='cd ..'
alias ....='cd ../..'
alias ......='cd ../../..'
alias ........='cd ../../../..'

## dotfiles
# repo: github.com/el-psy-kongroo-d/dotfiles (vimrc, zshrc) — steps 1,2,6 done
# install script + fresh-VM test: skipped
# full migration: partial — configs with secrets stay out of the public repo

## remote machines
# skipped — no practice VM; my real servers are production, not a playground
# (already using ssh keys + aliases; ~/.ssh/config migration noted for later)
```

Artifacts: [`jobctl-2-pidwait.sh`](./jobctl-2-pidwait.sh) (job control ex 2)

## Notes
