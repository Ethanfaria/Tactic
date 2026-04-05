package com.tactic;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class EventDAO {

    public int createEvent(int userId, String eventName, String eventType,
                           String eventDate, String eventTime,
                           String location, int guestCount) throws SQLException {

        String sql = "INSERT INTO events (user_id, event_name, event_type, event_date, event_time, location, guest_count) "
                + "VALUES (?, ?, CAST(? AS event_type), ?, ?, ?, ?) RETURNING event_id";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement stmt = con.prepareStatement(sql)) {

            stmt.setInt(1, userId);
            stmt.setString(2, eventName);
            stmt.setString(3, eventType);
            stmt.setDate(4, Date.valueOf(eventDate));
            stmt.setTime(5, Time.valueOf(eventTime + ":00"));
            stmt.setString(6, location);
            stmt.setInt(7, guestCount);

            ResultSet rs = stmt.executeQuery();
            if (rs.next()) return rs.getInt("event_id");
        }
        return -1;
    }
    public Event getEventById(int eventId, int userId) throws SQLException {
        String sql = "SELECT * FROM events WHERE event_id = ? AND user_id = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement stmt = con.prepareStatement(sql)) {

            stmt.setInt(1, eventId);
            stmt.setInt(2, userId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                Event e = new Event();
                e.setEventId(rs.getInt("event_id"));
                e.setEventName(rs.getString("event_name"));
                e.setEventType(rs.getString("event_type"));
                e.setEventDate(rs.getDate("event_date").toString());
                e.setEventTime(rs.getTime("event_time").toString());
                e.setLocation(rs.getString("location"));
                e.setGuestCount(rs.getInt("guest_count"));
                return e;
            }
        }
        return null;
    }
    public List<Event> getEventsByUser(int userId) throws SQLException {
        String sql = "SELECT * FROM events WHERE user_id = ? ORDER BY event_date ASC";
        List<Event> events = new ArrayList<>();

        try (Connection con = DBConnection.getConnection();
             PreparedStatement stmt = con.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Event e = new Event();
                e.setEventId(rs.getInt("event_id"));
                e.setEventName(rs.getString("event_name"));
                e.setEventDate(rs.getDate("event_date").toString());
                e.setEventType(rs.getString("event_type"));
                e.setEventTime(rs.getTime("event_time").toString());
                e.setLocation(rs.getString("location"));
                e.setGuestCount(rs.getInt("guest_count"));
                events.add(e);
            }
        }
        return events;
    }
    public boolean updateEvent(int eventId, int userId, String eventName, String eventType,
                               String eventDate, String eventTime,
                               String location, int guestCount) throws SQLException {

        String sql = "UPDATE events SET event_name = ?, event_type = CAST(? AS event_type), " +
                "event_date = ?, event_time = ?, location = ?, guest_count = ? " +
                "WHERE event_id = ? AND user_id = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement stmt = con.prepareStatement(sql)) {
            stmt.setString(1, eventName);
            stmt.setString(2, eventType);
            stmt.setDate(3, Date.valueOf(eventDate));
            stmt.setTime(4, Time.valueOf(eventTime + ":00"));
            stmt.setString(5, location);
            stmt.setInt(6, guestCount);
            stmt.setInt(7, eventId);
            stmt.setInt(8, userId);
            return stmt.executeUpdate() > 0;
        }
    }

    public boolean deleteEvent(int eventId, int userId) throws SQLException {
        String sql = "DELETE FROM events WHERE event_id = ? AND user_id = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement stmt = con.prepareStatement(sql)) {
            stmt.setInt(1, eventId);
            stmt.setInt(2, userId);
            return stmt.executeUpdate() > 0;
        }
    }
}