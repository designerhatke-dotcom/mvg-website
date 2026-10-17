/**
 * MVG POWER SOLUTIONS — PRODUCT DETAIL PAGE SCRIPT
 * Handles image gallery, quantity stepper, real-time price calculations,
 * WhatsApp quote sync, tab switching, and cart operations.
 */
(() => {
  'use strict';

  const els = {
    mainImg: document.getElementById('pdpMainImage'),
    qtyInput: document.getElementById('pdpQtyInput'),
    stickyQtyInput: document.getElementById('pdpStickyQtyInput'),
    breakdownBase: document.getElementById('pdpBreakdownBase'),
    breakdownGst: document.getElementById('pdpBreakdownGst'),
    breakdownTotal: document.getElementById('pdpBreakdownTotal'),
    stickyPrice: document.getElementById('pdpStickyPrice'),
    stickyBar: document.getElementById('pdpStickyBar'),
    whatsAppBtn: document.getElementById('pdpWhatsAppBtn'),
    heroCard: document.querySelector('.pdp-white-card')
  };

  const unitPrice = typeof window.productPrice === 'number' ? window.productPrice : 280;
  const minQty = typeof window.productMinQty === 'number' ? window.productMinQty : 10;
  let currentQty = els.qtyInput ? parseInt(els.qtyInput.value, 10) || minQty : minQty;
  let currentImageIdx = 0;

  /**
   * Currency Formatter (INR with 2 decimals)
   */
  const formatInr = (amount) => {
    return '₹' + Number(amount).toLocaleString('en-IN', {
      minimumFractionDigits: 2,
      maximumFractionDigits: 2
    });
  };

  /**
   * Switch Gallery Image
   */
  const switchImage = (src, btnEl) => {
    if (!els.mainImg) return;
    els.mainImg.style.opacity = '0.35';
    els.mainImg.src = src;
    els.mainImg.onload = () => {
      els.mainImg.style.opacity = '1';
    };

    if (btnEl) {
      document.querySelectorAll('.pdp-thumb-btn').forEach(b => b.classList.remove('active'));
      btnEl.classList.add('active');
    }

    // Sync currentImageIdx
    const imgs = window.productImages || [];
    const foundIdx = imgs.indexOf(src);
    if (foundIdx !== -1) {
      currentImageIdx = foundIdx;
    }
  };

  /**
   * Gallery Previous Image
   */
  const prevImage = () => {
    const imgs = window.productImages || [];
    if (!imgs.length) return;
    currentImageIdx = (currentImageIdx - 1 + imgs.length) % imgs.length;
    const nextSrc = imgs[currentImageIdx];
    const thumbBtns = document.querySelectorAll('.pdp-thumb-btn');
    const targetThumb = thumbBtns[currentImageIdx] || null;
    switchImage(nextSrc, targetThumb);
  };

  /**
   * Gallery Next Image
   */
  const nextImage = () => {
    const imgs = window.productImages || [];
    if (!imgs.length) return;
    currentImageIdx = (currentImageIdx + 1) % imgs.length;
    const nextSrc = imgs[currentImageIdx];
    const thumbBtns = document.querySelectorAll('.pdp-thumb-btn');
    const targetThumb = thumbBtns[currentImageIdx] || null;
    switchImage(nextSrc, targetThumb);
  };

  /**
   * Recalculate and update Base, GST, and Total Price Breakdowns
   */
  const updatePriceBreakdowns = (qty) => {
    const base = unitPrice * qty;
    const gst = base * 0.18;
    const total = base + gst;

    if (els.breakdownBase) els.breakdownBase.textContent = formatInr(base);
    if (els.breakdownGst) els.breakdownGst.textContent = formatInr(gst);
    if (els.breakdownTotal) els.breakdownTotal.textContent = formatInr(total);
    if (els.stickyPrice) els.stickyPrice.textContent = formatInr(base);
  };

  /**
   * Sync Quantity Inputs
   */
  const syncQtyInputs = (qty) => {
    if (els.qtyInput && parseInt(els.qtyInput.value, 10) !== qty) {
      els.qtyInput.value = qty;
    }
    if (els.stickyQtyInput && parseInt(els.stickyQtyInput.value, 10) !== qty) {
      els.stickyQtyInput.value = qty;
    }
  };

  /**
   * Update WhatsApp RFQ Link
   */
  const updateWhatsAppUrl = (qty) => {
    if (!els.whatsAppBtn) return;
    const base = window.mvgWhatsAppBase || els.whatsAppBtn.href.split('?text=')[0] + '?text=';
    const name = window.productName || 'Current Transformer';
    const sku = window.productSku || '';
    const msg = `Hello MVG Power Solutions, I need a quotation for ${name} (SKU: ${sku}, Qty: ${qty} pcs). Please share pricing and dispatch timeline.`;
    els.whatsAppBtn.href = base + encodeURIComponent(msg);
  };

  /**
   * Change Quantity by Delta (+1 or -1)
   */
  const changeQty = (delta) => {
    let next = currentQty + delta;
    if (next < minQty) {
      if (typeof window.showToast === 'function') {
        window.showToast(`Minimum order quantity is ${minQty} Pcs.`);
      }
      next = minQty;
    }
    currentQty = next;
    syncQtyInputs(next);
    updatePriceBreakdowns(next);
    updateWhatsAppUrl(next);
  };

  /**
   * On Manual Quantity Input
   */
  const onQtyInput = (inputEl) => {
    const val = parseInt(inputEl.value, 10);
    if (!isNaN(val) && val >= minQty) {
      currentQty = val;
      syncQtyInputs(val);
      updatePriceBreakdowns(val);
      updateWhatsAppUrl(val);
    }
  };

  /**
   * On Quantity Input Blur (Enforce >= minQty)
   */
  const onQtyBlur = (inputEl) => {
    let val = parseInt(inputEl.value, 10);
    if (isNaN(val) || val < minQty) {
      val = minQty;
      inputEl.value = minQty;
      if (typeof window.showToast === 'function') {
        window.showToast(`Minimum order quantity is ${minQty} Pcs.`);
      }
    }
    currentQty = val;
    syncQtyInputs(val);
    updatePriceBreakdowns(val);
    updateWhatsAppUrl(val);
  };

  /**
   * Switch Tabs
   */
  const switchTab = (tabId, btnEl) => {
    document.querySelectorAll('.pdp-tab-panel').forEach(p => p.classList.remove('active'));
    document.querySelectorAll('.pdp-tab-btn').forEach(b => {
      b.classList.remove('active');
      b.setAttribute('aria-selected', 'false');
    });

    const targetPanel = document.getElementById(tabId);
    if (targetPanel) {
      targetPanel.classList.add('active');
    }

    if (btnEl) {
      btnEl.classList.add('active');
      btnEl.setAttribute('aria-selected', 'true');
    }
  };

  /**
   * Add Product from Product Detail Page to Cart
   */
  const addToCart = (productId) => {
    const qty = currentQty >= minQty ? currentQty : minQty;
    const cart = JSON.parse(localStorage.getItem('mvg_cart') || '{}');
    cart[productId] = (cart[productId] || 0) + qty;
    localStorage.setItem('mvg_cart', JSON.stringify(cart));

    // Update cart badges
    const badges = document.querySelectorAll('.mvg-cart-badge, #cartCountBadge');
    badges.forEach(b => {
      b.textContent = Object.keys(cart).length;
    });

    if (typeof window.showToast === 'function') {
      window.showToast(`Added ${qty} Pcs to your cart!`);
    }

    // Open Cart Drawer
    if (window.MVGHub && typeof window.MVGHub.openCartDrawer === 'function') {
      window.MVGHub.openCartDrawer();
    }
  };

  /**
   * Scroll and switch to Customer Reviews Tab
   */
  const scrollToReviews = () => {
    const btn = document.getElementById('tabBtnReviews');
    if (btn) {
      switchTab('tabReviews', btn);
    }
    const section = document.querySelector('.pdp-tabs-section');
    if (section) {
      section.scrollIntoView({ behavior: 'smooth' });
    }
  };

  /**
   * Toggle Write Review Form Visibility
   */
  const toggleReviewForm = () => {
    const formWrap = document.getElementById('pdpReviewFormWrap');
    if (formWrap) {
      const isHidden = formWrap.style.display === 'none' || !formWrap.style.display;
      formWrap.style.display = isHidden ? 'block' : 'none';
      if (isHidden) {
        formWrap.scrollIntoView({ behavior: 'smooth', block: 'nearest' });
      }
    }
  };

  /**
   * Submit Customer Review
   */
  const submitReview = (e) => {
    e.preventDefault();
    const rating = document.getElementById('reviewRating').value;
    const name = document.getElementById('reviewerName').value.trim();
    const company = document.getElementById('reviewerCompany').value.trim();
    const title = document.getElementById('reviewTitle').value.trim();
    const comment = document.getElementById('reviewComment').value.trim();

    if (!name || !title || !comment) return;

    const stars = '★'.repeat(parseInt(rating, 10)) + '☆'.repeat(5 - parseInt(rating, 10));
    const nameParts = name.split(' ').filter(Boolean);
    const initials = nameParts.length >= 2 
      ? (nameParts[0][0] + nameParts[nameParts.length - 1][0]).toUpperCase() 
      : name.substring(0, 2).toUpperCase();

    const newCard = document.createElement('div');
    newCard.className = 'review-item-card';
    newCard.innerHTML = `
      <div class="review-header">
        <div class="reviewer-meta">
          <div class="reviewer-avatar">${initials}</div>
          <div>
            <div class="reviewer-name-row">
              <strong class="reviewer-name">${name}</strong>
              <span class="verified-buyer-badge">
                <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5"><polyline points="20 6 9 17 4 12"></polyline></svg>
                Verified Buyer
              </span>
            </div>
            <span class="reviewer-role">${company}</span>
          </div>
        </div>
        <div class="review-rating-date">
          <div class="review-stars">${stars}</div>
          <span class="review-date">Just now</span>
        </div>
      </div>
      <h4 class="review-title">${title}</h4>
      <p class="review-body">${comment}</p>
    `;

    const list = document.getElementById('pdpReviewsList');
    if (list) {
      list.prepend(newCard);
    }

    // Reset and hide form
    document.getElementById('pdpReviewForm').reset();
    toggleReviewForm();

    if (typeof window.showToast === 'function') {
      window.showToast('Thank you! Your review has been submitted.');
    }
  };

  // Sticky Bar Scroll Monitor
  const initStickyBar = () => {
    if (!els.stickyBar) return;
    const targetActionRow = document.querySelector('.pdp-action-row-v2');
    if (!targetActionRow) return;

    const checkSticky = () => {
      const rect = targetActionRow.getBoundingClientRect();
      if (rect.bottom < 0) {
        els.stickyBar.classList.add('visible');
      } else {
        els.stickyBar.classList.remove('visible');
      }
    };

    window.addEventListener('scroll', checkSticky, { passive: true });
    checkSticky();
  };

  // Run on DOM ready
  document.addEventListener('DOMContentLoaded', () => {
    updatePriceBreakdowns(currentQty);
    initStickyBar();
  });

  // Expose API to window
  window.MVGProductPage = {
    switchImage,
    prevImage,
    nextImage,
    switchTab,
    changeQty,
    onQtyInput,
    onQtyBlur,
    addToCart,
    scrollToReviews,
    toggleReviewForm,
    submitReview
  };

})();
