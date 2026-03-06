package com.icbt.util;

import java.sql.Connection;
import com.icbt.dao.DBConnection;

public class DBTest {

    public static void main(String[] args) {

        Connection conn = DBConnection.getConnection();

        if(conn != null) {
            System.out.println("Database Connected Successfully!");
        } else {
            System.out.println("Database Connection Failed!");
        }
    }
}
