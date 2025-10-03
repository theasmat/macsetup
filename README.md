# 🚀 Mac Developer Setup

A professional, interactive, and comprehensive setup script for macOS developers. Install all essential development tools, IDEs, databases, and programming environments with one command.

## ✨ What This Does

Transform your Mac into a fully-configured development machine with:

* **🌐 Web Browsers**: Chrome, Firefox, Brave, Tor
* **💻 IDEs & Editors**: VS Code, iTerm2, Warp Terminal
* **🛠️ Development Tools**: Docker, Postman, ngrok, Sequel Ace
* **🗄️ Databases**: Redis, PostgreSQL
* **🌳 Programming Environments**: Node.js, Python, Java
* **🔧 Utilities**: Raycast, Rectangle, Bitwarden, and more
* **💬 Communication**: Slack, Discord, Zoom
* **🎥 Media & Creative**: VLC, OBS, Figma

## 🎯 Key Features

* **🎯 Interactive**: Choose exactly what you want to install
* **🛡️ Robust**: Intelligent error handling and retry mechanisms
* **� Organized**: Categorized installations for better control
* **⚡ Fast**: Optimized installation process with progress indicators
* **🔧 Pre-configured**: Includes settings for VS Code, Git, SSH

## 🚀 Quick Start

### One-Command Installation

**Primary:**

```bash
curl -fsSL https://macsetup.asmat.dev/mac-dev-setup.sh | bash
```

**Backup (if primary is unavailable):**

```bash
curl -fsSL https://macsetup.netlify.app/mac-dev-setup.sh | bash
```

### Alternative Installation Methods

**Download & Inspect:**

```bash
curl -O https://macsetup.asmat.dev/mac-dev-setup.sh
chmod +x mac-dev-setup.sh
./mac-dev-setup.sh
```

**Git Clone:**

```bash
git clone https://github.com/theasmat/macsetup.git
cd macsetup
./mac-dev-setup.sh
```

## 💻 What Gets Installed

### 🌐 Web Browsers

* Google Chrome (Developer-focused browser)
* Firefox (Privacy-focused alternative)
* Brave (Crypto & privacy browser)
* Tor Browser (Anonymous browsing)

### 💻 Development IDEs & Editors

* Visual Studio Code (Primary code editor with extensions)
* iTerm2 (Feature-rich terminal replacement)
* Warp (Modern, AI-powered terminal)

### 🛠️ Development Tools

* Docker (Containerization platform)
* Postman (API development & testing)
* ngrok (Secure tunneling to localhost)
* Sequel Ace (MySQL/MariaDB client)
* Git (Version control system)
* Homebrew (Package manager for macOS)

### 🗄️ Databases

* Redis (In-memory data structure store)
* PostgreSQL (Advanced open-source database)

### 🌳 Programming Environments

* **Node.js**: Latest LTS version via NVM
* **Python**: System Python with pip
* **Java**: Oracle JDK 25 (Latest version)

### 🔧 Productivity & Utilities

* Raycast (Spotlight replacement)
* Rectangle (Window management)
* Bitwarden (Password manager)
* AppCleaner (Application uninstaller)
* CleanMyMac X (System optimization)

### 💬 Communication

* Slack (Team communication)
* Discord (Gaming & community chat)
* Zoom (Video conferencing)

### 🎥 Media & Creative

* VLC Media Player (Universal media player)
* OBS Studio (Streaming & recording)
* Figma (Design & prototyping)

## ⚙️ Configuration Included

The script automatically configures:

* **Git**: Global user settings and SSH key generation
* **VS Code**: Essential extensions for web development
* **Terminal**: Enhanced shell with better defaults
* **Development Environment**: Path configurations and aliases

## 🛡️ Safety & Security

* **Non-destructive**: Only installs new software, doesn't modify existing
* **Permission-based**: Asks for confirmation before each category
* **Error handling**: Graceful failure recovery with detailed logging
* **Verification**: Confirms successful installation of each tool

## 📊 Platform Support

* **macOS**: 11.0 (Big Sur) and later
* **Architecture**: Intel (x64) and Apple Silicon (M1/M2/M3)
* **Permissions**: Requires admin access for Homebrew installation

## 🤝 Contributing

We welcome contributions! Please see our [Contributing Guidelines](CONTRIBUTING.md) for details.

### Quick Links

