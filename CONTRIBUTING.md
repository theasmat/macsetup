# Contributing to Mac Developer Setup

Thank you for your interest in contributing to the Mac Developer Setup script! 🎉 We welcome contributions from developers of all skill levels. This guide will help you get started with contributing to the project.

## 🚀 Quick Start for Contributors

### 1. Fork & Clone
```bash
# Fork the repository on GitHub, then clone your fork
git clone https://github.com/YOUR_USERNAME/macsetup.git
cd macsetup

# Add the original repository as upstream
git remote add upstream https://github.com/theasmat/macsetup.git
```

### 2. Create a Branch
```bash
# Create a new branch for your feature/fix
git checkout -b feature/your-feature-name
# or
git checkout -b fix/issue-description
```

### 3. Make Changes
- Edit the relevant files
- Test your changes locally
- Follow our coding standards (see below)

### 4. Test Your Changes
```bash
# Test the script functionality
bash mac-dev-setup.sh

# Test the website locally (if you made web changes)
# Simply open index.html in your browser
```

### 5. Commit & Push
```bash
# Stage your changes
git add .

# Commit with a descriptive message
git commit -m "Add support for XYZ tool installation"

# Push to your fork
git push origin feature/your-feature-name
```

### 6. Create Pull Request
1. Go to the original repository on GitHub
2. Click "New Pull Request"
3. Select your branch
4. Fill out the PR template
5. Submit for review

## 🎯 Types of Contributions We Welcome

### 🛠️ **Easy Contributions (Great for Beginners)**
- **Add new applications**: Add support for installing new development tools
- **Fix typos**: Improve documentation, comments, or messages
- **Update versions**: Keep software versions current
- **Improve messages**: Make user-facing text clearer
- **Add error handling**: Improve robustness of installations

### 🔧 **Medium Contributions**
- **New tool categories**: Add entirely new sections (e.g., Design Tools, DevOps Tools)
- **Platform support**: Add support for different macOS versions
- **Configuration improvements**: Better default settings for tools
- **Performance optimizations**: Speed up installations
- **UI/UX improvements**: Enhance the website experience

### 🏗️ **Advanced Contributions**
- **Architecture improvements**: Refactor script structure
- **New installation methods**: Alternative installation approaches
- **Integration features**: Connect with other developer tools
- **Advanced error recovery**: Sophisticated error handling
- **Testing framework**: Add automated testing

## 📋 Contribution Guidelines

### 🎨 **Script Contributions**

#### Adding New Applications
When adding a new app to install, follow this pattern:

```bash
# In the appropriate category function (install_dev_apps, install_browsers, etc.)
local new_apps=( "existing-app1" "existing-app2" "your-new-app" )
for app in "${new_apps[@]}"; do
    if ask_yes_no "Install App: ${app}?"; then
        if execute "brew install --cask $app" "Installing ${app}..." 3; then
            print_success "Installed ${app}."
            # Add verification if it's a critical tool
            verify_installation "$app" "$app"
        else
            print_warning "Failed to install ${app} after multiple attempts."
        fi
    else 
        print_skip "Skipped ${app}."
    fi
done
```

#### Adding New Categories
To add a completely new category:

1. **Create the function**:
```bash
install_your_category() {
    print_section "🎨 STEP X: YOUR CATEGORY NAME"
    if ! ask_yes_no "Install your category applications?"; then
        print_skip "Skipping all your category installations."
        return
    fi

    local your_apps=( "app1" "app2" "app3" )
    for app in "${your_apps[@]}"; do
        # Installation logic here
    done
}
```

2. **Add to main execution flow**:
```bash
# In the main() function, add your function call
main() {
    # ... existing functions ...
    install_your_category
    # ... rest of functions ...
}
```

3. **Update the website** (`index.html`):
```html
<div class="category">
    <h3>🎨 Your Category</h3>
    <ul>
        <li>App 1</li>
        <li>App 2</li>
        <li>App 3</li>
    </ul>
</div>
```

### 🌐 **Website Contributions**

#### File Structure
```
├── index.html          # Main landing page
├── assets/
│   ├── styles.css      # CSS styling
│   ├── script.js       # JavaScript functionality
│   └── favicon.ico     # Site icon
└── mac-dev-setup.sh    # Main script
```

#### CSS Guidelines
- Use CSS custom properties (variables) defined in `:root`
- Follow mobile-first responsive design
- Maintain accessibility standards
- Use semantic class names

#### JavaScript Guidelines
- Write vanilla JavaScript (no frameworks)
- Add comments for complex logic
- Ensure cross-browser compatibility
- Test on mobile devices

### 📝 **Documentation Contributions**

#### README Updates
- Keep installation instructions clear
- Update feature lists when adding new tools
- Maintain accurate screenshots/examples

