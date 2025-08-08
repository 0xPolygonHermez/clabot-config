#!/bin/bash

# Script to generate pending CLA notifications
# Can be run as a cron job to check pending PRs

set -e

# Configuration
REPO_OWNER="0xPolygonHermez"
REPO_NAME="clabot-config"
GITHUB_TOKEN="${GITHUB_TOKEN:-}"

if [ -z "$GITHUB_TOKEN" ]; then
    echo "Error: GITHUB_TOKEN environment variable not set"
    exit 1
fi

echo "🔍 Checking for PRs with pending CLA signatures..."

# Get open PRs with 'cla-required' label
PENDING_PRS=$(curl -s -H "Authorization: token $GITHUB_TOKEN" \
    "https://api.github.com/repos/$REPO_OWNER/$REPO_NAME/issues?labels=cla-required&state=open" | \
    jq -r '.[] | select(.pull_request != null) | "\(.number)|\(.user.login)|\(.title)"')

if [ -z "$PENDING_PRS" ]; then
    echo "✅ No PRs with pending CLA signatures found"
    exit 0
fi

echo "📋 Found PRs with pending CLA signatures:"
echo "========================================"

# Generate report
REPORT_FILE="cla_pending_report_$(date +%Y%m%d_%H%M%S).txt"
echo "CLA Pending Signatures Report - $(date)" > "$REPORT_FILE"
echo "========================================" >> "$REPORT_FILE"
echo "" >> "$REPORT_FILE"

while IFS='|' read -r pr_number username title; do
    echo "PR #$pr_number by @$username: $title"
    echo "PR #$pr_number by @$username: $title" >> "$REPORT_FILE"
    
    # Check when was the last CLA comment
    LAST_COMMENT=$(curl -s -H "Authorization: token $GITHUB_TOKEN" \
        "https://api.github.com/repos/$REPO_OWNER/$REPO_NAME/issues/$pr_number/comments" | \
        jq -r '.[] | select(.body | contains("CLA")) | .created_at' | tail -1)
    
    if [ -n "$LAST_COMMENT" ]; then
        echo "  Last CLA reminder: $LAST_COMMENT"
        echo "  Last CLA reminder: $LAST_COMMENT" >> "$REPORT_FILE"
    fi
    echo "" >> "$REPORT_FILE"
done <<< "$PENDING_PRS"

echo ""
echo "📄 Report saved to: $REPORT_FILE"

# Optional: Send email notification if configured
if command -v mail &> /dev/null && [ -n "$NOTIFICATION_EMAIL" ]; then
    echo "📧 Sending email notification..."
    mail -s "CLA Pending Signatures Report" "$NOTIFICATION_EMAIL" < "$REPORT_FILE"
    echo "✅ Email sent to $NOTIFICATION_EMAIL"
fi
