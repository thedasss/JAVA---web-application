package servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import controllers.MovieController;
import models.Movie;

@WebServlet("/movies")
public class MovieServlet extends HttpServlet {

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
                    deleteMovie(request, response);
                    break;
                case "user":
                	 List<Movie> movies = movieController.getAllMovies();
                     request.setAttribute("movies", movies);
                     // Forward to the JSP page to display the list of movies
                     request.getRequestDispatcher("/UserDashboard.jsp").forward(request, response);
                	break;
                case "list":
                
                default:
                    listMovies(request, response);
                    break;
            }
        } catch (Exception e) {
            throw new ServletException("Error handling movie actions", e);
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
                    addMovie(request, response);
                    break;
                case "edit":
                    updateMovie(request, response);
                    break;
                default:
                    response.sendRedirect("movies?action=list");
                    break;
            }
        } catch (Exception e) {
            throw new ServletException("Error posting movie data", e);
        }
    }

    private void showNewForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Forward to the JSP form for adding a new movie
        request.getRequestDispatcher("/new-movie-form.jsp").forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Movie existingMovie = movieController.getMovie(id);
        request.setAttribute("movie", existingMovie);
        // Forward to the JSP form for editing the movie
        request.getRequestDispatcher("/edit-movie-form.jsp").forward(request, response);
    }

    private void addMovie(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String title = request.getParameter("title");
        String genre = request.getParameter("genre");
        int year = Integer.parseInt(request.getParameter("year"));
        String director = request.getParameter("director");
        String imageUrl = request.getParameter("imageUrl");
        String videoUrl = request.getParameter("videoUrl");

        Movie newMovie = new Movie(0, title, genre, year, director, imageUrl, videoUrl);
        movieController.addMovie(newMovie);
        response.sendRedirect("movies?action=list");
    }

    private void updateMovie(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String title = request.getParameter("title");
        String genre = request.getParameter("genre");
        int year = Integer.parseInt(request.getParameter("year"));
        String director = request.getParameter("director");
        String imageUrl = request.getParameter("imageUrl");
        String videoUrl = request.getParameter("videoUrl");

        Movie movie = new Movie(id, title, genre, year, director, imageUrl, videoUrl);
        movieController.updateMovie(movie);
        response.sendRedirect("movies?action=list");
    }

    private void deleteMovie(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        movieController.deleteMovie(id);
        response.sendRedirect("movies?action=list");
    }

    private void listMovies(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Movie> movies = movieController.getAllMovies();
        request.setAttribute("movies", movies);
        // Forward to the JSP page to display the list of movies
        request.getRequestDispatcher("/movie-list.jsp").forward(request, response);
    }
}