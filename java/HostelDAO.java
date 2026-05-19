package com.dao;

import com.model.Student;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class HostelDAO {


    private static final String DRIVER   = "com.mysql.cj.jdbc.Driver";
    private static final String URL      = "jdbc:mysql://localhost:3306/hosteldb";
    private static final String USER     = "root";
    private static final String PASSWORD = "root";

//     ─── Connection ─────────────────────────────────────────────────────────
//    private Connection getConnection() throws Exception {
//        Class.forName(DRIVER);
//        return DriverManager.getConnection(URL, USER, PASSWORD);
//    }
    static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new RuntimeException("MySQL JDBC Driver not found.", e);
        }
    }
    private Connection getConnection() throws SQLException {
    	
        return DriverManager.getConnection(URL, USER, PASSWORD);
    }

    // ─── Add Student ─────────────────────────────────────────────────────────
    public boolean addStudent(Student s) {
        String sql = "INSERT INTO HostelStudents ( StudentName, RoomNumber, AdmissionDate, FeesPaid, PendingFees) VALUES (?,?,?,?,?)";
        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
        	
//            ps.setInt(1, s.getStudentID());
            ps.setString(1, s.getStudentName());
            ps.setString(2, s.getRoomNumber());
            ps.setDate(3, s.getAdmissionDate());
            ps.setDouble(4, s.getFeesPaid());
            ps.setDouble(5, s.getPendingFees());
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public int getStudentID() {
    	String sql ="SELECT coalesce(max(StudentID),0) + 1 as NextID from HostelStudents";
    	try (Connection con = getConnection();
        Statement st = con.createStatement();
        ResultSet rs = st.executeQuery(sql)) {
       if (rs.next()) return rs.getInt("NextID");
   } catch (SQLException e) {
       e.printStackTrace();
   }
   return 1;
}
   // ─── Update Student ───────────────────────────────────────────────────────
    public boolean updateStudent(Student s) {
        String sql = "UPDATE HostelStudents SET StudentName=?, RoomNumber=?, AdmissionDate=?, FeesPaid=?, PendingFees=? WHERE StudentID=?";
        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, s.getStudentName());
            ps.setString(2, s.getRoomNumber());
            ps.setDate(3, s.getAdmissionDate());
            ps.setDouble(4, s.getFeesPaid());
            ps.setDouble(5, s.getPendingFees());
            ps.setInt(6, s.getStudentID());
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // ─── Delete Student ───────────────────────────────────────────────────────
    public boolean deleteStudent(int id) {
        String sql = "DELETE FROM HostelStudents WHERE StudentID=?";
        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // ─── Get All Students ─────────────────────────────────────────────────────
    public List<Student> getAllStudents() {
        List<Student> list = new ArrayList<>();
        String sql = "SELECT * FROM HostelStudents ORDER BY StudentID";
        try (Connection con = getConnection();
             Statement st = con.createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            while (rs.next()) list.add(mapRow(rs));
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // ─── Get Student by ID ────────────────────────────────────────────────────
    public Student getStudentByID(int id) {
        String sql = "SELECT * FROM HostelStudents WHERE StudentID=?";
        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return mapRow(rs);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    // ─── Report: Pending Fees ─────────────────────────────────────────────────
    public List<Student> getStudentsWithPendingFees() {
        List<Student> list = new ArrayList<>();
        String sql = "SELECT * FROM HostelStudents WHERE PendingFees > 0 ORDER BY PendingFees DESC";
        try (Connection con = getConnection();
             Statement st = con.createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            while (rs.next()) list.add(mapRow(rs));
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // ─── Report: By Room ──────────────────────────────────────────────────────
    public List<Student> getStudentsByRoom(String room) {
        List<Student> list = new ArrayList<>();
        String sql = "SELECT * FROM HostelStudents WHERE RoomNumber=? ORDER BY StudentName";
        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, room);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) list.add(mapRow(rs));
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // ─── Report: Admission Date Range ─────────────────────────────────────────
    public List<Student> getStudentsByDateRange(Date from, Date to) {
        List<Student> list = new ArrayList<>();
        String sql = "SELECT * FROM HostelStudents WHERE AdmissionDate BETWEEN ? AND ? ORDER BY AdmissionDate";
        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setDate(1, from);
            ps.setDate(2, to);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) list.add(mapRow(rs));
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // ─── Helper ───────────────────────────────────────────────────────────────
    private Student mapRow(ResultSet rs) throws SQLException {
        return new Student(
            rs.getInt("StudentID"),
            rs.getString("StudentName"),
            rs.getString("RoomNumber"),
            rs.getDate("AdmissionDate"),
            rs.getDouble("FeesPaid"),
            rs.getDouble("PendingFees")
        );
    }
}
