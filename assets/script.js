// Utility functions
function showToast(message, duration = 3000) {
  const toast = document.getElementById("toast");
  const toastMessage = document.getElementById("toastMessage");

  toastMessage.textContent = message;
  toast.classList.add("show");

  setTimeout(() => {
    toast.classList.remove("show");
  }, duration);
}

function copyToClipboard(text) {
  // Use the modern Clipboard API if available
  if (navigator.clipboard && window.isSecureContext) {
    navigator.clipboard
      .writeText(text)
      .then(() => {
        showToast("Copied to clipboard!");
      })
      .catch((err) => {
        console.error("Failed to copy text: ", err);
        fallbackCopyTextToClipboard(text);
      });
  } else {
    // Fallback for older browsers or non-secure contexts
    fallbackCopyTextToClipboard(text);
  }
}

function fallbackCopyTextToClipboard(text) {
  const textArea = document.createElement("textarea");
  textArea.value = text;

  // Avoid scrolling to bottom
  textArea.style.top = "0";
  textArea.style.left = "0";
  textArea.style.position = "fixed";
  textArea.style.opacity = "0";

  document.body.appendChild(textArea);
  textArea.focus();
  textArea.select();

  try {
    const successful = document.execCommand("copy");
    if (successful) {
      showToast("Copied to clipboard!");
    } else {
      showToast("Failed to copy text", 3000);
    }
  } catch (err) {
    console.error("Fallback: Oops, unable to copy", err);
    showToast("Failed to copy text", 3000);
  }

  document.body.removeChild(textArea);
}

// Main command copy function
function copyCommand() {
  const command = document.getElementById("installCommand").textContent;
  copyToClipboard(command);

  // Update button text temporarily
  const copyBtn = document.getElementById("copyBtn");
  const originalText = copyBtn.textContent;
  copyBtn.textContent = "✅ Copied!";

  setTimeout(() => {
    copyBtn.textContent = originalText;
  }, 2000);
}