* 🐛 [Report Issues](https://github.com/theasmat/macsetup/issues)
* 💡 [Feature Requests](https://github.com/theasmat/macsetup/issues/new?template=feature_request.md)
* 🔧 [Pull Requests](https://github.com/theasmat/macsetup/pulls)

## 📜 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.


---

**🌟 Star this repo if it helped you set up your Mac development environment!**

## 📊 SEO Features

### Technical SEO

* ✅ Semantic HTML5 structure
* ✅ Meta description and keywords
* ✅ Open Graph tags for social sharing
* ✅ Twitter Card tags
* ✅ Structured data (JSON-LD)
* ✅ Mobile-responsive design
* ✅ Fast loading times
* ✅ Accessibility features

### Content SEO

* ✅ Descriptive headings (H1, H2, H3)
* ✅ Alt text for images
* ✅ Internal linking
* ✅ Keyword optimization
* ✅ User-friendly URLs

## 🎨 Customization

### Colors

Update CSS custom properties in `assets/styles.css`:

```css
:root {
    --primary-color: #007bff;    /* Your brand color */
    --primary-dark: #0056b3;     /* Darker variant */
    --accent-color: #28a745;     /* Success/accent color */
}
```

### Fonts

The site uses Inter and JetBrains Mono. To change fonts, update:

```css
:root {
    --font-primary: 'YourFont', sans-serif;
    --font-mono: 'YourMonoFont', monospace;
}
```

### Logo

Replace the emoji logo with your own:

```html
<div class="logo">
    <h1>🚀 Your Brand Name</h1>
    <p>Your Tagline</p>
</div>
```

## 📈 Analytics

### Google Analytics

Add your tracking code before the closing `</head>` tag:

```html
<!-- Google Analytics -->
<script async src="https://www.googletagmanager.com/gtag/js?id=GA_TRACKING_ID"></script>
<script>
    window.dataLayer = window.dataLayer || [];
    function gtag(){dataLayer.push(arguments);}
    gtag('js', new Date());
    gtag('config', 'GA_TRACKING_ID');
</script>
```

### Event Tracking

The JavaScript file includes event tracking for:

* Script downloads
* Command copying
* Button clicks

## 🔒 Security

### HTTPS

Always serve over HTTPS for:

* Security
* Modern browser features (Clipboard API)
* SEO benefits
* User trust

### Content Security Policy

Add CSP headers for enhanced security:

```html
<meta http-equiv="Content-Security-Policy" content="default-src 'self'; style-src 'self' 'unsafe-inline' fonts.googleapis.com; font-src 'self' fonts.gstatic.com; script-src 'self' 'unsafe-inline' www.googletagmanager.com;">
```

## 📱 Mobile Optimization

The site is fully responsive and includes:

* Mobile-first CSS
* Touch-friendly buttons
* Readable font sizes
* Fast loading on mobile
* Progressive Web App ready

## 🚀 Performance

### Optimization Tips


1. **Images**: Add WebP format images for better compression
2. **Minification**: Minify CSS and JavaScript for production
3. **CDN**: Use a CDN for static assets
4. **Caching**: Set proper cache headers
5. **Compression**: Enable gzip/brotli compression

### Performance Checklist

* ✅ Optimized images
* ✅ Minified CSS/JS
* ✅ Fast hosting
* ✅ Mobile optimization
* ✅ Lazy loading ready

## 🎯 Marketing

### Share Features

* Direct installation command
* One-click copy functionality
* Social media optimized
* GitHub integration
* Professional design

### Content Marketing Ideas


1. Blog post about the script
2. Developer community sharing
3. GitHub repository promotion
4. Social media campaigns
5. Developer newsletter features

## 🤝 Contributing


1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test thoroughly
5. Submit a pull request

## 📝 License

This project is open source. Include your preferred license.

## 🤝 Contributing

We welcome contributions from developers of all skill levels! 🎉

### 🚀 Quick Start


1. Fork the repository
2. Create a feature branch: `git checkout -b feature/amazing-feature`
3. Make your changes
4. Test thoroughly
5. Submit a pull request

### 💡 Ways to Contribute

* **🛠️ Add new applications**: Expand our tool collection
* **🐛 Fix bugs**: Help improve reliability
* **📝 Improve documentation**: Make it clearer for everyone
* **🎨 Enhance the website**: Better user experience
* **💬 Share feedback**: Tell us what you think

### 📋 Contribution Guidelines

* Read our [CONTRIBUTING.md](CONTRIBUTING.md) for detailed guidelines
* Use our issue templates for bug reports and feature requests
* Follow the existing code style and patterns
* Test your changes on macOS before submitting

### 🏆 Recognition

Contributors are recognized in our Hall of Fame and project documentation!


---

## 🆘 Support

* 🐛 [Report Issues](https://github.com/theasmat/macsetup/issues)


---

## 🏁 Getting Started


1. Clone this repository
2. Update all URLs and references
3. Customize colors and branding
4. Add your analytics tracking
5. Deploy to your preferred platform
6. Share with the developer community!

**Happy coding! 🚀**