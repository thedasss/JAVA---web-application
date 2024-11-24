<%@ page contentType="text/html;charset=UTF-8" language="java" import="java.util.List, models.Movie" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Movie List</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
    $(document).ready(function() {
        $('#searchInput').on('keyup', function() {
            var value = $(this).val().toLowerCase();
            $('#moviesTable tbody tr').filter(function() {
                $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
            });
        });
    });
    </script>
</head>
<body style="padding:20px">
    <div class="container">
        <div class="d-flex justify-content-between">
            <a href="Dashboard.jsp" class="btn btn-secondary">Back to Dashboard</a>
            <h2>Movie List</h2>
            <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addMovieModal">Add Movie</button>
        </div>
        <hr class="hr" />

        <!-- Search input -->
        <input type="text" id="searchInput" class="form-control mb-3" placeholder="Search by Title, Genre, or Director...">

        <table class="table table-striped" id="moviesTable">
            <thead>
                <tr>
                    <th>Movie ID</th>
                    <th>Title</th>
                    <th>Genre</th>
                    <th>Year</th>
                    <th>Director</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <% 
                List<Movie> movies = (List<Movie>) request.getAttribute("movies");
                for (Movie movie : movies) {
                %>
                    <tr>
                        <td><%= movie.getId() %></td>
                        <td><%= movie.getTitle() %></td>
                        <td><%= movie.getGenre() %></td>
                        <td><%= movie.getYear() %></td>
                        <td><%= movie.getDirector() %></td>
                        <td>
                            <button type="button" 
                            class="btn btn-primary" 
                            onclick="openEditModal(<%= movie.getId() %>, '<%= movie.getTitle() %>', '<%= movie.getGenre() %>', <%= movie.getYear() %>, '<%= movie.getDirector() %>','<%= movie.getImageUrl() %>','<%= movie.getVideoUrl() %>')">Edit</button>
                            <button type="button" class="btn btn-danger" onclick="confirmDelete(<%= movie.getId() %>)">Delete</button>
                        </td>
                    </tr>
                <% } %>
            </tbody>
        </table>
    </div>

    <!-- Add Movie Modal -->
<div class="modal fade" id="addMovieModal" tabindex="-1" aria-labelledby="addMovieModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="addMovieModalLabel">Add Movie</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <!-- Add movie form -->
                <form id="addMovieForm" action="movies" method="post">
                    <input type="hidden" name="action" value="add"> <!-- To differentiate between add and update -->
                    <div class="mb-3">
                        <label for="title" class="form-label">Title</label>
                        <input type="text" class="form-control" id="title" name="title" required>
                    </div>
                    <div class="mb-3">
                        <label for="genre" class="form-label">Genre</label>
                        <input type="text" class="form-control" id="genre" name="genre" required>
                    </div>
                    <div class="mb-3">
                        <label for="year" class="form-label">Year</label>
                        <input type="number" class="form-control" id="year" name="year" required>
                    </div>
                    <div class="mb-3">
                        <label for="director" class="form-label">Director</label>
                        <input type="text" class="form-control" id="director" name="director" required>
                    </div>
                    <div class="mb-3">
                        <label for="imageUrl" class="form-label">Image URL</label>
                        <input type="text" class="form-control" id="imageUrl" name="imageUrl" required>
                    </div>
                    <div class="mb-3">
                        <label for="videoUrl" class="form-label">Video URL</label>
                        <input type="text" class="form-control" id="videoUrl" name="videoUrl" required>
                    </div>
                    <button type="submit" class="btn btn-primary">Submit</button>
                </form>
            </div>
        </div>
    </div>
</div>

<!-- Edit Movie Modal -->
<div class="modal fade" id="editMovieModal" tabindex="-1" aria-labelledby="editMovieModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="editMovieModalLabel">Edit Movie</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <!-- Edit movie form -->
                <form id="editMovieForm" action="movies?action=edit" method="post">
                    <input type="hidden" id="edit-movie-id" name="id">
                    <div class="mb-3">
                        <label for="edit-title" class="form-label">Title</label>
                        <input type="text" class="form-control" id="edit-title" name="title" required>
                    </div>
                    <div class="mb-3">
                        <label for="edit-genre" class="form-label">Genre</label>
                        <input type="text" class="form-control" id="edit-genre" name="genre" required>
                    </div>
                    <div class="mb-3">
                        <label for="edit-year" class="form-label">Year</label>
                        <input type="number" class="form-control" id="edit-year" name="year" required>
                    </div>
                    <div class="mb-3">
                        <label for="edit-director" class="form-label">Director</label>
                        <input type="text" class="form-control" id="edit-director" name="director" required>
                    </div>
                    <div class="mb-3">
                        <label for="edit-imageUrl" class="form-label">Image URL</label>
                        <input type="text" class="form-control" id="edit-imageUrl" name="imageUrl" required>
                    </div>
                    <div class="mb-3">
                        <label for="edit-videoUrl" class="form-label">Video URL</label>
                        <input type="text" class="form-control" id="edit-videoUrl" name="videoUrl" required>
                    </div>
                    <button type="submit" class="btn btn-primary">Save Changes</button>
                </form>
            </div>
        </div>
    </div>
</div>


    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.min.js" integrity="sha384-cuYeSxntonz0PPNlHhBs68uyIAVpIIOZZ5JqeqvYYIcEL727kskC66kF92t6Xl2V" crossorigin="anonymous"></script>
    <script>
        // Custom JavaScript functions for openEditModal and confirmDelete
        function openEditModal(movieId, title, genre, year, director,imageUrl,videoUrl) {
            $('#edit-movie-id').val(movieId);
            $('#edit-title').val(title);
            $('#edit-genre').val(genre);
            $('#edit-year').val(year);
            $('#edit-director').val(director);
            $('#edit-imageUrl').val(imageUrl);
            $('#edit-videoUrl').val(videoUrl);
            $('#editMovieModal').modal('show');
        }

        function confirmDelete(movieId) {
            if (confirm('Are you sure you want to delete this movie?')) {
                window.location.href = 'movies?action=delete&id=' + movieId;
            }
        }
    </script>
</body>
</html>
