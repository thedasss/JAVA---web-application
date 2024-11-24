package controllers;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import configs.DBCon;
import models.MovieReview;

public class MovieReviewController {
    private Connection connection = DBCon.getInstance().getConnection();

    public boolean addReview(MovieReview review) {
        String sql = "INSERT INTO MovieReviews (movieId, review, rating) VALUES (?, ?, ?)";
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, review.getMovieId());
            statement.setString(2, review.getReview());
            statement.setDouble(3, review.getRating());
            return statement.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean updateReview(MovieReview review) {
        String sql = "UPDATE MovieReviews SET review = ?, rating = ? WHERE id = ?";
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, review.getReview());
            statement.setDouble(2, review.getRating());
            statement.setInt(3, review.getId());
            return statement.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean deleteReview(int id) {
        String sql = "DELETE FROM MovieReviews WHERE id = ?";
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, id);
            return statement.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<MovieReview> getAllReviews() {
        List<MovieReview> reviews = new ArrayList<>();
        String sql = "SELECT * FROM MovieReviews";
        try (PreparedStatement statement = connection.prepareStatement(sql);
             ResultSet resultSet = statement.executeQuery()) {
            while (resultSet.next()) {
                reviews.add(new MovieReview(
                        resultSet.getInt("id"),
                        resultSet.getInt("movieId"),
                        resultSet.getString("review"),
                        resultSet.getDouble("rating")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return reviews;
    }

    public MovieReview getReview(int id) {
        String sql = "SELECT * FROM MovieReviews WHERE id = ?";
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, id);
            ResultSet resultSet = statement.executeQuery();
            if (resultSet.next()) {
                return new MovieReview(
                        resultSet.getInt("id"),
                        resultSet.getInt("movieId"),
                        resultSet.getString("review"),
                        resultSet.getDouble("rating")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null; // Return null if no review is found or an error occurs
    }
}
