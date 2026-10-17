/**
 * MVG POWER SOLUTIONS — CATALOG & CART CONTROLLER
 * Handles interactive product catalog, filters, GST toggle, quick view, and cart drawer.
 */

(function () {
  'use strict';

  // 1. STATE MANAGEMENT
  const state = {
    products: window.MVG_PRODUCTS || [],
    cart: JSON.parse(localStorage.getItem('mvg_cart') || '{}'), // { [productId]: quantity }
    activeCategory: 'all',
    searchQuery: '',
    includeGst: false,
    sort: 'featured',
    cardQty: {} // { [productId]: quantity }
  };

  // Pre-initialize card quantities with minimum order quantity (10)
  state.products.forEach(p => {
    state.cardQty[p.id] = p.minQty || 10;
  });

  const saveCart = () => {
    localStorage.setItem('mvg_cart', JSON.stringify(state.cart));
    updateCartBadge();
  };

  const formatInr = (num) => {
    return '₹' + Math.round(num).toLocaleString('en-IN');
  };

  // DOM Elements
  const els = {
    productGrid: document.getElementById('productGrid'),
    resultsCount: document.getElementById('resultsCount'),
    sectionHeading: document.getElementById('sectionHeading'),
    categoryFilterList: document.getElementById('categoryFilterList'),
    categoryHeroTitle: document.getElementById('categoryHeroTitle'),
    categoryHeroDesc: document.getElementById('categoryHeroDesc'),
    globalSearchInput: document.getElementById('mvgSearchInput'),
    gstToggleCheck: document.getElementById('gstToggleCheck'),
    sortSelect: document.getElementById('sortSelect'),
    activeTagsRow: document.getElementById('activeTagsRow'),
    tagsContainer: document.getElementById('tagsContainer'),
    clearAllFiltersBtn: document.getElementById('clearAllFiltersBtn'),
    
    // Quick View Modal
    productModal: document.getElementById('productModal'),
    modalProductContent: document.getElementById('modalProductContent'),
    modalCloseBtn: document.getElementById('modalCloseBtn'),
    
    // Cart Drawer
    cartDrawer: document.getElementById('cartDrawer'),
    drawerBackdrop: document.getElementById('drawerBackdrop'),
    drawerCloseBtn: document.getElementById('drawerCloseBtn'),
    drawerItemCount: document.getElementById('drawerItemCount'),
    cartItemsList: document.getElementById('cartItemsList'),
    emptyCartView: document.getElementById('emptyCartView'),
    drawerFooter: document.getElementById('drawerFooter'),
    drawerSubtotal: document.getElementById('drawerSubtotal'),
    drawerGstAmount: document.getElementById('drawerGstAmount'),
    drawerGrandTotal: document.getElementById('drawerGrandTotal'),
    whatsAppOrderBtn: document.getElementById('whatsAppOrderBtn'),
    headerCartBtn: document.getElementById('mvgCartBtn'),
    cartBadge: document.querySelector('.mvg-cart-badge'),
    
    // Buyer info
    buyerName: document.getElementById('buyerName'),
    buyerCity: document.getElementById('buyerCity'),
    buyerGst: document.getElementById('buyerGst'),
    
    // Toast Stack
    toastStack: document.getElementById('toastStack')
  };

  // Toast notification
  const showToast = (message, type = 'success') => {
    if (!els.toastStack) return;
    const toast = document.createElement('div');
    toast.className = `mvg-toast ${type}`;
    toast.innerHTML = `<span class="mvg-toast-icon">${type === 'success' ? '✓' : 'ℹ'}</span><span>${message}</span>`;
    els.toastStack.appendChild(toast);

    setTimeout(() => {
      toast.style.opacity = '0';
      toast.style.transform = 'translateY(10px)';
      setTimeout(() => toast.remove(), 250);
    }, 3200);
  };

  // 2. RENDER CATALOG CARDS
  const renderCatalog = () => {
    if (!els.productGrid) return;

    let filtered = state.products.filter(p => {
      // Category filter
      if (state.activeCategory !== 'all' && p.category !== state.activeCategory) {
        return false;
      }
      // Search query
      if (state.searchQuery.trim() !== '') {
        const q = state.searchQuery.toLowerCase();
        const matchesName = p.name.toLowerCase().includes(q);
        const matchesSku = p.sku.toLowerCase().includes(q);
        const matchesCat = p.categoryName.toLowerCase().includes(q);
        if (!matchesName && !matchesSku && !matchesCat) return false;
      }
      return true;
    });

    // Sorting
    if (state.sort === 'price-asc') {
      filtered.sort((a, b) => a.price - b.price);
    } else if (state.sort === 'price-desc') {
      filtered.sort((a, b) => b.price - a.price);
    } else if (state.sort === 'name') {
      filtered.sort((a, b) => a.name.localeCompare(b.name));
    }

    // Results count
    if (els.resultsCount) {
      els.resultsCount.textContent = `Showing ${filtered.length} of ${state.products.length} products`;
    }

    // Update section heading
    if (els.sectionHeading) {
      if (state.activeCategory === 'encapsulated-square-ct') {
        els.sectionHeading.textContent = 'Encapsulated Square CTs';
      } else if (state.activeCategory === 'encapsulated-ring-ct') {
        els.sectionHeading.textContent = 'Encapsulated Ring CTs';
      } else if (state.activeCategory === 'tape-wound-ring-ct') {
        els.sectionHeading.textContent = 'Tape Wound Ring CTs';
      } else if (state.activeCategory === 'resin-cast-rectangular-ct') {
        els.sectionHeading.textContent = 'Resin Cast Rectangular CTs';
      } else if (state.activeCategory === 'resin-cast-ring-ct') {
        els.sectionHeading.textContent = 'Resin Cast Ring CTs';
      } else if (state.activeCategory === 'split-core-ct') {
        els.sectionHeading.textContent = 'Split Core CTs';
      } else {
        els.sectionHeading.textContent = 'Current Transformer Collection';
      }
    }

    // Update active filter tags row
    updateActiveTags();

    // Empty state
    if (filtered.length === 0) {
      let customMsg = 'No standard catalog items found matching your current filter.';
      let customBtnText = 'Reset Filter to All CTs';
      
      const isCustomCat = ['tape-wound-ring-ct', 'resin-cast-rectangular-ct', 'resin-cast-ring-ct', 'split-core-ct'].includes(state.activeCategory);
      if (isCustomCat) {
        customMsg = 'Tape Wound, Resin Cast, and Split Core CTs are custom-engineered to your exact busbar dimensions and ratio requirements (30A–4000A).';
      }

      els.productGrid.innerHTML = `
        <div class="catalog-empty-box">
          <div class="empty-icon-box">⚡</div>
          <h4 class="empty-title">Bespoke &amp; Custom Manufacturing Available</h4>
          <p class="empty-desc">${customMsg}</p>
          <div style="display: flex; gap: 12px; justify-content: center; flex-wrap: wrap;">
            <a href="https://wa.me/917836004040?text=Hello%20MVG,%20I%20need%20a%20custom%20quotation%20for%20Current%20Transformers." target="_blank" rel="noopener" class="btn btn-whatsapp">
              <span>💬 Request Custom Quote on WhatsApp</span>
            </a>
            <button type="button" class="btn btn-outline" id="resetEmptyFilterBtn">Show All 40 Stock CTs</button>
          </div>
        </div>
      `;
      const resetBtn = document.getElementById('resetEmptyFilterBtn');
      if (resetBtn) {
        resetBtn.addEventListener('click', () => {
          setCategory('all');
        });
      }
      return;
    }

    // Render product cards
    els.productGrid.innerHTML = filtered.map(p => {
      const qty = state.cardQty[p.id] || p.minQty || 10;
      const effectiveUnitPrice = state.includeGst ? (p.price * 1.18) : p.price;

      return `
        <article class="product-card" data-product-id="${p.id}">
          
          <!-- Thumbnail with Quick Specs overlay -->
          <div class="product-thumb-wrap" onclick="window.location.href='product.php?id=${p.id}'" title="Click to view full specifications">
            <img src="${p.image}" alt="${p.name}" loading="lazy" />
            <button type="button" class="quick-view-overlay-btn" onclick="event.stopPropagation(); window.MVGHub.openQuickView(${p.id})">Quick Specs</button>
          </div>

          <!-- Clean Category / SKU Meta Tag (No Stock Count, No Ola tags) -->
          <div class="card-meta-row">
            <span class="card-category-tag">${p.categoryName}</span>
            <span class="card-sku-tag">Class 1.0</span>
          </div>

          <!-- Product Title -->
          <h3 class="card-title" title="${p.name}">
            <a href="product.php?id=${p.id}" style="color: inherit; text-decoration: none;">${p.name}</a>
          </h3>

          <!-- Pricing Container -->
          <div class="card-price-container">
            <div class="price-main-row">
              <span class="price-retail-label">Price:</span>
              <span class="price-number">${formatInr(effectiveUnitPrice)}</span>
            </div>
            <div class="card-wholesale-tier-row">
              <span class="tier-label-sm">Min. Qty:</span>
              <span class="tier-price-sm">${p.minQty || 10} Pcs</span>
            </div>
          </div>

          <!-- Actions: Stepper and Add to Cart -->
          <div class="card-actions">
            <div class="qty-stepper">
              <button type="button" class="stepper-btn" onclick="window.MVGHub.updateCardQty(${p.id}, -1)" aria-label="Decrease quantity by 1">−</button>
              <input 
                type="number" 
                class="qty-input" 
                id="qty-input-${p.id}" 
                value="${qty}" 
                min="${p.minQty || 10}" 
                step="1"
                aria-label="Quantity for ${p.name}"
                oninput="window.MVGHub.handleCardQtyInput(${p.id}, this)"
                onblur="window.MVGHub.handleCardQtyBlur(${p.id}, this)"
                onkeydown="if(event.key==='Enter'){this.blur();}"
              />
              <button type="button" class="stepper-btn" onclick="window.MVGHub.updateCardQty(${p.id}, 1)" aria-label="Increase quantity by 1">+</button>
            </div>
            <button type="button" class="btn btn-primary btn-sm" onclick="window.MVGHub.addToCartFromCard(${p.id})">
              Add to Cart
            </button>
          </div>

        </article>
      `;
    }).join('');
  };

  // 3. ACTIVE FILTER TAGS
  const updateActiveTags = () => {
    if (!els.activeTagsRow || !els.tagsContainer) return;
    
    let tags = [];
    if (state.activeCategory !== 'all') {
      const catBtn = document.querySelector(`.cat-btn[data-category="${state.activeCategory}"]`);
      const catLabel = catBtn ? catBtn.querySelector('span:first-child').textContent : state.activeCategory;
      tags.push({ type: 'category', label: `Collection: ${catLabel}` });
    }
    if (state.searchQuery.trim() !== '') {
      tags.push({ type: 'search', label: `Search: "${state.searchQuery}"` });
    }

    if (tags.length === 0) {
      els.activeTagsRow.style.display = 'none';
      els.tagsContainer.innerHTML = '';
    } else {
      els.activeTagsRow.style.display = 'flex';
      els.tagsContainer.innerHTML = tags.map(t => `
        <span class="filter-tag">
          ${t.label}
          <span class="tag-remove" onclick="window.MVGHub.removeTag('${t.type}')">&times;</span>
        </span>
      `).join('');
    }
  };

  // 4. CATEGORY FILTER HANDLER
  const setCategory = (cat) => {
    state.activeCategory = cat;
    
    // Update active class on sidebar buttons
    const catButtons = document.querySelectorAll('.cat-btn');
    catButtons.forEach(btn => {
      if (btn.getAttribute('data-category') === cat) {
        btn.classList.add('active');
      } else {
        btn.classList.remove('active');
      }
    });

    renderCatalog();
    window.scrollTo({ top: 300, behavior: 'smooth' });
  };

  // 5. QUANTITY STEPPERS & INPUT HANDLERS
  const updateCardQty = (productId, delta) => {
    const p = state.products.find(item => item.id === productId);
    const min = (p && p.minQty) ? p.minQty : 10;
    const current = parseInt(state.cardQty[productId], 10) || min;
    const next = current + delta;

    if (next < min) {
      showToast(`Minimum order quantity for this item is ${min} Pcs.`);
      state.cardQty[productId] = min;
    } else {
      state.cardQty[productId] = next;
    }

    const input = document.getElementById(`qty-input-${productId}`);
    if (input) {
      input.value = state.cardQty[productId];
    }
  };

  const handleCardQtyInput = (productId, inputEl) => {
    const p = state.products.find(item => item.id === productId);
    const min = (p && p.minQty) ? p.minQty : 10;
    const val = parseInt(inputEl.value, 10);
    if (!isNaN(val) && val >= min) {
      state.cardQty[productId] = val;
    }
  };

  const handleCardQtyBlur = (productId, inputEl) => {
    const p = state.products.find(item => item.id === productId);
    const min = (p && p.minQty) ? p.minQty : 10;
    let val = parseInt(inputEl.value, 10);
    if (isNaN(val) || val < min) {
      val = min;
      inputEl.value = min;
      showToast(`Minimum quantity is ${min} Pcs.`);
    }
    state.cardQty[productId] = val;
  };

  // 6. CART MANAGEMENT
  const addToCartFromCard = (productId) => {
    const p = state.products.find(item => item.id === productId);
    if (!p) return;
    const min = p.minQty || 10;
    let qty = parseInt(state.cardQty[productId], 10) || min;
    if (qty < min) {
      qty = min;
      state.cardQty[productId] = min;
    }
    
    state.cart[productId] = (state.cart[productId] || 0) + qty;
    saveCart();
    showToast(`Added ${qty} pcs of "${p.name.slice(0, 32)}..." to cart!`);
    openCartDrawer();
  };

  const updateCartDrawerQty = (productId, delta) => {
    const p = state.products.find(item => item.id == productId);
    const min = (p && p.minQty) ? p.minQty : 10;
    const current = parseInt(state.cart[productId], 10) || min;
    const next = current + delta;

    if (next < min) {
      showToast(`Minimum order quantity is ${min} Pcs. Click "Remove" to delete this item.`);
      return;
    }

    state.cart[productId] = next;
    saveCart();

    const input = document.getElementById(`cart-qty-input-${productId}`);
    if (input) {
      input.value = next;
    }
    updateCartSummaryTotals(productId);
  };

  const handleCartQtyInput = (productId, inputEl) => {
    const p = state.products.find(item => item.id == productId);
    const min = (p && p.minQty) ? p.minQty : 10;
    const val = parseInt(inputEl.value, 10);
    if (!isNaN(val) && val >= min) {
      state.cart[productId] = val;
      saveCart();
      updateCartSummaryTotals(productId);
    }
  };

  const handleCartQtyBlur = (productId, inputEl) => {
    const p = state.products.find(item => item.id == productId);
    const min = (p && p.minQty) ? p.minQty : 10;
    let val = parseInt(inputEl.value, 10);
    if (isNaN(val) || val < min) {
      val = min;
      inputEl.value = min;
      showToast(`Minimum quantity for ${p ? p.name.slice(0, 24) + '...' : 'this item'} is ${min} Pcs.`);
    }
    state.cart[productId] = val;
    saveCart();
    updateCartSummaryTotals(productId);
  };

  const updateCartSummaryTotals = (changedProductId) => {
    if (changedProductId) {
      const p = state.products.find(item => item.id == changedProductId);
      const subEl = document.getElementById(`cart-item-subtotal-${changedProductId}`);
      if (p && subEl) {
        const qty = state.cart[changedProductId] || 0;
        subEl.textContent = formatInr(p.price * qty);
      }
    }

    let subtotal = 0;
    const pIds = Object.keys(state.cart);
    pIds.forEach(id => {
      const prod = state.products.find(item => item.id == id);
      if (prod) {
        subtotal += prod.price * (state.cart[id] || 0);
      }
    });

    const gstAmount = subtotal * 0.18;
    const grandTotal = subtotal + gstAmount;

    if (els.drawerSubtotal) els.drawerSubtotal.textContent = formatInr(subtotal);
    if (els.drawerGstAmount) els.drawerGstAmount.textContent = formatInr(gstAmount);
    if (els.drawerGrandTotal) els.drawerGrandTotal.textContent = formatInr(grandTotal);
    if (els.drawerItemCount) {
      els.drawerItemCount.textContent = `${pIds.length} ${pIds.length === 1 ? 'item' : 'items'}`;
    }
    updateCartBadge();
  };

  const removeCartItem = (productId) => {
    delete state.cart[productId];
    saveCart();
    renderCartDrawer();
    showToast('Item removed from cart.');
  };

  const updateCartBadge = () => {
    const totalItems = Object.keys(state.cart).length;
    const badges = document.querySelectorAll('.mvg-cart-badge, #cartCountBadge');
    badges.forEach(b => {
      b.textContent = totalItems;
    });
  };

  const renderCartDrawer = () => {
    const pIds = Object.keys(state.cart);
    const count = pIds.length;

    if (els.drawerItemCount) {
      els.drawerItemCount.textContent = `${count} ${count === 1 ? 'item' : 'items'}`;
    }

    if (count === 0) {
      if (els.emptyCartView) els.emptyCartView.style.display = 'block';
      if (els.cartItemsList) els.cartItemsList.style.display = 'none';
      if (els.drawerFooter) els.drawerFooter.style.display = 'none';
      return;
    }

    if (els.emptyCartView) els.emptyCartView.style.display = 'none';
    if (els.cartItemsList) els.cartItemsList.style.display = 'flex';
    if (els.drawerFooter) els.drawerFooter.style.display = 'block';

    let subtotal = 0;

    els.cartItemsList.innerHTML = pIds.map(id => {
      const p = state.products.find(item => item.id == id);
      if (!p) return '';
      const qty = state.cart[id];
      const itemSubtotal = p.price * qty;
      subtotal += itemSubtotal;

      return `
        <div class="cart-item-row">
          <img src="${p.image}" alt="${p.name}" class="cart-item-img" />
          <div class="cart-item-info">
            <span class="cart-item-name">${p.name}</span>
            <span class="cart-item-sku">SKU: ${p.sku || 'MVG-CT'} • ${formatInr(p.price)}/pc</span>
            <span class="cart-item-tier-chip">Min. Qty: ${p.minQty} Pcs</span>
          </div>
          <div class="cart-item-right">
            <span class="cart-item-subtotal" id="cart-item-subtotal-${p.id}">${formatInr(itemSubtotal)}</span>
            <div class="cart-item-controls">
              <button type="button" class="cart-item-btn" onclick="window.MVGHub.updateCartDrawerQty(${p.id}, -1)" aria-label="Decrease quantity by 1">−</button>
              <input 
                type="number" 
                class="cart-item-qty-input" 
                id="cart-qty-input-${p.id}"
                value="${qty}" 
                min="${p.minQty || 10}" 
                step="1"
                aria-label="Quantity for ${p.name}"
                oninput="window.MVGHub.handleCartQtyInput(${p.id}, this)"
                onblur="window.MVGHub.handleCartQtyBlur(${p.id}, this)"
                onkeydown="if(event.key==='Enter'){this.blur();}"
              />
              <button type="button" class="cart-item-btn" onclick="window.MVGHub.updateCartDrawerQty(${p.id}, 1)" aria-label="Increase quantity by 1">+</button>
            </div>
            <span class="cart-item-remove" onclick="window.MVGHub.removeCartItem(${p.id})">Remove</span>
          </div>
        </div>
      `;
    }).join('');

    const gstAmount = subtotal * 0.18;
    const grandTotal = subtotal + gstAmount;

    if (els.drawerSubtotal) els.drawerSubtotal.textContent = formatInr(subtotal);
    if (els.drawerGstAmount) els.drawerGstAmount.textContent = formatInr(gstAmount);
    if (els.drawerGrandTotal) els.drawerGrandTotal.textContent = formatInr(grandTotal);
  };

  const openCartDrawer = () => {
    renderCartDrawer();
    if (els.cartDrawer) els.cartDrawer.classList.add('open');
    if (els.drawerBackdrop) els.drawerBackdrop.hidden = false;
    document.body.style.overflow = 'hidden';
  };

  const closeCartDrawer = () => {
    if (els.cartDrawer) els.cartDrawer.classList.remove('open');
    if (els.drawerBackdrop) els.drawerBackdrop.hidden = true;
    document.body.style.overflow = '';
  };

  // 7. WHATSAPP PROFORMA INQUIRY
  const sendWhatsAppOrder = () => {
    const pIds = Object.keys(state.cart);
    if (pIds.length === 0) {
      showToast('Your cart is empty!', 'info');
      return;
    }

    const name = els.buyerName ? els.buyerName.value.trim() : '';
    const city = els.buyerCity ? els.buyerCity.value.trim() : '';
    const gst = els.buyerGst ? els.buyerGst.value.trim() : '';

    let text = `⚡ *MVG POWER SOLUTIONS — B2B ORDER INQUIRY*\n`;
    text += `━━━━━━━━━━━━━━━━━━━━━━━━━━\n`;
    if (name) text += `*Buyer / Firm:* ${name}\n`;
    if (city) text += `*Location:* ${city}\n`;
    if (gst) text += `*GSTIN:* ${gst}\n`;
    text += `\n*ORDER LINE ITEMS:*\n`;

    let subtotal = 0;
    pIds.forEach((id, index) => {
      const p = state.products.find(item => item.id == id);
      if (!p) return;
      const qty = state.cart[id];
      const itemTotal = p.price * qty;
      subtotal += itemTotal;
      text += `${index + 1}. *${p.name}*\n   Qty: ${qty} Pcs @ ${formatInr(p.price)}/pc = ${formatInr(itemTotal)}\n`;
    });

    const gstAmount = subtotal * 0.18;
    const grandTotal = subtotal + gstAmount;

    text += `\n━━━━━━━━━━━━━━━━━━━━━━━━━━\n`;
    text += `*Subtotal (Excl. Tax):* ${formatInr(subtotal)}\n`;
    text += `*GST (18% ITC Tax):* ${formatInr(gstAmount)}\n`;
    text += `*Estimated Grand Total:* ${formatInr(grandTotal)}\n`;
    text += `━━━━━━━━━━━━━━━━━━━━━━━━━━\n`;
    text += `Please send proforma tax invoice and delivery lead time for Delhi NCR / Pan-India dispatch.`;

    const encoded = encodeURIComponent(text);
    window.open(`https://wa.me/917836004040?text=${encoded}`, '_blank');
  };

  // 8. QUICK SPECS MODAL
  const openQuickView = (productId) => {
    const p = state.products.find(item => item.id == productId);
    if (!p || !els.productModal || !els.modalProductContent) return;

    const specsHtml = Object.entries(p.specs).map(([key, val]) => `
      <tr>
        <td>${key}</td>
        <td><strong>${val}</strong></td>
      </tr>
    `).join('');

    const effectivePrice = state.includeGst ? (p.price * 1.18) : p.price;

    els.modalProductContent.innerHTML = `
      <div class="quickview-grid">
        <div class="quickview-media-box">
          <img src="${p.image}" alt="${p.name}" />
        </div>
        <div class="quickview-info">
          <span class="card-category-tag" style="margin-bottom: 8px; display: inline-block;">${p.categoryName}</span>
          <h3>${p.name}</h3>
          
          <div class="quickview-price-box">
            <span class="price-retail-label">Price:</span>
            <span class="price-number" style="font-size: 24px; color: var(--mvg-brand); font-weight: 800;">${formatInr(effectivePrice)}</span>
            <span style="font-size: 12px; color: var(--mvg-slate-500); margin-left: 8px;">(${state.includeGst ? 'Incl. 18% GST' : 'Excl. GST'})</span>
          </div>

          <div style="margin: 16px 0;">
            <h4 style="font-size: 13px; font-weight: 700; text-transform: uppercase; letter-spacing: 0.05em; color: var(--mvg-slate-600); margin-bottom: 8px;">Technical Specifications</h4>
            <table class="quickview-spec-table">
              <tbody>
                ${specsHtml}
                <tr>
                  <td>Minimum Order Quantity</td>
                  <td><strong style="color: var(--mvg-brand);">${p.minQty || 10} Units</strong></td>
                </tr>
              </tbody>
            </table>
          </div>

          <div style="display: flex; gap: 10px; align-items: center; margin-top: 20px; flex-wrap: wrap;">
            <button type="button" class="btn btn-primary" style="flex: 1.5 1 180px;" onclick="window.MVGHub.addToCartFromCard(${p.id}); window.MVGHub.closeQuickView();">
              Add Minimum (${p.minQty || 10} Pcs) to Cart
            </button>
            <a href="product.php?id=${p.id}" class="btn btn-outline" style="border-color: #052C6E; color: #052C6E; padding: 10px 14px;">
              Full Details &rarr;
            </a>
            <a href="https://wa.me/917836004040?text=${encodeURIComponent('Hello MVG Power Solutions, I need a quotation for ' + p.name + ' (SKU: ' + p.sku + ')')}" target="_blank" rel="noopener" class="btn btn-whatsapp" style="padding: 10px 14px;">
              💬 Inquire
            </a>
          </div>
        </div>
      </div>
    `;

    els.productModal.hidden = false;
    document.body.style.overflow = 'hidden';
  };

  const closeQuickView = () => {
    if (els.productModal) els.productModal.hidden = true;
    document.body.style.overflow = '';
  };

  // 9. EVENT BINDINGS & INIT
  const bindEvents = () => {
    // Category filter button clicks
    const catButtons = document.querySelectorAll('.cat-btn');
    catButtons.forEach(btn => {
      btn.addEventListener('click', () => {
        const cat = btn.getAttribute('data-category');
        setCategory(cat);
      });
    });

    // GST Toggle
    if (els.gstToggleCheck) {
      els.gstToggleCheck.addEventListener('change', (e) => {
        state.includeGst = e.target.checked;
        renderCatalog();
        if (els.cartDrawer && els.cartDrawer.classList.contains('open')) {
          renderCartDrawer();
        }
      });
    }

    // Sort Dropdown
    if (els.sortSelect) {
      els.sortSelect.addEventListener('change', (e) => {
        state.sort = e.target.value;
        renderCatalog();
      });
    }

    // Search Input
    if (els.globalSearchInput) {
      els.globalSearchInput.addEventListener('input', (e) => {
        state.searchQuery = e.target.value;
        renderCatalog();
      });
    }

    // Clear filters button
    if (els.clearAllFiltersBtn) {
      els.clearAllFiltersBtn.addEventListener('click', () => {
        state.activeCategory = 'all';
        state.searchQuery = '';
        if (els.globalSearchInput) els.globalSearchInput.value = '';
        setCategory('all');
      });
    }

    // Cart Drawer triggers
    if (els.headerCartBtn) {
      els.headerCartBtn.addEventListener('click', openCartDrawer);
    }
    if (els.drawerCloseBtn) {
      els.drawerCloseBtn.addEventListener('click', closeCartDrawer);
    }
    if (els.drawerBackdrop) {
      els.drawerBackdrop.addEventListener('click', closeCartDrawer);
    }
    if (els.whatsAppOrderBtn) {
      els.whatsAppOrderBtn.addEventListener('click', sendWhatsAppOrder);
    }

    // Modal Close
    if (els.modalCloseBtn) {
      els.modalCloseBtn.addEventListener('click', closeQuickView);
    }
    if (els.productModal) {
      els.productModal.addEventListener('click', (e) => {
        if (e.target === els.productModal) closeQuickView();
      });
    }

    // Close with Esc key
    window.addEventListener('keydown', (e) => {
      if (e.key === 'Escape') {
        closeQuickView();
        closeCartDrawer();
      }
    });

    // URL parameter parsing (e.g. ?slug=encapsulated-square-ct, ?collection=..., ?category=...)
    const urlParams = new URLSearchParams(window.location.search);
    const catParam = urlParams.get('slug') || urlParams.get('collection') || urlParams.get('category');
    if (catParam) {
      setCategory(catParam);
    } else {
      renderCatalog();
    }

    updateCartBadge();
  };

  // 10. PUBLIC API (Attached to window.MVGHub)
  window.MVGHub = {
    setCategory,
    updateCardQty,
    handleCardQtyInput,
    handleCardQtyBlur,
    addToCartFromCard,
    updateCartDrawerQty,
    handleCartQtyInput,
    handleCartQtyBlur,
    updateCartSummaryTotals,
    removeCartItem,
    openCartDrawer,
    closeCartDrawer,
    openQuickView,
    closeQuickView,
    sendWhatsAppOrder,
    removeTag: (type) => {
      if (type === 'category') setCategory('all');
      if (type === 'search') {
        state.searchQuery = '';
        if (els.globalSearchInput) els.globalSearchInput.value = '';
        renderCatalog();
      }
    }
  };

  // Auto initialize on DOM ready
  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', bindEvents);
  } else {
    bindEvents();
  }

})();
