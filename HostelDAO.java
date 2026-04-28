package com.dao;

import java.sql.*;
import java.sql.Date;
import java.util.*;
import com.madel.Student;  // MUST match your package

public class HostelDAO {

    private String jdbcURL = "jdbc:mysql://localhost:3306/hostel";
    private String jdbcUsername = "root";
    private String jdbcPassword = "abhi123---";

    private static final String INSERT_STUDENT =
        "INSERT INTO HostelStudents VALUES (?, ?, ?, ?, ?, ?)";
    private static final String SELECT_ALL =
        "SELECT * FROM HostelStudents";
    private static final String UPDATE_STUDENT =
        "UPDATE HostelStudents SET StudentName=?, RoomNumber=?, AdmissionDate=?, FeesPaid=?, PendingFees=? WHERE StudentID=?";
    private static final String DELETE_STUDENT =
        "DELETE FROM HostelStudents WHERE StudentID=?";
    private static final String SELECT_PENDING =
        "SELECT * FROM HostelStudents WHERE PendingFees > 0";
    private static final String SELECT_BY_ROOM =
        "SELECT * FROM HostelStudents WHERE RoomNumber=?";
    private static final String SELECT_BY_DATE =
        "SELECT * FROM HostelStudents WHERE AdmissionDate BETWEEN ? AND ?";

    protected Connection getConnection() throws SQLException {
        return DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
    }

    // Add Student
    public void insertStudent(Student s) throws SQLException {
        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(INSERT_STUDENT)) {
            ps.setInt(1, s.getStudentID());
            ps.setString(2, s.getStudentName());
            ps.setString(3, s.getRoomNumber());
            ps.setDate(4, s.getAdmissionDate());
            ps.setDouble(5, s.getFeesPaid());
            ps.setDouble(6, s.getPendingFees());
            ps.executeUpdate();
        }
    }

    // Get All Students
    public List<Student> getAllStudents() throws SQLException {
        List<Student> list = new ArrayList<>();
        try (Connection con = getConnection();
             Statement st = con.createStatement();
             ResultSet rs = st.executeQuery(SELECT_ALL)) {

            while (rs.next()) {
                list.add(extractStudent(rs));
            }
        }
        return list;
    }

    // Update Student
    public void updateStudent(Student s) throws SQLException {
        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(UPDATE_STUDENT)) {

            ps.setString(1, s.getStudentName());
            ps.setString(2, s.getRoomNumber());
            ps.setDate(3, s.getAdmissionDate());
            ps.setDouble(4, s.getFeesPaid());
            ps.setDouble(5, s.getPendingFees());
            ps.setInt(6, s.getStudentID());
            ps.executeUpdate();
        }
    }

    // Delete Student
    public void deleteStudent(int id) throws SQLException {
        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(DELETE_STUDENT)) {
            ps.setInt(1, id);
            ps.executeUpdate();
        }
    }

    // Reports
    public List<Student> getPendingFees() throws SQLException {
        return getStudentsByQuery(SELECT_PENDING, null);
    }

    public List<Student> getStudentsByRoom(String room) throws SQLException {
        return getStudentsByQuery(SELECT_BY_ROOM, ps -> ps.setString(1, room));
    }

    public List<Student> getStudentsByDate(Date start, Date end) throws SQLException {
        return getStudentsByQuery(SELECT_BY_DATE, ps -> {
            ps.setDate(1, start);
            ps.setDate(2, end);
        });
    }

    // Helper Methods
    private Student extractStudent(ResultSet rs) throws SQLException {
        return new Student(
            rs.getInt("StudentID"),
            rs.getString("StudentName"),
            rs.getString("RoomNumber"),
            rs.getDate("AdmissionDate"),
            rs.getDouble("FeesPaid"),
            rs.getDouble("PendingFees")
        );
    }

    private List<Student> getStudentsByQuery(String query, SQLConsumer<PreparedStatement> setter)
            throws SQLException {
        List<Student> list = new ArrayList<>();
        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(query)) {

            if (setter != null) setter.accept(ps);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                list.add(extractStudent(rs));
            }
        }
        return list;
    }

    @FunctionalInterface
    interface SQLConsumer<T> {
        void accept(T t) throws SQLException;
    }
}