#!/bin/bash
# Copies (or merges) this project's dbt profile into the default dbt profiles
# location (~/.dbt/profiles.yml), without overwriting profiles that already
# exist there for other dbt projects.

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TEMPLATE_PATH="$SCRIPT_DIR/../profiles.yml.example"
DBT_DIR="$HOME/.dbt"
PROFILE_PATH="$DBT_DIR/profiles.yml"

mkdir -p "$DBT_DIR"

if [ -f "$PROFILE_PATH" ]; then
    if grep -q "^synthea:" "$PROFILE_PATH"; then
        echo "Profile 'synthea' already exists in $PROFILE_PATH -- nothing changed."
    else
        printf "\n" >> "$PROFILE_PATH"
        cat "$TEMPLATE_PATH" >> "$PROFILE_PATH"
        echo "Profile 'synthea' appended to existing $PROFILE_PATH"
    fi
else
    cp "$TEMPLATE_PATH" "$PROFILE_PATH"
    echo "Created $PROFILE_PATH with the 'synthea' profile."
fi
