#!/bin/bash
# Update Contributors Badge Count

echo "🔄 Updating contributors badge count..."

# Get actual contributor count from GitHub API
CONTRIBUTOR_COUNT=$(curl -s "https://api.github.com/repos/theasmat/macsetup/contributors" | jq length)

if [ "$CONTRIBUTOR_COUNT" = "null" ] || [ -z "$CONTRIBUTOR_COUNT" ]; then
    echo "⚠️  Could not fetch from GitHub API, using default count of 1"
    CONTRIBUTOR_COUNT=1
fi

echo "👥 Found $CONTRIBUTOR_COUNT contributor(s)"

# Update the badge in README.md
sed -i '' "s/all_contributors-[0-9]\+/all_contributors-$CONTRIBUTOR_COUNT/" README.md

# Update .all-contributorsrc if it exists
if [ -f .all-contributorsrc ]; then
    # This is a more complex JSON update, for now just update the badge
    echo "📝 Updated .all-contributorsrc would need jq for complex update"
fi

echo "✅ Updated contributor badge count to $CONTRIBUTOR_COUNT"
echo "🔍 Verify the badge in README.md shows the correct count"

# Show the current badge line
echo ""
echo "Current badge line:"
grep "all_contributors" README.md