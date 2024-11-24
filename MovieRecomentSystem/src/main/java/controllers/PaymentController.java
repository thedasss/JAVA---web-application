package controllers;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import configs.DBCon;
import models.Payment;

public class PaymentController {
    // Get database connection
    private Connection connection = DBCon.getInstance().getConnection();

    // Create a new payment
    public boolean addPayment(Payment payment) {
        String sql = "INSERT INTO Payment (SiteUserID, FullName, Email, CardNo, BankName, Amount) VALUES (?, ?, ?, ?, ?, ?)";
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, payment.getSiteUserID());
            statement.setString(2, payment.getFullName());
            statement.setString(3, payment.getEmail());
            statement.setString(4, payment.getCardNo());
            statement.setString(5, payment.getBankName());
            statement.setDouble(6, payment.getAmount());
            int rowsInserted = statement.executeUpdate();
            return rowsInserted > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Update an existing payment
    public boolean updatePayment(Payment payment) {
        String sql = "UPDATE Payment SET SiteUserID = ?, FullName = ?, Email = ?, CardNo = ?, BankName = ?, Amount = ? WHERE PaymentID = ?";
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, payment.getSiteUserID());
            statement.setString(2, payment.getFullName());
            statement.setString(3, payment.getEmail());
            statement.setString(4, payment.getCardNo());
            statement.setString(5, payment.getBankName());
            statement.setDouble(6, payment.getAmount());
            statement.setInt(7, payment.getPaymentID());
            int rowsUpdated = statement.executeUpdate();
            return rowsUpdated > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Delete a payment
    public boolean deletePayment(int paymentID) {
        String sql = "DELETE FROM Payment WHERE PaymentID = ?";
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, paymentID);
            int rowsDeleted = statement.executeUpdate();
            return rowsDeleted > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Get all payments
    public List<Payment> getAllPayments() {
        List<Payment> payments = new ArrayList<>();
        String sql = "SELECT * FROM Payment";
        try (PreparedStatement statement = connection.prepareStatement(sql);
             ResultSet resultSet = statement.executeQuery()) {
            while (resultSet.next()) {
                payments.add(new Payment(
                        resultSet.getInt("PaymentID"),
                        resultSet.getInt("SiteUserID"),
                        resultSet.getString("FullName"),
                        resultSet.getString("Email"),
                        resultSet.getString("CardNo"),
                        resultSet.getString("BankName"),
                        resultSet.getDouble("Amount")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return payments;
    }

    // Get a payment by ID
    public Payment getPayment(int paymentID) {
        String sql = "SELECT * FROM Payment WHERE PaymentID = ?";
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, paymentID);
            ResultSet resultSet = statement.executeQuery();
            if (resultSet.next()) {
                return new Payment(
                        resultSet.getInt("PaymentID"),
                        resultSet.getInt("SiteUserID"),
                        resultSet.getString("FullName"),
                        resultSet.getString("Email"),
                        resultSet.getString("CardNo"),
                        resultSet.getString("BankName"),
                        resultSet.getDouble("Amount")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null; // Return null if payment not found or error occurs
    }
}
