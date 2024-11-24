<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.util.List, models.Movie"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Select and Rate Movies</title>
    <!-- Bootstrap CSS -->
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <!-- Custom styles for star rating -->
    <style>
        body {
            background-color: #343a40; /* Dark background */
            color: white; /* Light text */
        }
        .rating {
            display: flex;
            flex-direction: row-reverse;
            justify-content: center;
        }
        .rating > label {
            position: relative;
            width: 1em;
            font-size: 3rem;
            font-weight: bold;
            cursor: pointer;
            color: #ddd; /* Default star color */
        }
        .rating > label:hover,
        .rating > label:hover ~ label,
        .rating > input:checked ~ label {
            color: #ffc107; /* Bootstrap yellow for active stars */
        }
        .rating > input {
            display: none; /* Hide the radio buttons */
        }
        .review-textarea {
            background-color: #495057;
            border: none;
            color: #fff;
        }
    </style>
</head>
<body>

<div class="container mt-5">
    <h1>Select a Movie to Rate</h1>
    <form action="reviews?action=add" method="POST">
        <div class="form-group">
            <label for="movieDropdown">Choose a Movie:</label>
            <select id="movieDropdown" name="movieId" class="custom-select">
                <option value="">Select a Movie</option>
                <%
                    List<Movie> movies = (List<Movie>) request.getAttribute("movies");
                    if (movies != null) {
                        for (Movie movie : movies) {
                %>
                        <option value="<%= movie.getId() %>"><%= movie.getTitle() %></option>
                <%
                        }
                    }
                %>
            </select>
        </div>
        <div class="form-group">
            <label>Rating:</label>
            <div class="rating">
                <input type="radio" name="stars" value="5.0" id="star5"><label for="star5">★</label>
                <input type="radio" name="stars" value="4.0" id="star4"><label for="star4">★</label>
                <input type="radio" name="stars" value="3.0" id="star3"><label for="star3">★</label>
                <input type="radio" name="stars" value="2.0" id="star2"><label for="star2">★</label>
                <input type="radio" name="stars" value="1.0" id="star1"><label for="star1">★</label>
            </div>
        </div>
        <div class="form-group">
            <label for="reviewText">Your Review:</label>
            <textarea id="reviewText" name="reviewText" class="form-control review-textarea" rows="5" placeholder="Type your review here..."></textarea>
        </div>
        <button type="submit" class="btn btn-primary">Submit Review</button>
    </form>
</div>

<!-- Bootstrap and jQuery (for Bootstrap's JavaScript plugins) -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

</body>
</html>
