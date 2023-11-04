#!/usr/bin/env zsh

# ------------------------------------------------------------------------------
# GIT USER PLUGIN
# ------------------------------------------------------------------------------

# Define git user configuration
SPACESHIP_GIT_USER_SHOW="${SPACESHIP_GIT_USER_SHOW=true}"
SPACESHIP_GIT_USER_PREFIX="${SPACESHIP_GIT_USER_PREFIX="as "}"
SPACESHIP_GIT_USER_SYMBOL="${SPACESHIP_GIT_USER_SYMBOL=" "}"
SPACESHIP_GIT_USER_COLOR="${SPACESHIP_GIT_USER_COLOR="blue"}"

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


# ------------------------------------------------------------------------------
# DATE COUNTER PLUGIN
# ------------------------------------------------------------------------------

# Function to count the number of dates from a specified start date until now.
count_dates_until_now() {
    # Check if the start date is provided as an argument
    if [ -z "$1" ]; then
        echo "Usage: count_dates_until_now 'YYYY-MM-DD'"
        return 1
    fi

    start_date="$1"

    # Convert the start date and current date to Unix timestamps
    start_timestamp=$(date -j -f "%Y-%m-%d" "$start_date" +%s)
    current_timestamp=$(date +%s)

    # Calculate the number of dates
    days=$(( (current_timestamp - start_timestamp) / (60*60*24) ))

    # Output the result for command substitution
    echo "$days"
}

# Define git user configuration
SPACESHIP_DATE_COUNTER_SHOW="${SPACESHIP_DATE_COUNTER_SHOW=true}"
SPACESHIP_DATE_COUNTER_START_DATE="${SPACESHIP_DATE_COUNTER_START_DATE="2023-05-01"}"
SPACESHIP_DATE_COUNTER_PREFIX="${SPACESHIP_DATE_COUNTER_PREFIX="Date "}"
SPACESHIP_DATE_COUNTER_SYMBOL="${SPACESHIP_DATE_COUNTER_SYMBOL="󰧒 "}"
SPACESHIP_DATE_COUNTER_COLOR="${SPACESHIP_DATE_COUNTER_COLOR="red"}"

spaceship_date_counter() {
  # If SPACESHIP_DATE_COUNTER_SHOW is false, don't show date_counter section
  [[ $SPACESHIP_DATE_COUNTER_SHOW == false ]] && return

  # Display date_counter section
  local section=$(count_dates_until_now $SPACESHIP_DATE_COUNTER_START_DATE)
  spaceship::section::v4 \
    --color "$SPACESHIP_DATE_COUNTER_COLOR" \
    --symbol "$SPACESHIP_DATE_COUNTER_PREFIX" \
    --symbol "$SPACESHIP_DATE_COUNTER_SYMBOL" \
    "$section "
}

# Load date_counter section
spaceship add --after git_user date_counter