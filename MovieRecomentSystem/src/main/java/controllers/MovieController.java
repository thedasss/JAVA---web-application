package controllers;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import configs.DBCon;
import models.Movie;

public class MovieController {
    // Get database connection
    private Connection connection = DBCon.getInstance().getConnection();

    // Create a new movie
    public boolean addMovie(Movie movie) {
        String sql = "INSERT INTO Movies (title, genre, year, director, imageUrl, videoUrl) VALUES (?, ?, ?, ?, ?, ?)";
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, movie.getTitle());
            statement.setString(2, movie.getGenre());
            statement.setInt(3, movie.getYear());
            statement.setString(4, movie.getDirector());
            statement.setString(5, movie.getImageUrl());
            statement.setString(6, movie.getVideoUrl());
            int rowsInserted = statement.executeUpdate();
            return rowsInserted > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Update an existing movie
    public boolean updateMovie(Movie movie) {
        String sql = "UPDATE Movies SET title = ?, genre = ?, year = ?, director = ?, imageUrl = ?, videoUrl = ? WHERE id = ?";
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, movie.getTitle());
            statement.setString(2, movie.getGenre());
            statement.setInt(3, movie.getYear());
            statement.setString(4, movie.getDirector());
            statement.setString(5, movie.getImageUrl());
            statement.setString(6, movie.getVideoUrl());
            statement.setInt(7, movie.getId());
            int rowsUpdated = statement.executeUpdate();
            return rowsUpdated > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Delete a movie
    public boolean deleteMovie(int id) {
        String sql = "DELETE FROM Movies WHERE id = ?";
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, id);
            int rowsDeleted = statement.executeUpdate();
            return rowsDeleted > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Get all movies
    public List<Movie> getAllMovies() {
        List<Movie> movies = new ArrayList<>();
        String sql = "SELECT * FROM Movies";
        try (PreparedStatement statement = connection.prepareStatement(sql);
             ResultSet resultSet = statement.executeQuery()) {
            while (resultSet.next()) {
                movies.add(new Movie(
                        resultSet.getInt("id"),
                        resultSet.getString("title"),
                        resultSet.getString("genre"),
                        resultSet.getInt("year"),
                        resultSet.getString("director"),
                        resultSet.getString("imageUrl"),
                        resultSet.getString("videoUrl")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return movies;
    }

    // Get a movie by ID
    public Movie getMovie(int id) {
        String sql = "SELECT * FROM Movies WHERE id = ?";
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, id);
            ResultSet resultSet = statement.executeQuery();
            if (resultSet.next()) {
                return new Movie(
                        resultSet.getInt("id"),
                        resultSet.getString("title"),
                        resultSet.getString("genre"),
                        resultSet.getInt("year"),
                        resultSet.getString("director"),
                        resultSet.getString("imageUrl"),
                        resultSet.getString("videoUrl")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null; // Return null if movie not found or error occurs
    }
}
