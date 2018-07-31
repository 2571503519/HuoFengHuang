package com.hfh.dao.test;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class JdbcTest {

    public static void main(String[] args) {
        String url = "jdbc:mysql://gz-cdb-2y5ivq4s.sql.tencentcdb.com:63127/test?useUnicode=true&amp;characterEncoding=utf-8";
        String user = "root";
        String passwd = "hfh123456";
        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection conn = DriverManager.getConnection(url, user, passwd);
            PreparedStatement pstmt = conn.prepareStatement("INSERT INTO user(username, password) VALUE ('jiale', '123456')");
            pstmt.execute();

            pstmt.close();
            conn.close();

        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

}
