<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.tactic.Event, java.util.List" %>
<%
    List<Event> events = (List<Event>) request.getAttribute("events");
    String userName = (String) request.getAttribute("userName");

    java.util.Map<String, String> typeEmoji = new java.util.HashMap<>();
    typeEmoji.put("birthday", "🎂");
    typeEmoji.put("wedding", "💍");
    typeEmoji.put("house_party", "🎉");
    typeEmoji.put("conference", "🤝");
    typeEmoji.put("corporate", "💼");
    typeEmoji.put("social_gathering", "🎶");
    typeEmoji.put("other", "✨");
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Tactic — Dashboard</title>
  <link href="https://fonts.googleapis.com/css2?family=Poppins:ital,wght@0,300;0,400;0,600;0,700;1,400&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="/css/home.css">
</head>
<body>

  <!-- NAV -->
  <nav>
    <div class="nav-inner">
      <div class="logo">Tac<span>tic</span></div>
      <div class="nav-links">
        <a href="#events" class="nav-link">My Events</a>
        <a href="/profile.html" class="nav-link">My Profile</a>
        <a href="/logout" class="nav-logout">Logout</a>
      </div>
    </div>
  </nav>

  <main>

    <!-- HERO GREETING -->
    <section class="greeting">
      <div class="greeting-inner">
        <div>
          <p class="greeting-eyebrow">✦ Welcome back<% if (userName != null) { %>, <%= userName.split(" ")[0] %><% } %></p>
          <h1>What are we<br><span>planning today?</span></h1>
        </div>
      </div>
    </section>

    <!-- MY EVENTS -->
    <section class="section" id="events">
      <div class="section-inner">
        <div class="section-header">
          <div>
            <p class="section-label">✦ My events</p>
            <h2>Your upcoming moments</h2>
          </div>
        </div>
        <div class="events-grid">
          <!-- Create new event card -->
          <a href="/create-event.html" class="event-card new-event">
            <div class="plus-icon">+</div>
            <p>Plan a new event</p>
          </a>
          <!-- User events -->
          <% for (Event event : events) { %>
          <a href="/event/detail?id=<%= event.getEventId() %>" class="event-card">
            <div class="event-card-icon"><%= typeEmoji.getOrDefault(event.getEventType(), "✨") %></div>
            <div class="event-card-content">
              <h3><%= event.getEventName() %></h3>
              <p class="event-card-date">📅 <%= event.getEventDate() %></p>
            </div>
          </a>
          <% } %>
        </div>
      </div>
    </section>

    <!-- VENUES -->
    <section class="section" id="venues">
      <div class="section-inner">
        <div class="section-header">
          <div>
            <p class="section-label">✦ Venues</p>
            <h2>Find your perfect space</h2>
          </div>
          <a href="/vendors?category=venue" class="view-all">View all →</a>
        </div>
        <div class="vendor-grid">
          <div class="vendor-card">
            <div class="vendor-img" style="background: linear-gradient(135deg, #3b1f6e, #7c3aed);">🏛️</div>
            <div class="vendor-info">
              <div class="vendor-meta"><span class="vendor-cat">Venue</span><span class="vendor-rating">★ 4.9</span></div>
              <h3>Coco Lawns</h3>
              <p class="vendor-location">📍 Miramar, Goa</p>
              <p class="vendor-price">From ₹50,000</p>
            </div>
          </div>
          <div class="vendor-card">
            <div class="vendor-img" style="background: linear-gradient(135deg, #1a2a5c, #3b5bdb);">🏖️</div>
            <div class="vendor-info">
              <div class="vendor-meta"><span class="vendor-cat">Venue</span><span class="vendor-rating">★ 4.8</span></div>
              <h3>Caravela Beach Resort</h3>
              <p class="vendor-location">📍 Varca, Goa</p>
              <p class="vendor-price">From ₹1,50,000</p>
            </div>
          </div>
          <div class="vendor-card">
            <div class="vendor-img" style="background: linear-gradient(135deg, #1a3d2b, #16a34a);">🌿</div>
            <div class="vendor-info">
              <div class="vendor-meta"><span class="vendor-cat">Venue</span><span class="vendor-rating">★ 4.9</span></div>
              <h3>Taj Holiday Village</h3>
              <p class="vendor-location">📍 Candolim, Goa</p>
              <p class="vendor-price">From ₹2,00,000</p>
            </div>
          </div>
          <div class="vendor-card">
            <div class="vendor-img" style="background: linear-gradient(135deg, #3d1a1a, #dc2626);">🏰</div>
            <div class="vendor-info">
              <div class="vendor-meta"><span class="vendor-cat">Venue</span><span class="vendor-rating">★ 5.0</span></div>
              <h3>Taj Cidade de Goa</h3>
              <p class="vendor-location">📍 Panaji, Goa</p>
              <p class="vendor-price">From ₹2,50,000</p>
            </div>
          </div>
        </div>
      </div>
    </section>

    <!-- FOOD & CATERING -->
    <section class="section alt" id="food">
      <div class="section-inner">
        <div class="section-header">
          <div>
            <p class="section-label">✦ Food & catering</p>
            <h2>Feed your guests well</h2>
          </div>
          <a href="/vendors?category=caterer" class="view-all">View all →</a>
        </div>
        <div class="vendor-grid">
          <div class="vendor-card">
            <div class="vendor-img" style="background: linear-gradient(135deg, #2d1a0e, #c2410c);">🍛</div>
            <div class="vendor-info">
              <div class="vendor-meta"><span class="vendor-cat">Caterer</span><span class="vendor-rating">★ 4.8</span></div>
              <h3>Spice Route Catering</h3>
              <p class="vendor-location">📍 Panaji, Goa</p>
              <p class="vendor-price">From ₹800/head</p>
            </div>
          </div>
          <div class="vendor-card">
            <div class="vendor-img" style="background: linear-gradient(135deg, #1a2d1a, #15803d);">🥗</div>
            <div class="vendor-info">
              <div class="vendor-meta"><span class="vendor-cat">Restaurant</span><span class="vendor-rating">★ 4.7</span></div>
              <h3>The Garden Table</h3>
              <p class="vendor-location">📍 Margao, Goa</p>
              <p class="vendor-price">From ₹600/head</p>
            </div>
          </div>
          <div class="vendor-card">
            <div class="vendor-img" style="background: linear-gradient(135deg, #2d2010, #b45309);">🍰</div>
            <div class="vendor-info">
              <div class="vendor-meta"><span class="vendor-cat">Caterer</span><span class="vendor-rating">★ 4.9</span></div>
              <h3>Sweet Affairs</h3>
              <p class="vendor-location">📍 Mapusa, Goa</p>
              <p class="vendor-price">From ₹400/head</p>
            </div>
          </div>
          <div class="vendor-card">
            <div class="vendor-img" style="background: linear-gradient(135deg, #1a1a3d, #4338ca);">🍷</div>
            <div class="vendor-info">
              <div class="vendor-meta"><span class="vendor-cat">Restaurant</span><span class="vendor-rating">★ 4.6</span></div>
              <h3>Vino & Dine</h3>
              <p class="vendor-location">📍 Calangute, Goa</p>
              <p class="vendor-price">From ₹1,200/head</p>
            </div>
          </div>
        </div>
      </div>
    </section>

    <!-- ENTERTAINMENT -->
    <section class="section" id="entertainment">
      <div class="section-inner">
        <div class="section-header">
          <div>
            <p class="section-label">✦ Entertainment</p>
            <h2>Set the right vibe</h2>
          </div>
          <a href="/vendors?category=dj" class="view-all">View all →</a>
        </div>
        <div class="vendor-grid">
          <div class="vendor-card">
            <div class="vendor-img" style="background: linear-gradient(135deg, #1a0a2e, #7c3aed);">🎧</div>
            <div class="vendor-info">
              <div class="vendor-meta"><span class="vendor-cat">DJ</span><span class="vendor-rating">★ 4.7</span></div>
              <h3>DJ Raven</h3>
              <p class="vendor-location">📍 Calangute, Goa</p>
              <p class="vendor-price">From ₹15,000</p>
            </div>
          </div>
          <div class="vendor-card">
            <div class="vendor-img" style="background: linear-gradient(135deg, #0a1a2e, #1d4ed8);">🎸</div>
            <div class="vendor-info">
              <div class="vendor-meta"><span class="vendor-cat">Band</span><span class="vendor-rating">★ 4.8</span></div>
              <h3>The Coastal Rhythm</h3>
              <p class="vendor-location">📍 Panjim, Goa</p>
              <p class="vendor-price">From ₹25,000</p>
            </div>
          </div>
          <div class="vendor-card">
            <div class="vendor-img" style="background: linear-gradient(135deg, #1a2a0a, #4d7c0f);">🎤</div>
            <div class="vendor-info">
              <div class="vendor-meta"><span class="vendor-cat">Emcee</span><span class="vendor-rating">★ 4.9</span></div>
              <h3>Marco Fernandes</h3>
              <p class="vendor-location">📍 Margao, Goa</p>
              <p class="vendor-price">From ₹8,000</p>
            </div>
          </div>
          <div class="vendor-card">
            <div class="vendor-img" style="background: linear-gradient(135deg, #2a0a1a, #be185d);">🎵</div>
            <div class="vendor-info">
              <div class="vendor-meta"><span class="vendor-cat">DJ</span><span class="vendor-rating">★ 4.6</span></div>
              <h3>DJ Sundown</h3>
              <p class="vendor-location">📍 Baga, Goa</p>
              <p class="vendor-price">From ₹12,000</p>
            </div>
          </div>
        </div>
      </div>
    </section>

    <!-- DECORATORS & FLORISTS -->
    <section class="section alt" id="decor">
      <div class="section-inner">
        <div class="section-header">
          <div>
            <p class="section-label">✦ Decor & florals</p>
            <h2>Make it beautiful</h2>
          </div>
          <a href="/vendors?category=decorator" class="view-all">View all →</a>
        </div>
        <div class="vendor-grid">
          <div class="vendor-card">
            <div class="vendor-img" style="background: linear-gradient(135deg, #1a3d2b, #16a34a);">🌸</div>
            <div class="vendor-info">
              <div class="vendor-meta"><span class="vendor-cat">Florist</span><span class="vendor-rating">★ 4.9</span></div>
              <h3>Bloom & Co.</h3>
              <p class="vendor-location">📍 Mapusa, Goa</p>
              <p class="vendor-price">From ₹5,000</p>
            </div>
          </div>
          <div class="vendor-card">
            <div class="vendor-img" style="background: linear-gradient(135deg, #2d1a3d, #9333ea);">🎨</div>
            <div class="vendor-info">
              <div class="vendor-meta"><span class="vendor-cat">Decorator</span><span class="vendor-rating">★ 4.8</span></div>
              <h3>Velvet Decor Studio</h3>
              <p class="vendor-location">📍 Panaji, Goa</p>
              <p class="vendor-price">From ₹20,000</p>
            </div>
          </div>
          <div class="vendor-card">
            <div class="vendor-img" style="background: linear-gradient(135deg, #1a2d2d, #0f766e);">🕯️</div>
            <div class="vendor-info">
              <div class="vendor-meta"><span class="vendor-cat">Decorator</span><span class="vendor-rating">★ 4.7</span></div>
              <h3>Aura Setups</h3>
              <p class="vendor-location">📍 Vasco, Goa</p>
              <p class="vendor-price">From ₹15,000</p>
            </div>
          </div>
          <div class="vendor-card">
            <div class="vendor-img" style="background: linear-gradient(135deg, #2d1a0e, #92400e);">🌺</div>
            <div class="vendor-info">
              <div class="vendor-meta"><span class="vendor-cat">Florist</span><span class="vendor-rating">★ 4.8</span></div>
              <h3>Petal & Stem</h3>
              <p class="vendor-location">📍 Margao, Goa</p>
              <p class="vendor-price">From ₹3,500</p>
            </div>
          </div>
        </div>
      </div>
    </section>

    <!-- QUICK BOOK VENUE CTA -->
    <section class="quick-book">
      <div class="qb-glow"></div>
      <div class="qb-inner">
        <div class="qb-text">
          <p class="section-label">✦ Just need a space?</p>
          <h2>Book a venue<br>directly.</h2>
          <p>Skip the full planning flow — browse available venues and secure your date in minutes.</p>
          <a href="/vendors?category=venue" class="btn-primary">Browse venues →</a>
        </div>
        <div class="qb-cards">
          <div class="qb-card qb-c1">
            <div class="qb-card-icon">🏛️</div>
            <p>Coco Lawns</p>
            <span>Miramar · ₹50k</span>
          </div>
          <div class="qb-card qb-c2">
            <div class="qb-card-icon">🏖️</div>
            <p>Caravela Resort</p>
            <span>Varca · ₹1.5L</span>
          </div>
          <div class="qb-card qb-c3">
            <div class="qb-card-icon">🏰</div>
            <p>Taj Cidade</p>
            <span>Panaji · ₹2.5L</span>
          </div>
        </div>
      </div>
    </section>
    <!-- PARTNER CTA -->
    <section class="partner-section">
      <div class="partner-inner">
        <div class="partner-text">
          <p class="section-label">✦ Got a business?</p>
          <h2>Partner with Tactic.<br><span>Reach thousands of hosts.</span></h2>
          <p>List your venue, catering service, décor studio, or entertainment act on Tactic and get discovered by people planning their next big event.</p>
          <div class="partner-perks">
            <div class="perk"><span>🏛️</span> Venues & spaces</div>
            <div class="perk"><span>🍽️</span> Caterers & restaurants</div>
            <div class="perk"><span>🎨</span> Decorators & florists</div>
            <div class="perk"><span>🎧</span> DJs, bands & emcees</div>
          </div>
          <a href="vendor-signup.html" class="btn-partner">Join as a vendor →</a>
        </div>
        <div class="partner-card">
          <div class="partner-card-icon">🤝</div>
          <p class="partner-card-title">Already a vendor?</p>
          <p class="partner-card-sub">Log in to manage your bookings and listings.</p>
          <a href="auth.html" class="btn-partner-login">Log in →</a>
        </div>
      </div>
    </section>
  </main>

  <!-- FOOTER -->
  <footer>
    <div class="footer-inner">
      <div class="logo">Tac<span>tic</span></div>
      <p>© 2026 Tactic. All rights reserved.</p>
    </div>
  </footer>

</body>
</html>
