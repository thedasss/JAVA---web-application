<%@ page contentType="text/html;charset=UTF-8" language="java" import="models.SiteUser" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>User Profile</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Custom CSS for Dark Theme -->
    <style>
        body {
            background-color: #343a40; /* Dark background */
            padding: 20px;
            color: #fff; /* Light text */
        }
        .container {
            max-width: 500px;
            margin: auto;
            background-color: #212529; /* Dark container background */
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(255, 255, 255, 0.1); /* Light shadow */
        }
        .form-label {
            color: #fff; /* Light form labels */
        }
        .form-control {
            background-color: #454d55; /* Dark form control background */
            color: #fff; /* Light form control text */
        }
        .btn-primary {
            background-color: #007bff; /* Primary button color */
            border-color: #007bff;
        }
        .btn-primary:hover {
            background-color: #0056b3; /* Darker hover color */
            border-color: #0056b3;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2 class="mb-4">User Profile</h2>
        <!-- User Profile Form -->
        <form id="profileForm" action="users" method="post">
            <input type="hidden" name="action" value="edit">
              <input type="hidden" name="from" value="prfoile">
            <input type="hidden" name="userID" value="<%= ((SiteUser)request.getAttribute("user")).getUserID() %>">
            <div class="mb-3">
                <label for="firstName" class="form-label">First Name</label>
                <input type="text" class="form-control" id="firstName" name="firstName" value="<%= ((SiteUser)request.getAttribute("user")).getFirstName() %>" required>
            </div>
            <div class="mb-3">
                <label for="lastName" class="form-label">Last Name</label>
                <input type="text" class="form-control" id="lastName" name="lastName" value="<%= ((SiteUser)request.getAttribute("user")).getLastName() %>" required>
            </div>
            <div class="mb-3">
                <label for="email" class="form-label">Email</label>
                <input type="email" class="form-control" id="email" name="email" value="<%= ((SiteUser)request.getAttribute("user")).getEmail() %>" required>
            </div>
            <div class="mb-3">
                <label for="phone" class="form-label">Phone</label>
                <input type="text" class="form-control" id="phone" name="phone" value="<%= ((SiteUser)request.getAttribute("user")).getPhone() %>" required>
            </div>
            <div class="mb-3">
                <label for="username" class="form-label">Username</label>
                <input type="text" class="form-control" id="username" name="username" value="<%= ((SiteUser)request.getAttribute("user")).getUsername() %>" required>
            </div>
            <div class="mb-3">
         
                <input  value="<%= ((SiteUser)request.getAttribute("user")).getPassword() %>" type="hidden" class="form-control" id="password" name="password" required>
            </div>
            <button type="submit" class="btn btn-primary">Update</button>
            <a href="users?from=prfole&action=delete&userID=<%= ((SiteUser)request.getAttribute("user")).getUserID() %>" class="btn btn-danger">Delete Account</a>
        </form>
    </div>

    <!-- Bootstrap JS (Optional) -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
