<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.util.List, models.MovieReview"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Review List</title>
    <!-- Bootstrap CSS -->
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #343a40; /* Dark background */
            color: white; /* Light text */
        }
        .modal-content{
        	background-color:black;
        }
    </style>
</head>
<body>
<div class="container mt-5">
    <h1>Review List</h1>
    <table class="table table-dark table-hover">
        <thead>
            <tr>
                <th scope="col">#</th>
                <th scope="col">Movie ID</th>
                <th scope="col">Review</th>
                <th scope="col">Rating</th>
                <th scope="col">Actions</th>
            </tr>
        </thead>
        <tbody>
            <%
                List<MovieReview> reviews = (List<MovieReview>) request.getAttribute("reviews");
                if (reviews != null) {
                    for (MovieReview review : reviews) {
            %>
            <tr>
                <th scope="row"><%= review.getId() %></th>
                <td><%= review.getMovieId() %></td>
                <td><%= review.getReview() %></td>
                <td><%= review.getRating() %></td>
                <td>
                    <button class="btn btn-primary" data-toggle="modal" data-target="#editModal" data-id="<%= review.getId() %>" data-review="<%= review.getReview() %>" data-rating="<%= review.getRating() %>">Edit</button>
                    <button class="btn btn-danger" onclick="confirmDelete(<%= review.getId() %>)">Delete</button>
                </td>
            </tr>
            <%
                    }
                }
            %>
        </tbody>
    </table>
</div>

<!-- Edit Modal -->
<div class="modal fade" id="editModal" tabindex="-1" role="dialog" aria-labelledby="editModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="editModalLabel">Edit Review</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <form action="reviews?action=update" method="post">
                <div class="modal-body">
                    <input type="hidden" name="id" id="reviewId">
                    <div class="form-group">
                        <label for="reviewText">Review</label>
                        <textarea class="form-control" id="reviewText" name="reviewText" required></textarea>
                    </div>
                    <div class="form-group">
                        <label for="stars">Rating</label>
                        <input type="number" class="form-control" id="stars" name="stars" min="1" max="5" required>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                    <button type="submit" class="btn btn-primary">Save Changes</button>
                </div>
            </form>
        </div>
    </div>
</div>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script>
$(document).on("show.bs.modal", "#editModal", function(event) {
    var button = $(event.relatedTarget);
    var id = button.data('id');
    var review = button.data('review');
    var rating = button.data('rating');

    var modal = $(this);
    modal.find('.modal-body #reviewId').val(id);
    modal.find('.modal-body #reviewText').val(review);
    modal.find('.modal-body #stars').val(rating);
});

function confirmDelete(reviewId) {
    if (confirm("Are you sure you want to delete this review?")) {
        window.location.href = "reviews?action=delete&id=" + reviewId;
    }
}
</script>
</body>
</html>
