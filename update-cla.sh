#!/bin/bash

# Script to automate CLA updates
# Usage: ./update-cla.sh <github-username>

set -e

if [ $# -eq 0 ]; then
    echo "Usage: $0 <github-username>"
    echo "Example: $0 new-contributor"
    exit 1
fi

CONTRIBUTOR="$1"
CLABOT_FILE=".clabot"

# Check if .clabot file exists
if [ ! -f "$CLABOT_FILE" ]; then
    echo "Error: File $CLABOT_FILE not found"
    exit 1
fi

# Check if jq is installed
if ! command -v jq &> /dev/null; then
    echo "Error: jq is not installed. Install it with: sudo apt-get install jq"
    exit 1
fi

echo "Adding $CONTRIBUTOR to CLA file..."

# Check if contributor already exists
if jq -e --arg user "$CONTRIBUTOR" '.contributors | index($user)' "$CLABOT_FILE" > /dev/null; then
    echo "Contributor $CONTRIBUTOR is already in the CLA list"
    exit 0
fi

# Create backup
cp "$CLABOT_FILE" "${CLABOT_FILE}.backup"

# Add contributor and sort the list
jq --arg user "$CONTRIBUTOR" '.contributors += [$user] | .contributors |= sort' "$CLABOT_FILE" > "${CLABOT_FILE}.tmp"
mv "${CLABOT_FILE}.tmp" "$CLABOT_FILE"

echo "✅ $CONTRIBUTOR successfully added to CLA"

# Show changes
echo "Changes made:"
git diff "$CLABOT_FILE"

# Ask if commit should be made
read -p "Do you want to commit and push these changes? (y/N): " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    git add "$CLABOT_FILE"
    git commit -m "Add $CONTRIBUTOR to CLA contributors"
    
    read -p "Push to remote repository? (y/N): " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        git push
        echo "✅ Changes pushed to repository"
    fi
else
    echo "Changes not committed. You can review and commit manually."
fi
