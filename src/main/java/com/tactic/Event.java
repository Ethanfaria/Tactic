package com.tactic;

public class Event {
    private int eventId;
    private int userId;
    private String eventName;
    private String eventType;
    private String eventDate;
    private String eventTime;
    private String location;
    private int guestCount;

    public Event() {}

    public int getEventId()          { return eventId; }
    public int getUserId()           { return userId; }
    public String getEventName()     { return eventName; }
    public String getEventType()     { return eventType; }
    public String getEventDate()     { return eventDate; }
    public String getEventTime()     { return eventTime; }
    public String getLocation()      { return location; }
    public int getGuestCount()       { return guestCount; }

    public void setEventId(int eventId)            { this.eventId = eventId; }
    public void setUserId(int userId)              { this.userId = userId; }
    public void setEventName(String eventName)     { this.eventName = eventName; }
    public void setEventType(String eventType)     { this.eventType = eventType; }
    public void setEventDate(String eventDate)     { this.eventDate = eventDate; }
    public void setEventTime(String eventTime)     { this.eventTime = eventTime; }
    public void setLocation(String location)       { this.location = location; }
    public void setGuestCount(int guestCount)      { this.guestCount = guestCount; }
}