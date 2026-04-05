<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.tactic.Event, com.tactic.Budget, com.tactic.Booking, java.util.List, java.math.BigDecimal" %>
<%
    Event event = (Event) request.getAttribute("event");
    Budget budget = (Budget) request.getAttribute("budget");
    List<Booking> bookings = (List<Booking>) request.getAttribute("bookings");
    Integer guestCount = (Integer) request.getAttribute("guestCount");

    String[] timeParts = event.getEventTime().split(":");
    int hour = Integer.parseInt(timeParts[0]);
    String ampm = hour >= 12 ? "PM" : "AM";
    int hour12 = hour % 12 == 0 ? 12 : hour % 12;
    String formattedTime = hour12 + ":" + timeParts[1] + " " + ampm;

    java.util.Map<String, String> typeEmoji = new java.util.HashMap<>();
    typeEmoji.put("birthday", "🎂 Birthday");
    typeEmoji.put("wedding", "💍 Wedding");
    typeEmoji.put("house_party", "🎉 House Party");
    typeEmoji.put("conference", "🤝 Conference");
    typeEmoji.put("corporate", "💼 Corporate");
    typeEmoji.put("social_gathering", "🎶 Social Gathering");
    typeEmoji.put("other", "✨ Other");
    String typeLabel = typeEmoji.getOrDefault(event.getEventType(), event.getEventType());

    java.util.Map<String, String> statusBadge = new java.util.HashMap<>();
    statusBadge.put("pending", "⏳ Pending");
    statusBadge.put("confirmed", "✅ Confirmed");
    statusBadge.put("rejected", "❌ Rejected");
    statusBadge.put("cancelled", "🚫 Cancelled");
    statusBadge.put("expired", "⌛ Expired");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tactic — <%= event.getEventName() %></title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:ital,wght@0,300;0,400;0,600;0,700;1,400&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="/css/event-detail.css">
</head>
<body>

<!-- NAV -->
<nav>
    <div class="nav-inner">
        <a href="/home" class="logo">Tac<span>tic</span></a>
        <div class="nav-links">
            <a href="/home" class="nav-link">← My events</a>
            <a href="/logout" class="nav-logout">Logout</a>
        </div>
    </div>
</nav>

