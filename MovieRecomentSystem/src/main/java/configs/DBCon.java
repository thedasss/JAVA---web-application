package configs;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBCon {
    // JDBC URL, username, and password
    private static final String JDBC_URL = "jdbc:mysql://localhost:3308/bhagya";
    private static final String USERNAME = "root";
    private static final String PASSWORD = "";

    // Singleton instance
    private static DBCon instance;

    // Connection object
    private Connection connection;

    // Private constructor to prevent instantiation
    private DBCon() {
        try {
            // Load MySQL JDBC driver
            Class.forName("com.mysql.jdbc.Driver");
            // Establish connection
            connection = DriverManager.getConnection(JDBC_URL, USERNAME, PASSWORD);
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
    }

    // Method to get singleton instance
    public static synchronized DBCon getInstance() {
        if (instance == null) {
            instance = new DBCon();
        }
        return instance;
    }

    // Method to get database connection
    public Connection getConnection() {
        return connection;
    }

    // Method to close database connection
    public void closeConnection() {
        if (connection != null) {
            try {
                connection.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