// Backup command copy function
function copyBackupCommand() {
  const command = document.getElementById("backupInstallCommand").textContent;
  copyToClipboard(command);

  // Update button text temporarily
  const copyBtn = document.getElementById("copyBackupBtn");
  const originalText = copyBtn.textContent;
  copyBtn.textContent = "✅ Copied!";

  setTimeout(() => {
    copyBtn.textContent = originalText;
  }, 2000);
} // Smooth scrolling for navigation links
document.addEventListener("DOMContentLoaded", function () {
  // Handle navigation clicks
  const navLinks = document.querySelectorAll('.nav a, a[href^="#"]');

  navLinks.forEach((link) => {
    link.addEventListener("click", function (e) {
      const href = this.getAttribute("href");

      // Only handle internal links
      if (href.startsWith("#")) {
        e.preventDefault();
        const targetId = href.substring(1);
        const targetElement = document.getElementById(targetId);

        if (targetElement) {
          const headerHeight = document.querySelector(".header").offsetHeight;
          const targetPosition = targetElement.offsetTop - headerHeight - 20;

          window.scrollTo({
            top: targetPosition,
            behavior: "smooth",
          });
        }
      }
    });
  });

  // Add copy functionality to all copy buttons
  const copyButtons = document.querySelectorAll(".code-block .copy-btn");
  copyButtons.forEach((btn) => {
    btn.addEventListener("click", function () {
      const codeBlock = this.parentElement;
      const code = codeBlock.querySelector("code");
      if (code) {
        const text = code.textContent.trim();
        copyToClipboard(text);

        // Update button text temporarily
        const originalText = this.textContent;
        this.textContent = "✅";

        setTimeout(() => {
          this.textContent = originalText;
        }, 2000);
      }
    });
  });

  // Animate elements on scroll
  const observerOptions = {
    threshold: 0.1,
    rootMargin: "0px 0px -50px 0px",
  };

  const observer = new IntersectionObserver((entries) => {
    entries.forEach((entry) => {
      if (entry.isIntersecting) {
        entry.target.style.opacity = "1";
        entry.target.style.transform = "translateY(0)";
      }
    });
  }, observerOptions);

  // Observe feature cards and other animated elements
  const animatedElements = document.querySelectorAll(
    ".feature-card, .method, .category, .support-card"
  );
  animatedElements.forEach((el) => {
    el.style.opacity = "0";
    el.style.transform = "translateY(30px)";
    el.style.transition = "opacity 0.6s ease, transform 0.6s ease";
    observer.observe(el);
  });

  // Add active state to navigation based on scroll position
  const sections = document.querySelectorAll("section[id]");
  const navLinksMap = {};

  // Create a map of nav links
  document.querySelectorAll('.nav a[href^="#"]').forEach((link) => {
    const href = link.getAttribute("href").substring(1);
    navLinksMap[href] = link;
  });

  function updateActiveNav() {
    const scrollPos = window.scrollY + 100;

    sections.forEach((section) => {
      const sectionTop = section.offsetTop;
      const sectionHeight = section.offsetHeight;
      const sectionId = section.getAttribute("id");

      if (scrollPos >= sectionTop && scrollPos < sectionTop + sectionHeight) {
        // Remove active class from all nav links
        Object.values(navLinksMap).forEach((link) => {
          link.classList.remove("active");
        });

        // Add active class to current section's nav link
        if (navLinksMap[sectionId]) {
          navLinksMap[sectionId].classList.add("active");
        }
      }
    });
  }

  // Update active nav on scroll
  window.addEventListener("scroll", updateActiveNav);
  updateActiveNav(); // Initial call

  // Add click tracking for analytics (if needed)
  function trackEvent(eventName, properties = {}) {
    // You can integrate with analytics services like Google Analytics here
    console.log("Event:", eventName, properties);

    // Example for Google Analytics (gtag)
    if (typeof gtag !== "undefined") {
      gtag("event", eventName, properties);
    }
  }

  // Track download button clicks
  document.querySelectorAll("a[download]").forEach((link) => {
    link.addEventListener("click", () => {
      trackEvent("script_download", {
        source: "download_button",
      });
    });
  });

  // Track copy command clicks
  document.getElementById("copyBtn").addEventListener("click", () => {
    trackEvent("command_copy", {
      source: "hero_section",
    });
  });

  // Add keyboard shortcuts
  document.addEventListener("keydown", function (e) {
    // Ctrl/Cmd + K to focus on the install command
    if ((e.ctrlKey || e.metaKey) && e.key === "k") {
      e.preventDefault();
      const installCommand = document.getElementById("installCommand");
      if (installCommand) {
        installCommand.scrollIntoView({ behavior: "smooth" });
        // Select the text
        if (window.getSelection) {
          const selection = window.getSelection();
          const range = document.createRange();
          range.selectNodeContents(installCommand);
          selection.removeAllRanges();
          selection.addRange(range);
        }
      }
    }
  });

  // Add dark mode support (optional)
  function initTheme() {
    const savedTheme = localStorage.getItem("theme");
    const prefersDark = window.matchMedia(
      "(prefers-color-scheme: dark)"
    ).matches;

    if (savedTheme) {
      document.documentElement.setAttribute("data-theme", savedTheme);
    } else if (prefersDark) {
      document.documentElement.setAttribute("data-theme", "dark");
    }
  }

  // Initialize theme (uncomment if you want dark mode support)
  // initTheme();

  // Performance optimization: Lazy load images
  if ("IntersectionObserver" in window) {
    const imageObserver = new IntersectionObserver((entries, observer) => {
      entries.forEach((entry) => {
        if (entry.isIntersecting) {
          const img = entry.target;
          if (img.dataset.src) {
            img.src = img.dataset.src;
            img.classList.remove("lazy");
            imageObserver.unobserve(img);
          }
        }
      });
    });

    document.querySelectorAll("img[data-src]").forEach((img) => {
      imageObserver.observe(img);
    });
  }

  // Add service worker for offline functionality (optional)
  if ("serviceWorker" in navigator) {
    window.addEventListener("load", () => {
      navigator.serviceWorker
        .register("./sw.js")
        .then((registration) => {
          console.log("SW registered: ", registration);
        })
        .catch((registrationError) => {
          console.log("SW registration failed: ", registrationError);
        });
    });
  }
});

// Handle form submissions (if you add contact forms later)
function handleFormSubmit(form) {
  return new Promise((resolve, reject) => {
    const formData = new FormData(form);
    const data = Object.fromEntries(formData.entries());

    // You can integrate with form services like Netlify Forms, Formspree, etc.
    console.log("Form data:", data);

    // Simulate API call
    setTimeout(() => {
      resolve(data);
    }, 1000);
  });
}

// Utility function to format numbers
function formatNumber(num) {
  return new Intl.NumberFormat().format(num);
}

// Add loading states for buttons
function addLoadingState(button) {
  const originalText = button.textContent;
  button.textContent = "Loading...";
  button.disabled = true;

  return function removeLoadingState() {
    button.textContent = originalText;
    button.disabled = false;
  };
}

// Export functions for global use
window.copyCommand = copyCommand;
window.copyBackupCommand = copyBackupCommand;
window.copyToClipboard = copyToClipboard;
window.showToast = showToast;
