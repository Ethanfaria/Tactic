<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.tactic.Event" %>
<%
    Event event = (Event) request.getAttribute("event");
    String error = request.getParameter("error");

    // Format time to HH:mm for input (strip seconds if present)
    String timeVal = event.getEventTime();
    if (timeVal != null && timeVal.length() > 5) timeVal = timeVal.substring(0, 5);
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tactic — Edit Event</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:ital,wght@0,300;0,400;0,600;0,700;1,400&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="../css/create-event.css">
    <style>
        .delete-zone { margin-top: 48px; padding-top: 32px; border-top: 1px solid rgba(255,255,255,0.07); }
        .delete-zone h3 { font-size: 15px; font-weight: 600; margin-bottom: 8px; color: #ef4444; }
        .delete-zone p { font-size: 13px; color: #6b7280; margin-bottom: 16px; line-height: 1.6; }
        .btn-delete { padding: 11px 24px; background: rgba(239,68,68,0.1); color: #ef4444; border: 1px solid rgba(239,68,68,0.3); border-radius: 9px; font-size: 13px; font-weight: 600; font-family: "Poppins",sans-serif; cursor: pointer; transition: all 0.2s; }
        .btn-delete:hover { background: rgba(239,68,68,0.2); }
        .alert { padding: 12px 18px; border-radius: 10px; font-size: 13px; margin-bottom: 24px; }
        .alert.error { background: rgba(220,38,38,0.1); border: 1px solid rgba(220,38,38,0.25); color: #fca5a5; }
    </style>
</head>
<body>

<nav>
    <div class="nav-inner">
        <a href="../home" class="logo">Tac<span>tic</span></a>
        <a href="../event/detail?id=<%= event.getEventId() %>" class="nav-back">← Back to event</a>
    </div>
</nav>

<main>
    <div class="page-wrap">

        <!-- LEFT PANEL -->
        <div class="left-panel">
            <p class="eyebrow">✦ Editing event</p>
            <h1>Update your<br><span>details.</span></h1>
            <p class="left-sub">Make changes to your event info. Your vendors and guests won't be affected.</p>

            <div class="steps">
                <div class="step active" id="ind-1">
                    <div class="step-dot"></div>
                    <div class="step-info">
                        <span class="step-label">Step 1</span>
                        <span class="step-name">The basics</span>
                    </div>
                </div>
                <div class="step-line"></div>
                <div class="step" id="ind-2">
                    <div class="step-dot"></div>
                    <div class="step-info">
                        <span class="step-label">Step 2</span>
                        <span class="step-name">Date & time</span>
                    </div>
                </div>
                <div class="step-line"></div>
                <div class="step" id="ind-3">
                    <div class="step-dot"></div>
                    <div class="step-info">
                        <span class="step-label">Step 3</span>
                        <span class="step-name">Guests & location</span>
                    </div>
                </div>
            </div>
        </div>

        <!-- RIGHT PANEL -->
        <div class="right-panel">

            <% if ("missing".equals(error)) { %>
            <div class="alert error">Please fill in all required fields.</div>
            <% } else if ("server".equals(error)) { %>
            <div class="alert error">Something went wrong. Please try again.</div>
            <% } %>

            <form action="../event/edit" method="post" id="event-form">
                <input type="hidden" name="event_id" value="<%= event.getEventId() %>">

                <!-- STEP 1 -->
                <div class="form-step active" id="step-1">
                    <div class="step-header">
                        <p class="step-pill">Step 1 of 3</p>
                        <h2>The basics</h2>
                        <p class="step-desc">What's the occasion?</p>
                    </div>

                    <div class="field">
                        <label>EVENT NAME</label>
                        <input type="text" name="event_name"
                               value="<%= event.getEventName() %>" required>
                    </div>

                    <div class="field">
                        <label>EVENT TYPE</label>
                        <div class="select-wrap">
                            <select name="event_type" id="event_type" required>
                                <option value="birthday"         <%= "birthday".equals(event.getEventType())         ? "selected" : "" %>>🎂 Birthday</option>
                                <option value="wedding"          <%= "wedding".equals(event.getEventType())          ? "selected" : "" %>>💍 Wedding</option>
                                <option value="house_party"      <%= "house_party".equals(event.getEventType())      ? "selected" : "" %>>🎉 House Party</option>
                                <option value="conference"       <%= "conference".equals(event.getEventType())       ? "selected" : "" %>>🤝 Conference</option>
                                <option value="corporate"        <%= "corporate".equals(event.getEventType())        ? "selected" : "" %>>💼 Corporate</option>
                                <option value="social_gathering" <%= "social_gathering".equals(event.getEventType()) ? "selected" : "" %>>🎶 Social Gathering</option>
                                <option value="other"            <%= "other".equals(event.getEventType())            ? "selected" : "" %>>✨ Other</option>
                            </select>
                            <span class="select-arrow">▾</span>
                        </div>
                    </div>

                    <div class="type-grid">
                        <div class="type-tile <%= "birthday".equals(event.getEventType())         ? "selected" : "" %>" data-value="birthday"         onclick="selectType(this)">🎂<span>Birthday</span></div>
                        <div class="type-tile <%= "wedding".equals(event.getEventType())          ? "selected" : "" %>" data-value="wedding"          onclick="selectType(this)">💍<span>Wedding</span></div>
                        <div class="type-tile <%= "house_party".equals(event.getEventType())      ? "selected" : "" %>" data-value="house_party"      onclick="selectType(this)">🎉<span>House Party</span></div>
                        <div class="type-tile <%= "conference".equals(event.getEventType())       ? "selected" : "" %>" data-value="conference"       onclick="selectType(this)">🤝<span>Conference</span></div>
                        <div class="type-tile <%= "corporate".equals(event.getEventType())        ? "selected" : "" %>" data-value="corporate"        onclick="selectType(this)">💼<span>Corporate</span></div>
                        <div class="type-tile <%= "social_gathering".equals(event.getEventType()) ? "selected" : "" %>" data-value="social_gathering" onclick="selectType(this)">🎶<span>Social</span></div>
                        <div class="type-tile <%= "other".equals(event.getEventType())            ? "selected" : "" %>" data-value="other"            onclick="selectType(this)">✨<span>Other</span></div>
                    </div>

                    <div class="msg error" id="msg-1"></div>
                    <div class="step-actions">
                        <button type="button" class="btn-next" onclick="goTo(2)">Continue →</button>
                    </div>
                </div>

                <!-- STEP 2 -->
                <div class="form-step" id="step-2">
                    <div class="step-header">
                        <p class="step-pill">Step 2 of 3</p>
                        <h2>Date & time</h2>
                        <p class="step-desc">When is it happening?</p>
                    </div>

                    <div class="field-row">
                        <div class="field">
                            <label>DATE</label>
                            <input type="date" name="event_date"
                                   value="<%= event.getEventDate() %>" required>
                        </div>
                        <div class="field">
                            <label>TIME</label>
                            <input type="time" name="event_time"
                                   value="<%= timeVal %>" required>
                        </div>
                    </div>

                    <div class="date-preview" id="date-preview">
                        <div class="date-preview-icon">📅</div>
                        <div class="date-preview-text">
                            <span id="preview-date"><%= event.getEventDate() %></span>
                            <span id="preview-time" class="preview-sub"><%= timeVal %></span>
                        </div>
                    </div>

                    <div class="msg error" id="msg-2"></div>
                    <div class="step-actions">
                        <button type="button" class="btn-back" onclick="goTo(1)">← Back</button>
                        <button type="button" class="btn-next" onclick="goTo(3)">Continue →</button>
                    </div>
                </div>

                <!-- STEP 3 -->
                <div class="form-step" id="step-3">
                    <div class="step-header">
                        <p class="step-pill">Step 3 of 3</p>
                        <h2>Guests & location</h2>
                        <p class="step-desc">Almost there.</p>
                    </div>

                    <div class="field">
                        <label>LOCATION</label>
                        <input type="text" name="location"
                               value="<%= event.getLocation() != null ? event.getLocation() : "" %>"
                               placeholder="e.g. Coco Lawns, Miramar, Goa">
                    </div>

                    <div class="field">
                        <label>EXPECTED GUEST COUNT</label>
                        <div class="guest-count-wrap">
                            <button type="button" class="count-btn" onclick="changeGuests(-10)">−</button>
                            <input type="number" id="guest_count" name="guest_count"
                                   value="<%= event.getGuestCount() %>" min="1" max="10000">
                            <button type="button" class="count-btn" onclick="changeGuests(10)">+</button>
                        </div>
                    </div>

                    <!-- Summary -->
                    <div class="summary-card">
                        <p class="summary-title">✦ Updated summary</p>
                        <div class="summary-row"><span>Name</span><strong id="sum-name"><%= event.getEventName() %></strong></div>
                        <div class="summary-row"><span>Type</span><strong id="sum-type"><%= event.getEventType() %></strong></div>
                        <div class="summary-row"><span>Date</span><strong id="sum-date"><%= event.getEventDate() %></strong></div>
                        <div class="summary-row"><span>Time</span><strong id="sum-time"><%= timeVal %></strong></div>
                    </div>

                    <div class="msg error" id="msg-3"></div>
                    <div class="step-actions">
                        <button type="button" class="btn-back" onclick="goTo(2)">← Back</button>
                        <button type="submit" class="btn-next">Save changes ✓</button>
                    </div>
                </div>

            </form>

            <!-- DELETE ZONE -->
            <div class="delete-zone">
                <h3>Danger zone</h3>
                <p>Deleting this event is permanent. All bookings, guests, and budget data linked to it will also be removed.</p>
                <form action="../event/edit" method="post"
                      onsubmit="return confirm('Are you sure you want to delete <%= event.getEventName() %>? This cannot be undone.')">
                    <input type="hidden" name="event_id" value="<%= event.getEventId() %>">
                    <input type="hidden" name="action"   value="delete">
                    <button type="submit" class="btn-delete">Delete event</button>
                </form>
            </div>

        </div>
    </div>
</main>

<script>
    let currentStep = 1;

    function goTo(step) {
        if (step > currentStep && !validate(currentStep)) return;
        document.getElementById('step-' + currentStep).classList.remove('active');
        document.getElementById('ind-'  + currentStep).classList.remove('active');
        document.getElementById('ind-'  + currentStep).classList.add('done');
        currentStep = step;
        document.getElementById('step-' + currentStep).classList.add('active');
        document.getElementById('ind-'  + currentStep).classList.remove('done');
        document.getElementById('ind-'  + currentStep).classList.add('active');
        if (step === 3) updateSummary();
    }

    function validate(step) {
        clearMsg(step);
        if (step === 1) {
            const name = document.querySelector('[name="event_name"]').value.trim();
            const type = document.getElementById('event_type').value;
            if (!name) { showMsg(1, 'Please enter an event name.'); return false; }
            if (!type) { showMsg(1, 'Please select an event type.'); return false; }
        }
        if (step === 2) {
            const date = document.querySelector('[name="event_date"]').value;
            const time = document.querySelector('[name="event_time"]').value;
            if (!date) { showMsg(2, 'Please pick a date.'); return false; }
            if (!time) { showMsg(2, 'Please pick a time.'); return false; }
        }
        return true;
    }

    function showMsg(step, text) {
        const el = document.getElementById('msg-' + step);
        el.textContent = text; el.classList.add('show');
    }
    function clearMsg(step) {
        const el = document.getElementById('msg-' + step);
        el.textContent = ''; el.classList.remove('show');
    }
    function selectType(tile) {
        document.querySelectorAll('.type-tile').forEach(t => t.classList.remove('selected'));
        tile.classList.add('selected');
        document.getElementById('event_type').value = tile.dataset.value;
    }
    function changeGuests(delta) {
        const input = document.getElementById('guest_count');
        input.value = Math.max(1, parseInt(input.value || 0) + delta);
    }
    function updateSummary() {
        const typeLabels = {
            birthday:'Birthday', wedding:'Wedding', house_party:'House Party',
            conference:'Conference', corporate:'Corporate',
            social_gathering:'Social Gathering', other:'Other'
        };
        document.getElementById('sum-name').textContent = document.querySelector('[name="event_name"]').value || '—';
        document.getElementById('sum-type').textContent = typeLabels[document.getElementById('event_type').value] || '—';
        document.getElementById('sum-date').textContent = document.querySelector('[name="event_date"]').value || '—';
        document.getElementById('sum-time').textContent = document.querySelector('[name="event_time"]').value || '—';
    }

    // Update date preview on change
    document.querySelector('[name="event_date"]').addEventListener('change', function() {
        document.getElementById('preview-date').textContent = this.value;
    });
    document.querySelector('[name="event_time"]').addEventListener('change', function() {
        document.getElementById('preview-time').textContent = this.value;
    });
</script>

</body>
</html>