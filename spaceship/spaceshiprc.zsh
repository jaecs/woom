#!/usr/bin/env zsh

# ------------------------------------------------------------------------------
# GIT USER PLUGIN
# ------------------------------------------------------------------------------

# Define git user configuration
SPACESHIP_GIT_USER_SHOW="${SPACESHIP_GIT_USER_SHOW=true}"
SPACESHIP_GIT_USER_PREFIX="${SPACESHIP_GIT_USER_PREFIX="as "}"
SPACESHIP_GIT_USER_SYMBOL="${SPACESHIP_GIT_USER_SYMBOL="\ue708 "}"
SPACESHIP_GIT_USER_COLOR="${SPACESHIP_GIT_USER_COLOR="red"}"

spaceship_git_user() {
  # If current working directory is a Git repository, don't show git_user section
  spaceship::is_git || return

  # If SPACESHIP_GIT_USER_SHOW is false, don't show git_user section
  [[ $SPACESHIP_GIT_USER_SHOW == false ]] && return

  # If git user is empty, don't show git_user section
  [[ -z $(git config user.name) ]] && return

  # Display git_user section
  local section=$(git config user.name)
  spaceship::section::v4 \
    --color "$SPACESHIP_GIT_USER_COLOR" \
    --symbol "$SPACESHIP_GIT_USER_PREFIX" \
    --symbol "$SPACESHIP_GIT_USER_SYMBOL" \
    "$section "
}

# Load git_user section
spaceship add --after git git_user