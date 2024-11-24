package servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

import controllers.MovieController;
import controllers.MovieReviewController;
import models.Movie;
import models.MovieReview;

@WebServlet("/reviews")
public class MovieReviewServlet extends HttpServlet {
    private MovieReviewController reviewController = new MovieReviewController();
    private MovieController movieController = new MovieController();
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) {
            action = "list";
        }

        try {
            switch (action) {
                case "new":
                    showNewForm(request, response);
                    break;
                case "edit":
                    showEditForm(request, response);
                    break;
                case "delete":
                    deleteReview(request, response);
                    break;
                case "list":
                default:
                    listReviews(request, response);
                    break;
            }
        } catch (Exception e) {
            throw new ServletException("Error handling review actions", e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) {
            action = "list";
        }

        try {
            switch (action) {
                case "add":
                    addReview(request, response);
                    break;
                case "update":
                    updateReview(request, response);
                    break;
                default:
                    response.sendRedirect("reviews?action=list");
                    break;
            }
        } catch (Exception e) {
            throw new ServletException("Error posting review data", e);
        }
    }

    private void showNewForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	List<Movie> movies = movieController.getAllMovies();
    	request.setAttribute("movies", movies);
        request.getRequestDispatcher("/makereview.jsp").forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        MovieReview existingReview = reviewController.getReview(id);
        request.setAttribute("review", existingReview);
        request.getRequestDispatcher("/edit-review-form.jsp").forward(request, response);
    }

    private void addReview(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int movieId = Integer.parseInt(request.getParameter("movieId"));
        String reviewText = request.getParameter("reviewText");
        double rating = Double.parseDouble(request.getParameter("stars"));

        MovieReview newReview = new MovieReview(0, movieId, reviewText, rating);
        reviewController.addReview(newReview);
        response.sendRedirect("reviews?action=list");
    }

    private void updateReview(HttpServletRequest request, HttpServletResponse response) throws IOException {
    	try {
    		System.out.println("starts " + request.getParameter("movieId"));
            int id = Integer.parseInt(request.getParameter("id"));
            String reviewText = request.getParameter("reviewText");
            double rating = Double.parseDouble(request.getParameter("stars")) / 1.0;

            MovieReview review = new MovieReview();  
            review.setId(id);
            review.setRating(rating);
            review.setReview(reviewText);
            reviewController.updateReview(review);
            response.sendRedirect("reviews?action=list");
    	}catch(Exception err) {
    	
    	     response.sendRedirect("reviews?action=list");
    	}
    }

    private void deleteReview(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        reviewController.deleteReview(id);
        response.sendRedirect("reviews?action=list");
    }

    private void listReviews(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<MovieReview> reviews = reviewController.getAllReviews();
        request.setAttribute("reviews", reviews);
        request.getRequestDispatcher("/review-list.jsp").forward(request, response);
    }
}
