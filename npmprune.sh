#!/bin/sh

TARGET_DIR=node_modules

if [ ! -d $TARGET_DIR ]; then
	echo "$TARGET_DIR" does not exist
	exit 1
fi

# Base URL for templates (overridable via environment variable)
TEMPLATE_BASE_URL="${TEMPLATE_BASE_URL:-https://raw.githubusercontent.com/xthezealot/npmprune/refs/heads/master/templates}"

PROD_PATTERNS="
	*.map
	*.mts
	*.ts
"

log() {
  if [ "$NODE_ENV" != "production" ]; then
    echo "$@"
  fi
}

# Initialize variables
PATTERNS=""
TEMPLATES="default" # Always include "default"

# Function to download templates
download_template() {
  TEMPLATE_URL="$1"

  # Use `cat` if TEMPLATE_URL does not start with "http"
  if echo "$TEMPLATE_URL" | grep -qv '^http'; then
    if [ -f "$TEMPLATE_URL" ]; then
      cat "$TEMPLATE_URL"
    else
      echo "Error: File '$TEMPLATE_URL' does not exist." >&2
      return 1
    fi
  elif command -v wget >/dev/null 2>&1; then
    wget -qO- "$TEMPLATE_URL" 2>/dev/null
  elif command -v curl >/dev/null 2>&1; then
    curl -s "$TEMPLATE_URL" 2>/dev/null
  else
    echo "Error: Neither wget nor curl is installed. Please install one to proceed." >&2
    return 1
  fi
}

# Parse command-line arguments
while [ "$#" -gt 0 ]; do
  case "$1" in
  -t)
    shift
    TEMPLATES="$TEMPLATES,$1"
    ;;                                             # Templates
  *) PATTERNS="$PATTERNS $(printf '\n%s' "$1")" ;; # Add unnamed arguments to patterns
  esac
  shift
done

# Fetch templates if specified
if [ -n "$TEMPLATES" ]; then
  IFS=',' read -ra TEMPLATE_LIST <<<"$TEMPLATES"

  for TEMPLATE in "${TEMPLATE_LIST[@]}"; do
    TEMPLATE_URL="$TEMPLATE_BASE_URL/$TEMPLATE"

    if [ ! "$NODE_ENV" = "production" ]; then
      log "Fetching template: $TEMPLATE_URL"
    fi

    # Fetch the template and append its content to PATTERNS
    TEMPLATE_CONTENT=$(download_template "$TEMPLATE_URL")
    if [ $? -eq 0 ] && [ -n "$TEMPLATE_CONTENT" ]; then
      PATTERNS="$PATTERNS $(printf '\n%s' "$TEMPLATE_CONTENT")"
    else
      echo "Warning: Unable to fetch template '$TEMPLATE'. Skipping."
    fi
  done
fi

if [ "$NODE_ENV" = "production" ]; then
	PATTERNS="$PATTERNS $PROD_PATTERNS"
fi

# Exit if PATTERNS is empty
if [ -z "$(echo "$PATTERNS" | xargs)" ]; then
  echo "Error: No valid patterns found. Exiting." >&2
  exit 1
fi

log "$TARGET_DIR size before: $(du -sh $TARGET_DIR | awk '{print $1}')"

find_cmd="find $TARGET_DIR \("
first_pattern=true
printf '%s\n' "$PATTERNS" | (
	while IFS= read -r line; do
		line=$(echo "$line" | xargs)

		# skip empty lines
		if [ -z "$line" ]; then
			continue
		fi

		# add -o if not the first pattern
		if [ "$first_pattern" = false ]; then
			find_cmd="$find_cmd -o"
		else
			first_pattern=false
		fi

		find_cmd="$find_cmd -iname '$line'"
	done

	eval "$find_cmd \) -exec rm -rf {} +"
)

log "$TARGET_DIR size after:  $(du -sh $TARGET_DIR | awk '{print $1}')"
