<%@ page contentType="text/html;charset=UTF-8" language="java" import="java.util.List, models.Movie" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>User Dashboard</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-image: url('https://images.unsplash.com/photo-1489599849927-2ee91cede3ba?q=80&w=2940&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D');
            background-size: cover;
            color: #fff;
            padding : 0;
            margin:0;
            
        }
        .navbar {
            background-color: #000000; /* Black */
      
        }
        .navbar-nav .nav-link {
            background: #8B0000;
            border-radius:12px;
            margin-right:8px;
            color:white;
             /* Dark Red */
        }
        .card-body {
            background-color: #000000; /* Black */
            color: #BEBEBE; /* Grey */
        }
        .modal-body{
        	background-color: #000000;
        }
        .modal-body input{
        	background-color:grey;
        	border:none;
        }
        .modal-header{
        		background-color: #000000;
        }
    </style>
</head>
<body style="padding:20px">
    <nav class="navbar navbar-expand-lg navbar-dark">
        <div class="container-fluid">
            <a class="navbar-brand" href="#">Movie Dashboard</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ml-auto">
                  <!-- Inside your navigation bar -->
<%
    Object loggedInUser = session.getAttribute("loggedInUser");
    if (loggedInUser != null) {
%>
<li class="nav-item">
        <a class="nav-link" href="user-payment-view.jsp">Make a payment</a>
    </li>
    <li class="nav-item">
        <a class="nav-link" href="users?action=edit">Profile</a>
    </li>
    <li class="nav-item">
        <a class="nav-link" href="payments?action=list">Payment History</a>
    </li>
      <li class="nav-item">
        <a class="nav-link" href="reviews?action=new">Make Review</a>
    </li>
    <li class="nav-item">
        <a class="nav-link" href="reviews?action=list">My Reviews</a>
    </li>
    <li class="nav-item">
        <a class="nav-link" href="logout.jsp">Logout</a>
    </li>
<%
    } else {
%>
    <li class="nav-item">
        <a class="nav-link" href="login.jsp">Login</a>
    </li>
    <li class="nav-item">
        <a class="nav-link" href="signup.jsp">Signup</a>
    </li>
     
<%
    }
%>

                </ul>
            </div>
        </div>
    </nav>

    <!-- Login Modal -->
    <div class="modal fade" id="loginModal" tabindex="-1" aria-labelledby="loginModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="loginModalLabel">Login</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form id="loginForm">
                        <div class="mb-3">
                            <label for="loginUsername" class="form-label">Username/Email</label>
                            <input type="text" class="form-control" id="loginUsername" required>
                        </div>
                        <div class="mb-3">
                            <label for="loginPassword" class="form-label">Password</label>
                            <input type="password" class="form-control" id="loginPassword" required>
                        </div>
                        <button type="submit" class="btn btn-primary">Login</button>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <!-- Signup Modal -->
    <div class="modal fade" id="signupModal" tabindex="-1" aria-labelledby="signupModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="signupModalLabel">Signup</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form id="signupForm" method="post" action="users">
                        <div class="mb-3">
                            <label for="signupFirstName" class="form-label">First Name</label>
                            <input type="text" class="form-control" id="signupFirstName" required>
                        </div>
                        <div class="mb-3">
                            <label for="signupLastName" class="form-label">Last Name</label>
                            <input type="text" class="form-control" id="signupLastName" required>
                        </div>
                        <div class="mb-3">
                            <label for="signupEmail" class="form-label">Email</label>
                            <input type="email" class="form-control" id="signupEmail" required>
                        </div>
                        <div class="mb-3">
                            <label for="signupPhone" class="form-label">Phone</label>
                            <input type="text" class="form-control" id="signupPhone" required>
                        </div>
                        <div class="mb-3">
                            <label for="signupUsername" class="form-label">Username</label>
                            <input type="text" class="form-control" id="signupUsername" required>
                        </div>
                        <div class="mb-3">
                            <label for="signupPassword" class="form-label">Password</label>
                            <input type="password" class="form-control" id="signupPassword" required>
                        </div>
                        <button type="submit" class="btn btn-primary">Signup</button>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <div class="container">
        <div class="row row-cols-1 row-cols-md-3 g-4">
            <% 
            List<Movie> movies = (List<Movie>) request.getAttribute("movies");
            for (Movie movie : movies) {
            %>
                <div class="col">
                    <div class="card h-100">
                        <img src="<%= movie.getImageUrl() %>" class="card-img-top" alt="<%= movie.getTitle() %>">
                        <div class="card-body">
                            <h5 class="card-title"><%= movie.getTitle() %></h5>
                            <p class="card-text">Genre: <%= movie.getGenre() %></p>
                            <p class="card-text">Year: <%= movie.getYear() %></p>
                            <p class="card-text">Director: <%= movie.getDirector() %></p>
                            <a href="<%= movie.getVideoUrl() %>" class="btn btn-danger">Watch Trailer</a>
                        </div>
                    </div>
                </div>
            <% } %>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.min.js" integrity="sha384-cuYeSxntonz0PPNlHhBs68uyIAVpIIOZZ5JqeqvYYIcEL727kskC66kF92t6Xl2V" crossorigin="anonymous"></script>
    <script>
        // Handle login form submission
        document.getElementById('loginForm').addEventListener('submit', function(event) {
            event.preventDefault();
            var username = document.getElementById('loginUsername').value;
            var password = document.getElementById('loginPassword').value;
            // Send AJAX request to login servlet
            // Example:
            // $.post('LoginServlet', {username: username, password: password}, function(response) {
            //     // Handle response
            // });
        });

        // Handle signup form submission
        document.getElementById('signupForm').addEventListener('submit', function(event) {
            event.preventDefault();
            var firstName = document.getElementById('signupFirstName').value;
            var lastName = document.getElementById('signupLastName').value;
            var email = document.getElementById('signupEmail').value;
            var phone = document.getElementById('signupPhone').value;
            var username = document.getElementById('signupUsername').value;
            var password = document.getElementById('signupPassword').value;
            // Send AJAX request to signup servlet
            // Example:
            // $.post('SignupServlet', {firstName: firstName, lastName: lastName, email: email, phone: phone, username: username, password: password}, function(response) {
            //     // Handle response
            // });
        });
    </script>
</body>
</html>
