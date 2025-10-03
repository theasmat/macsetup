#!/bin/bash
# Initialize Contributors Recognition System

echo "🚀 Setting up automated contributor recognition..."

# Create .all-contributorsrc configuration
cat > .all-contributorsrc << 'EOF'
{
  "projectName": "Mac Developer Setup",
  "projectOwner": "theasmat",
  "repoType": "github",
  "repoHost": "https://github.com",
  "files": [
    "README.md"
  ],
  "imageSize": 100,
  "contributorsPerLine": 7,
  "commitConvention": "none",
  "contributors": [],
  "contributorsSortAlphabetically": false,
  "badgeTemplate": "[![All Contributors](https://img.shields.io/badge/all_contributors-<%= contributors.length %>-orange.svg?style=flat-square)](#contributors)",
  "contributorTemplate": "<%= contributor.login %>",
  "linkToUsage": false
}
EOF

echo "✅ Created .all-contributorsrc configuration"

# Add contributors badge to README if not present
if ! grep -q "all_contributors" README.md; then
    echo "📝 Adding contributors badge to README..."
    # Find the line with badges and add the contributors badge
    if grep -q "![License]" README.md; then
        sed -i '' '/!\[License\]/a\
[![All Contributors](https://img.shields.io/badge/all_contributors-1-orange.svg?style=flat-square)](#contributors)
' README.md
    else
        # Add after the title
        sed -i '' '2a\
\
[![All Contributors](https://img.shields.io/badge/all_contributors-1-orange.svg?style=flat-square)](#contributors)\
' README.md
    fi
fi

# Add contributors section to README if not present
if ! grep -q "## Contributors" README.md; then
    echo "📝 Adding contributors section to README..."
    cat >> README.md << 'EOF'

## Contributors

Thanks goes to these wonderful people ([emoji key](https://allcontributors.org/docs/en/emoji-key)):

<!-- ALL-CONTRIBUTORS-LIST:START - Do not remove or modify this section -->
<!-- prettier-ignore-start -->
<!-- markdownlint-disable -->
<table>
  <tr>
    <td align="center"><a href="https://github.com/theasmat"><img src="https://avatars.githubusercontent.com/u/theasmat?v=4?s=100" width="100px;" alt=""/><br /><sub><b>theasmat</b></sub></a><br /><a href="https://github.com/theasmat/macsetup/commits?author=theasmat" title="Code">💻</a> <a href="https://github.com/theasmat/macsetup/commits?author=theasmat" title="Documentation">📖</a></td>
  </tr>
</table>

<!-- markdownlint-restore -->
<!-- prettier-ignore-end -->

<!-- ALL-CONTRIBUTORS-LIST:END -->

This project follows the [all-contributors](https://github.com/all-contributors/all-contributors) specification. Contributions of any kind welcome!
EOF
fi

echo "✅ Set up automated contributor recognition!"
echo ""
echo "🎯 What happens now:"
echo "  • When PRs are merged, contributors are automatically welcomed"
echo "  • Contributors list updates automatically via GitHub Actions"
echo "  • First-time contributors get special recognition"
echo "  • Weekly contributor stats are updated"
echo ""
echo "🔧 Manual commands (if needed):"
echo "  • npm install -g all-contributors-cli"
echo "  • npx all-contributors add <username> <contribution-type>"
echo "  • npx all-contributors generate"
echo ""
echo "🌟 The system is ready! Contributors will be recognized automatically."