#### Code Comments
- Comment complex bash logic
- Explain why certain approaches are used
- Document any platform-specific workarounds

## 🔍 Code Standards

### **Bash Script Standards**
```bash
# Use consistent function naming
install_category_name() {
    # Function description
    
    # Check prerequisites
    if ! command -v brew &>/dev/null; then
        print_warning "Homebrew not found, skipping."
        return
    fi
    
    # Main logic with error handling
    if ask_yes_no "Install category?"; then
        # Installation logic
    else
        print_skip "Skipping category."
    fi
}

# Use consistent variable naming
local variable_name="value"
LOCAL_CONSTANT="VALUE"

# Always use double quotes for variables
echo "Installing ${app_name}..."

# Use arrays for multiple items
local apps=( "app1" "app2" "app3" )
```

### **HTML/CSS Standards**
```html
<!-- Use semantic HTML -->
<section class="meaningful-name">
    <div class="container">
        <h2 class="section-title">Title</h2>
        <!-- Content -->
    </div>
</section>
```

```css
/* Use meaningful class names */
.section-title {
    font-size: 2rem;
    margin-bottom: var(--spacing-lg);
}

/* Mobile-first media queries */
@media (max-width: 768px) {
    .section-title {
        font-size: 1.5rem;
    }
}
```

## 🧪 Testing Your Changes

### **Script Testing**
1. **Test on a clean macOS system** (or VM)
2. **Test individual sections** by modifying the main() function
3. **Test error scenarios** (no internet, canceled installations)
4. **Verify all paths work** for different macOS versions

### **Website Testing**
1. **Test locally** by opening index.html in browsers
2. **Test responsive design** on different screen sizes
3. **Test copy functionality** for installation commands
4. **Validate HTML** using online validators
5. **Check accessibility** with browser dev tools

## 🐛 Reporting Issues

### **Before Reporting**
1. Check if the issue already exists
2. Test with the latest version
3. Try on a clean macOS installation

### **Issue Template**
```markdown
**Bug Description**
A clear description of what the bug is.

**Environment**
- macOS Version: [e.g., macOS 14.0]
- Script Version: [e.g., v5.0]
- Hardware: [e.g., M1 MacBook Pro]

**Steps to Reproduce**
1. Run the script
2. Select option X
3. See error

**Expected Behavior**
What you expected to happen.

**Actual Behavior**
What actually happened.

**Error Messages**
Any error messages you received.

**Additional Context**
Any other relevant information.
```

## 💡 Contribution Ideas

### **Beginner-Friendly Issues**
- Add new applications to existing categories
- Update application versions
- Fix typos in documentation
- Improve error messages
- Add more verification checks

### **Popular Requests**
- **Gaming Tools**: Steam, Discord (gaming setup)
- **Design Tools**: Sketch alternatives, color pickers
- **DevOps Tools**: Terraform, Ansible, cloud CLIs
- **Database Tools**: MongoDB, SQLite browsers
- **Language Support**: Go, Rust, PHP environments
- **Mobile Development**: Xcode tools, Android SDK
- **Productivity**: Note-taking apps, time tracking

### **Technical Improvements**
- Parallel installation support
- Better progress indicators
- Configuration file support
- Backup/restore functionality
- Silent installation mode
- Custom installation profiles

## 🏆 Recognition

### **Hall of Fame**
Contributors will be recognized in:
- README.md contributors section
- Website footer (for significant contributions)
- Release notes for major features

### **Contributor Benefits**
- Direct feedback from maintainers
- Learning bash scripting best practices
- Building your GitHub portfolio
- Helping the developer community

## 📞 Getting Help

### **Discussion Channels**
- **GitHub Issues**: Bug reports and feature requests
- **GitHub Discussions**: Questions and general discussion
- **Pull Request Comments**: Code review and feedback

### **Response Times**
- Issues: Usually within 24-48 hours
- Pull Requests: Usually within 2-3 days
- Discussions: Usually within 24 hours

### **Contact**
- **Maintainer**: [@theasmat](https://github.com/theasmat)
- **Website**: [asmat.dev](https://asmat.dev)
- **Project**: [macsetup.asmat.dev](https://macsetup.asmat.dev)

## 📜 Code of Conduct

### **Our Standards**
- Be respectful and inclusive
- Welcome newcomers
- Focus on constructive feedback
- Help others learn and grow
- Maintain a professional environment

### **Enforcement**
Instances of abusive, harassing, or otherwise unacceptable behavior may be reported to the project maintainers.

---

## 🎉 Thank You!

Every contribution, no matter how small, makes this project better for the entire developer community. Whether you're fixing a typo, adding a new tool, or suggesting improvements, your help is appreciated!

**Happy Contributing! 🚀**

---

*This contributing guide is inspired by the best practices from popular open-source projects and is designed to make contributing as easy as possible for developers of all experience levels.*