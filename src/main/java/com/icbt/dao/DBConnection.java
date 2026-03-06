package com.icbt.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {

    private static Connection connection;

    public static Connection getConnection() {

        try {

            if (connection == null || connection.isClosed()) {

                Class.forName("com.mysql.cj.jdbc.Driver");

                connection = DriverManager.getConnection(
                	    "jdbc:mysql://localhost:3306/oceanview_db?useSSL=false&serverTimezone=UTC&tcpKeepAlive=true",
                	    "root",
                	    "password"
                	);

                System.out.println("Database connected successfully");

            }

        } catch (SQLException e) {

            System.out.println("Database connection failed!");
            System.out.println("Error Message: " + e.getMessage());
            System.out.println("SQL State: " + e.getSQLState());
            System.out.println("Error Code: " + e.getErrorCode());

            e.printStackTrace();

        } catch (ClassNotFoundException e) {

            System.out.println("MySQL JDBC Driver not found!");
            e.printStackTrace();

        }

        return connection;
    }
}