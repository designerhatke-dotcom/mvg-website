<?php
/**
 * MVG Power Solutions — Contact Us & Factory Location Hub
 */

require_once __DIR__ . '/config/constants.php';
require_once __DIR__ . '/config/settings.php';

$pageTitle = "Contact MVG Power Solutions | Delhi Factory & Sales Desk";
$pageDesc = "Get in touch with MVG Power Solutions in Mangolpuri, New Delhi. Call +91 99991 76722 or WhatsApp for wholesale current transformer quotations, dealer inquiries, and technical support.";
?>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title><?php echo htmlspecialchars($pageTitle); ?></title>
  <meta name="description" content="<?php echo htmlspecialchars($pageDesc); ?>">
  <link rel="stylesheet" href="css/style.css">
  <style>
    .contact-hero {
      background: linear-gradient(135deg, #0F172A 0%, #1E293B 100%);
      color: #FFFFFF;
      padding: 56px 0 64px 0;
      border-bottom: 1px solid rgba(255, 255, 255, 0.1);
    }
    .contact-layout {
      display: grid;
      grid-template-columns: 420px 1fr;
      gap: 40px;
      padding: 60px 0 90px 0;
    }
    @media (max-width: 900px) {
      .contact-layout {
        grid-template-columns: 1fr;
      }
    }
    .info-card {
      background: #FFFFFF;
      border: 1px solid #E2E8F0;
      border-radius: 16px;
      padding: 32px;
      box-shadow: 0 4px 6px -1px rgba(0,0,0,0.04);
    }
    .contact-detail-row {
      display: flex;
      gap: 16px;
      margin-bottom: 24px;
      align-items: flex-start;
    }
    .contact-icon {
      width: 44px;
      height: 44px;
      border-radius: 10px;
      background: #E0F2FE;
      color: var(--mvg-brand);
      display: flex;
      align-items: center;
      justify-content: center;
      font-size: 20px;
      flex-shrink: 0;
    }
    .form-panel {
      background: #FFFFFF;
      border: 1px solid #E2E8F0;
      border-radius: 16px;
      padding: 36px;
      box-shadow: 0 4px 6px -1px rgba(0,0,0,0.04);
    }
    .form-group {
      margin-bottom: 16px;
    }
    .form-label {
      display: block;
      font-size: 13px;
      font-weight: 700;
      color: #334155;
      margin-bottom: 6px;
    }
    .form-control {
      width: 100%;
      padding: 10px 14px;
      border: 1px solid #CBD5E1;
      border-radius: 8px;
      font-size: 14px;
      box-sizing: border-box;
      outline: none;
    }
    .form-control:focus {
      border-color: var(--mvg-brand);
      box-shadow: 0 0 0 3px rgba(2, 132, 199, 0.15);
    }
    .form-row {
      display: grid;
      grid-template-columns: 1fr 1fr;
      gap: 14px;
    }
    .map-wrap {
      border-radius: 14px;
      overflow: hidden;
      border: 1px solid #E2E8F0;
      margin-top: 24px;
      height: 220px;
    }
  </style>
</head>
<body>

  <header class="mvg-site-header"><?php include __DIR__ . '/includes/header.php'; ?></header>

  <section class="contact-hero">
    <div class="mvg-header-container">
      <nav class="breadcrumb-trail" aria-label="Breadcrumb">
        <a href="index.php">Home</a>
        <span class="sep">›</span>
        <span class="current">Contact Us</span>
      </nav>
      <div style="margin-top: 14px;">
        <span class="collection-hero-badge">📍 CENTRAL LOGISTICS &amp; SALES HUB</span>
        <h1 class="collection-hero-h1">Contact MVG Power Solutions</h1>
        <p class="collection-hero-lead">
          Connect directly with our sales desk, request factory wholesale price lists, or consult our electrical technical team for panel meter and CT sizing.
        </p>
      </div>
    </div>
  </section>

  <main class="mvg-header-container contact-layout">
    
    <!-- Left: Address & Direct Links -->
    <div class="info-card">
      <h2 style="font-size: 20px; font-weight: 900; color: #0F172A; margin-bottom: 20px;">Central Depot &amp; Office</h2>

      <div class="contact-detail-row">
        <div class="contact-icon">📍</div>
        <div>
          <strong style="color: #0F172A; font-size: 14px; display: block; margin-bottom: 4px;">Registered Factory &amp; Depot:</strong>
          <p style="color: #64748B; font-size: 13.5px; margin: 0; line-height: 1.5;">
            <?php echo nl2br(htmlspecialchars(COMPANY_ADDRESS)); ?>
          </p>
        </div>
      </div>

      <div class="contact-detail-row">
        <div class="contact-icon">📞</div>
        <div>
          <strong style="color: #0F172A; font-size: 14px; display: block; margin-bottom: 4px;">Direct Phone Lines:</strong>
          <a href="tel:<?php echo htmlspecialchars(CONTACT_PHONE_TEL); ?>" style="color: var(--mvg-brand); font-weight: 700; text-decoration: none; font-size: 14px; display: block;">
            <?php echo htmlspecialchars(CONTACT_PHONE); ?> (Sales &amp; Dispatch)
          </a>
          <span style="color: #64748B; font-size: 13px;">Mon – Sat: 9:30 AM to 7:30 PM IST</span>
        </div>
      </div>

      <div class="contact-detail-row">
        <div class="contact-icon">💬</div>
        <div>
          <strong style="color: #0F172A; font-size: 14px; display: block; margin-bottom: 4px;">WhatsApp Direct:</strong>
          <a href="https://wa.me/<?php echo htmlspecialchars(WHATSAPP_NUMBER); ?>" target="_blank" rel="noopener" style="color: #10B981; font-weight: 700; text-decoration: none; font-size: 14px;">
            +<?php echo htmlspecialchars(WHATSAPP_NUMBER); ?> (Instant Quotation)
          </a>
        </div>
      </div>

      <div class="contact-detail-row">
        <div class="contact-icon">✉️</div>
        <div>
          <strong style="color: #0F172A; font-size: 14px; display: block; margin-bottom: 4px;">Email Support:</strong>
          <a href="mailto:<?php echo htmlspecialchars(CONTACT_EMAIL); ?>" style="color: var(--mvg-brand); font-weight: 600; text-decoration: none; font-size: 13.5px; display: block;">
            <?php echo htmlspecialchars(CONTACT_EMAIL); ?>
          </a>
        </div>
      </div>

      <!-- Google Map Frame -->
      <div class="map-wrap">
        <iframe 
          title="MVG Power Solutions Location Map"
          src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d13998.601265842887!2d77.0673322!3d28.694668!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x390d03f0b2f5d96b%3A0x63351336d39352e8!2sMangolpuri%2C%20New%20Delhi%2C%20Delhi!5e0!3m2!1sen!2sin!4v1700000000000!5m2!1sen!2sin" 
          width="100%" 
          height="100%" 
          style="border:0;" 
          allowfullscreen="" 
          loading="lazy" 
          referrerpolicy="no-referrer-when-downgrade"
        ></iframe>
      </div>
    </div>

    <!-- Right: Message / RFQ Submission Form -->
    <div class="form-panel">
      <h2 style="font-size: 22px; font-weight: 900; color: #0F172A; margin-bottom: 6px;">Send Message or Inquiry</h2>
      <p style="font-size: 13.5px; color: #64748B; margin-bottom: 24px;">Fill in your details below and a commercial sales engineer will reply within 2 hours.</p>

      <form id="contactForm" onsubmit="handleContact(event)">
        
        <div class="form-row">
          <div class="form-group">
            <label class="form-label" for="cName">Your Name *</label>
            <input type="text" id="cName" class="form-control" placeholder="Full Name" required>
          </div>
          <div class="form-group">
            <label class="form-label" for="cCompany">Company Name</label>
            <input type="text" id="cCompany" class="form-control" placeholder="Company / Enterprise">
          </div>
        </div>

        <div class="form-row">
          <div class="form-group">
            <label class="form-label" for="cPhone">Phone / WhatsApp *</label>
            <input type="tel" id="cPhone" class="form-control" placeholder="+91 98765 43210" required>
          </div>
          <div class="form-group">
            <label class="form-label" for="cEmail">Work Email *</label>
            <input type="email" id="cEmail" class="form-control" placeholder="name@company.com" required>
          </div>
        </div>

        <div class="form-group">
          <label class="form-label" for="cSubject">Inquiry Subject *</label>
          <select id="cSubject" class="form-control">
            <option value="Wholesale Quotation Request">Wholesale Quotation Request</option>
            <option value="Authorized Dealership / Distributorship">Authorized Dealership / Distributorship</option>
            <option value="Custom CT Specification Design">Custom CT Specification Design</option>
            <option value="Dispatched Order Status">Dispatched Order Status</option>
            <option value="Test Certificate Request">Test Certificate Request</option>
          </select>
        </div>

        <div class="form-group">
          <label class="form-label" for="cMessage">Message Details *</label>
          <textarea id="cMessage" class="form-control" rows="4" placeholder="Detail your ratings (e.g. 200/5A, 400/5A), required quantities, or panel builder project requirements..." required></textarea>
        </div>

        <button type="submit" class="btn btn-primary w-full" id="cSubmitBtn" style="padding: 14px; font-weight: 800; border-radius: 8px;">
          Send Commercial Message &rarr;
        </button>

      </form>
    </div>

  </main>

  <?php include __DIR__ . '/includes/footer.php'; ?>

  <script>
    async function handleContact(e) {
      e.preventDefault();
      const btn = document.getElementById('cSubmitBtn');
      btn.disabled = true;
      btn.textContent = 'Sending Message...';

      const payload = {
        name: document.getElementById('cName').value.trim(),
        company: document.getElementById('cCompany').value.trim(),
        phone: document.getElementById('cPhone').value.trim(),
        email: document.getElementById('cEmail').value.trim(),
        subject: document.getElementById('cSubject').value,
        message: document.getElementById('cMessage').value.trim()
      };

      try {
        const res = await fetch('api/submit-contact.php', {
          method: 'POST',
          headers: { 'Content-Type': 'application/json' },
          body: JSON.stringify(payload)
        });
        const data = await res.json();
        if (data.success) {
          alert(data.message || 'Thank you! Your message has been sent successfully.');
          document.getElementById('contactForm').reset();
        } else {
          alert(data.message || 'Unable to send message.');
        }
      } catch (err) {
        alert('Failed to send message. Please call our sales desk directly.');
      } finally {
        btn.disabled = false;
        btn.textContent = 'Send Commercial Message →';
      }
    }
  </script>
</body>
</html>
