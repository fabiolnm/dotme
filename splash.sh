#!/usr/bin/env bash
set -euo pipefail

# Palette A – Terminal Neo-Pixel
RED=$'\033[38;2;227;74;70m'      # #E34A46  (hat)
GREEN=$'\033[38;2;139;195;74m'    # #8BC34A  (body)
RESET=$'\033[0m'

print_me_idcard() {
  # Combined pixel avatar (left) + .me ASCII (right)
  line0="  ${RED}████${RESET}       ${GREEN}__  __     ${RESET}"
  line1=" ${RED}██${GREEN}██${RED}██${RESET}     ${GREEN}|  \\/  | ___${RESET}"
  line2="${RED}██${GREEN}████${RED}██${RESET}    ${GREEN}| |\\/| |/ _ \\${RESET}"
  line3=" ${GREEN}██████${RESET}     ${GREEN}| |  | |  __/${RESET}"
  line4="  ${GREEN}████${RESET}      ${GREEN}|_|  |_|\\___|${RESET}"

  printf '%s\n' "$line0"
  printf '%s\n' "$line1"
  printf '%s\n' "$line2"
  printf '%s\n' "$line3"
  printf '%s\n' "$line4"
  printf '\n'
}

print_me_idcard
