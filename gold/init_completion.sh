#!/bin/bash
#
# Test our _init_completion builtin against the bash_completion implementaiton.
#
# Usage:
#   ./init_completion.sh <function name>

tab-complete() {
  local code=$1
  local sh=bash
  #local sh=bin/osh

  local pat='^FLAGS|^COMP_WORDS|^WORDS|^VAR'
  { cat gold/init_completion_lib.sh; echo "$code"; } |
    $sh --rcfile /dev/null -i 2>&1 |
    egrep "$pat" || echo "ERROR: output didn't match $pat"
}

# _init_completion flags used:
# -s
# -n :
#
# Do NOT need to implement:
#
# -o '@(diff|patch)' is used once.  But it's for redirect args, which we parse
# in OSH itself.
#
# NOTE: I see _init_completion -s -n : , but I believe that's identical to
# _init_completion -s.
# Also I see '-n =+!' once, but that may be a mistake.  The most common cases
# are : and =.

test-init() {
  tab-complete $'echo foo:bar --color=auto\t'

  # readline includes quotes, and _init_completion doesn't do anything about this.
  # I think that is a mistake and I will get rid of it?
  #
  # ls "--ver<TAB> or '--ver<TAB>' does NOT complete.
  # But echo 'fro<TAB> DOES!  So that is a mistake.

  tab-complete $'echo "foo:bar|" --color=auto\t'

  # scrape tab completion
  echo
  tab-complete $'noflags foo:bar --color=auto\t'
  tab-complete $'noflags "foo:bar|" --color=auto\t'
  tab-complete $'noflags "foo:bar|\t'

  echo
  tab-complete $'s foo:bar --color=auto\t'
  tab-complete $'s foo:bar --color auto\t'

  echo
  tab-complete $'n foo:bar --color=auto\t'

  echo
  tab-complete $'n2 foo:bar --color=auto\t'
}

"$@"