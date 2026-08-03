# 04 · Data Wrangling

> exercises: [Data Wrangling](https://missing.csail.mit.edu/2020/data-wrangling/#exercises) — prompts are not reproduced; numbers follow the page.

```zsh
# 1  interactive regex tutorial (regexone.com)
# done

# 2  /usr/share/dict/words: words with ≥3 a's, not ending in 's

# 2-1  how many words
tr '[:upper:]' '[:lower:]' < /usr/share/dict/words \
| grep -E '(.*a){3}' | grep -v "'s$" | wc -l               # 7596

# 2-2  three most common last-two-letter endings
tr '[:upper:]' '[:lower:]' < /usr/share/dict/words \
| grep -E '(.*a){3}' | grep -v "'s$" \
| sed -E 's/.*(..)$/\1/' | sort | uniq -c | sort -n | tail -3
                                           # al 1039 · ia 814 · an 763

# 2-3  distinct endings — same, ending in  | sort -u | wc -l   # 156

# 2-4  (challenge) endings that never occur
echo {a..z}{a..z} | tr ' ' '\n' \
| grep -vxFf <(tr '[:upper:]' '[:lower:]' < /usr/share/dict/words \
               | grep -E '(.*a){3}' | grep -v "'s$" \
               | sed -E 's/.*(..)$/\1/' | sort -u)         # 520 of 676

# 3  why is  sed s/A/B/ input.txt > input.txt  a bad idea?
# `>` truncates input.txt before sed even runs → file ends up empty;
# not sed-specific. safe:
sed -i '' 's/A/B/' input.txt
sed 's/A/B/' input.txt > tmp && mv tmp input.txt

# 4  boot time stats over last 10 boots
# skipped — macOS unified log only retains 2 boots here

# 5  boot messages not shared across the last 3 reboots
# skipped — same log retention limit as ex 4

# 6  online dataset: iris.csv (150 rows; sepal_length,sepal_width,…)
# 6-1  min & max of sepal_length
curl -s https://raw.githubusercontent.com/mwaskom/seaborn-data/master/iris.csv \
| tail -n +2 | cut -d, -f1 | sort -n | sed -n '1p;$p'
                                           # 4.3 / 7.9

# 6-2  difference of the two columns' sums
curl -s https://raw.githubusercontent.com/mwaskom/seaborn-data/master/iris.csv \
| awk -F, 'NR > 1 { a += $1; b += $2 } END { print a - b }'
                                           # 417.9
```

Artifacts: none

## Notes