<main>

    <!-- HERO -->
    <section class="event-hero">
        <div class="hero-inner">
            <div class="hero-left">
                <p class="eyebrow">✦ <%= typeLabel %></p>
                <h1><%= event.getEventName() %></h1>
                <div class="event-chips">
                    <span class="chip">📅 <%= event.getEventDate() %></span>
                    <span class="chip">🕐 <%= formattedTime %></span>
                    <% if (event.getLocation() != null && !event.getLocation().isEmpty()) { %>
                    <span class="chip">📍 <%= event.getLocation() %></span>
                    <% } %>
                    <span class="chip">👥 <%= event.getGuestCount() %> guests</span>
                </div>
            </div>
            <div class="hero-actions">
                <a href="/event/edit?id=<%= event.getEventId() %>" class="btn-edit">Edit event</a>
            </div>
        </div>
    </section>

    <div class="content-wrap">

        <!-- BUDGET SUMMARY -->
        <section class="card-section">
            <div class="section-header">
                <div>
                    <p class="section-label">✦ Budget</p>
                    <h2>Budget summary</h2>
                </div>
                <a href="/budget?id=<%= event.getEventId() %>" class="btn-secondary">
                    Manage budget →
                </a>
            </div>
            <% if (budget == null) { %>
            <div class="budget-empty">
                <p class="empty-icon">💰</p>
                <p class="empty-title">No budget set yet</p>
                <p class="empty-sub">Set a total budget and allocate across venues, food, music, and more.</p>
                <a href="/budget?id=<%= event.getEventId() %>" class="btn-primary">Set budget →</a>
            </div>
            <% } else { %>
            <div class="budget-summary">
                <div class="budget-total">
                    <span class="budget-label">Total Budget</span>
                    <span class="budget-amount">₹<%= String.format("%,.0f", budget.getTotalBudget()) %></span>
                </div>
                <div class="budget-grid">
                    <div class="budget-item">
                        <span class="budget-cat">🏛️ Venue</span>
                        <span class="budget-val">₹<%= String.format("%,.0f", budget.getVenueAllocation()) %></span>
                    </div>
                    <div class="budget-item">
                        <span class="budget-cat">🍽️ Food</span>
                        <span class="budget-val">₹<%= String.format("%,.0f", budget.getFoodAllocation()) %></span>
                    </div>
                    <div class="budget-item">
                        <span class="budget-cat">🎵 Music</span>
                        <span class="budget-val">₹<%= String.format("%,.0f", budget.getMusicAllocation()) %></span>
                    </div>
                    <div class="budget-item">
                        <span class="budget-cat">✨ Other</span>
                        <span class="budget-val">₹<%= String.format("%,.0f", budget.getOtherAllocation()) %></span>
                    </div>
                </div>
            </div>
            <% } %>
        </section>

        <!-- BOOKED VENDORS -->
        <section class="card-section alt">
            <div class="section-header">
                <div>
                    <p class="section-label">✦ Vendors</p>
                    <h2>Booked vendors <% if (bookings != null && !bookings.isEmpty()) { %><span class="count-badge"><%= bookings.size() %></span><% } %></h2>
                </div>
                <a href="/vendors" class="btn-secondary">Browse vendors →</a>
            </div>
            <% if (bookings == null || bookings.isEmpty()) { %>
            <div class="empty-state">
                <p class="empty-icon">🏪</p>
                <p class="empty-title">No vendors booked yet</p>
                <p class="empty-sub">Browse our verified venues, caterers, decorators, and entertainers.</p>
                <a href="/vendors" class="btn-primary">Browse vendors →</a>
            </div>
            <% } else { %>
            <div class="bookings-list">
                <% for (Booking booking : bookings) { %>
                <div class="booking-card <%= booking.getStatus() %>">
                    <div class="booking-info">
                        <h4><%= booking.getBusinessName() %></h4>
                        <p class="booking-category"><%= booking.getCategory() %></p>
                        <p class="booking-date">📅 <%= booking.getBookingDate() %> · <%= booking.getStartTime() %> - <%= booking.getEndTime() %></p>
                    </div>
                    <div class="booking-status">
                        <span class="status-badge <%= booking.getStatus() %>">
                            <%= statusBadge.getOrDefault(booking.getStatus(), booking.getStatus()) %>
                        </span>
                    </div>
                </div>
                <% } %>
            </div>
            <% } %>
        </section>

        <!-- GUESTLIST -->
        <section class="card-section">
            <div class="section-header">
                <div>
                    <p class="section-label">✦ Guestlist</p>
                    <h2>Guests <span class="count-badge"><%= guestCount != null ? guestCount : 0 %></span></h2>
                </div>
                <a href="/guest?id=<%= event.getEventId() %>" class="btn-secondary">Manage guests →</a>
            </div>
            <% if (guestCount == null || guestCount == 0) { %>
            <div class="empty-state">
                <p class="empty-icon">👥</p>
                <p class="empty-title">No guests added yet</p>
                <p class="empty-sub">Add your guests and send them invitations directly from Tactic.</p>
                <a href="/guest?id=<%= event.getEventId() %>" class="btn-primary">Add guests →</a>
            </div>
            <% } else { %>
            <div class="guest-summary">
                <p><%= guestCount %> guest<%= guestCount != 1 ? "s" : "" %> added to this event.</p>
                <a href="/guest?id=<%= event.getEventId() %>" class="btn-primary">View & manage guests →</a>
            </div>
            <% } %>
        </section>

    </div>
</main>

<footer>
    <div class="footer-inner">
        <div class="logo">Tac<span>tic</span></div>
        <p>© 2026 Tactic. All rights reserved.</p>
    </div>
</footer>

</body>
</html>