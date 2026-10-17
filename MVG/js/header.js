/**
 * MVG Power Solutions — Header & Mega Menu Interactions
 */

document.addEventListener('DOMContentLoaded', () => {
  // Elements
  const mobileToggle = document.getElementById('mvgMobileToggle');
  const drawer = document.getElementById('mvgMobileDrawer');
  const overlay = document.getElementById('mvgDrawerOverlay');
  const drawerClose = document.getElementById('mvgDrawerClose');
  const searchInput = document.getElementById('mvgSearchInput');
  const navItems = document.querySelectorAll('.mvg-nav-item[data-has-mega]');
  const accordionTriggers = document.querySelectorAll('.mvg-accordion-trigger');
  const cartBtn = document.getElementById('mvgCartBtn');

  // 1. Keyboard Shortcut: '/' to focus search input
  window.addEventListener('keydown', (e) => {
    if (e.key === '/' && document.activeElement !== searchInput && !['INPUT', 'TEXTAREA'].includes(document.activeElement.tagName)) {
      e.preventDefault();
      if (searchInput) {
        searchInput.focus();
        searchInput.select();
      }
    }
    // Escape closes drawers and menus
    if (e.key === 'Escape') {
      closeMobileDrawer();
      deactivateAllNavItems();
    }
  });

  // 2. Desktop Mega Menu: Click & Hover Handling with Safe Exit Buffer
  let closeTimeout = null;

  navItems.forEach(item => {
    item.addEventListener('mouseenter', () => {
      clearTimeout(closeTimeout);
      deactivateAllNavItems();
      item.classList.add('is-active');
    });

    item.addEventListener('mouseleave', () => {
      closeTimeout = setTimeout(() => {
        item.classList.remove('is-active');
      }, 150);
    });

    // Support touch or click for laptops with touchscreens
    const link = item.querySelector('.mvg-nav-link');
    if (link) {
      link.addEventListener('click', (e) => {
        // Toggle on click
        const isActive = item.classList.contains('is-active');
        deactivateAllNavItems();
        if (!isActive) {
          item.classList.add('is-active');
        }
      });
    }
  });

  function deactivateAllNavItems() {
    navItems.forEach(i => i.classList.remove('is-active'));
  }

  // Close mega menu when clicking outside
  document.addEventListener('click', (e) => {
    if (!e.target.closest('.mvg-nav-bar')) {
      deactivateAllNavItems();
    }
  });

  // 3. Mobile Drawer Controls
  function openMobileDrawer() {
    if (drawer && overlay) {
      drawer.classList.add('is-open');
      overlay.classList.add('is-open');
      document.body.style.overflow = 'hidden';
    }
  }

  function closeMobileDrawer() {
    if (drawer && overlay) {
      drawer.classList.remove('is-open');
      overlay.classList.remove('is-open');
      document.body.style.overflow = '';
    }
  }

  if (mobileToggle) {
    mobileToggle.addEventListener('click', openMobileDrawer);
  }

  if (drawerClose) {
    drawerClose.addEventListener('click', closeMobileDrawer);
  }

  if (overlay) {
    overlay.addEventListener('click', closeMobileDrawer);
  }

  // 4. Mobile Drawer Accordion
  accordionTriggers.forEach(trigger => {
    trigger.addEventListener('click', () => {
      const currentItem = trigger.closest('.mvg-accordion-item');
      const isOpen = currentItem.classList.contains('is-open');

      // Close other accordion items
      document.querySelectorAll('.mvg-accordion-item').forEach(item => {
        if (item !== currentItem) item.classList.remove('is-open');
      });

      // Toggle clicked item
      currentItem.classList.toggle('is-open', !isOpen);
    });
  });

  // 5. Cart button click feedback
  if (cartBtn) {
    cartBtn.addEventListener('click', () => {
      // Custom event or simple alert for now
      console.log('Cart button clicked');
    });
  }
});
