<%@ page contentType="text/html;charset=UTF-8" language="java" import="java.util.List, models.SiteUser" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Site Users List</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
    $(document).ready(function() {
        $('#searchInput').on('keyup', function() {
            var value = $(this).val().toLowerCase();
            $('#usersTable tbody tr').filter(function() {
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
            <h2>Site Users List</h2>
            <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addUserModal">Add User</button>
        </div>
        <hr class="hr" />

        <!-- Search input -->
        <input type="text" id="searchInput" class="form-control mb-3" placeholder="Search by First Name, Last Name, or Username...">

        <table class="table table-striped" id="usersTable">
            <thead>
                <tr>
                    <th>User ID</th>
                    <th>First Name</th>
                    <th>Last Name</th>
                    <th>Email</th>
                    <th>Phone</th>
                    <th>Username</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <% 
                List<SiteUser> users = (List<SiteUser>) request.getAttribute("users");
                for (SiteUser user : users) {
                %>
                    <tr>
                        <td><%= user.getUserID() %></td>
                        <td><%= user.getFirstName() %></td>
                        <td><%= user.getLastName() %></td>
                        <td><%= user.getEmail() %></td>
                        <td><%= user.getPhone() %></td>
                        <td><%= user.getUsername() %></td>
                        <td>
                            <button type="button" class="btn btn-primary" onclick="openEditModal(<%= user.getUserID() %>, '<%= user.getFirstName() %>', '<%= user.getLastName() %>', '<%= user.getEmail() %>', '<%= user.getPhone() %>', '<%= user.getUsername() %>')">Edit</button>
                            <button type="button" class="btn btn-danger" onclick="confirmDelete(<%= user.getUserID() %>)">Delete</button>
                        </td>
                    </tr>
                <% } %>
            </tbody>
        </table>
    </div>

    <!-- Add User Modal -->
    <div class="modal fade" id="addUserModal" tabindex="-1" aria-labelledby="addUserModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="addUserModalLabel">Add User</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <!-- Add user form -->
                    <form id="addUserForm" action="users" method="post">
                        <input type="hidden" name="action" value="add"> <!-- To differentiate between add and update -->
                        <div class="mb-3">
                            <label for="firstName" class="form-label">First Name</label>
                            <input type="text" class="form-control" id="firstName" name="firstName" required>
                        </div>
                        <div class="mb-3">
                            <label for="lastName" class="form-label">Last Name</label>
                            <input type="text" class="form-control" id="lastName" name="lastName" required>
                        </div>
                        <div class="mb-3">
                            <label for="email" class="form-label">Email</label>
                            <input type="email" class="form-control" id="email" name="email" required>
                        </div>
                        <div class="mb-3">
                            <label for="phone" class="form-label">Phone</label>
                            <input type="text" class="form-control" id="phone" name="phone">
                        </div>
                        <div class="mb-3">
                            <label for="username" class="form-label">Username</label>
                            <input type="text" class="form-control" id="username" name="username" required>
                        </div>
                        <div class="mb-3">
                            <label for="password" class="form-label">Password</label>
                            <input type="password" class="form-control" id="password" name="password" required>
                        </div>
                        <button type="submit" class="btn btn-primary">Submit</button>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <!-- Edit User Modal -->
    <div class="modal fade" id="editUserModal" tabindex="-1" aria-labelledby="editUserModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="editUserModalLabel">Edit User</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <!-- Edit user form -->
                    <form id="editUserForm" action="users" method="post">
                        <input type="hidden" id="edit-user-id" name="userID">
                        <div class="mb-3">
                            <label for="edit-firstName" class="form-label">First Name</label>
                            <input type="text" class="form-control" id="edit-firstName" name="firstName" required>
                        </div>
                        <div class="mb-3">
                            <label for="edit-lastName" class="form-label">Last Name</label>
                            <input type="text" class="form-control" id="edit-lastName" name="lastName" required>
                        </div>
                        <div class="mb-3">
                            <label for="edit-email" class="form-label">Email</label>
                            <input type="email" class="form-control" id="edit-email" name="email" required>
                        </div>
                        <div class="mb-3">
                            <label for="edit-phone" class="form-label">Phone</label>
                            <input type="text" class="form-control" id="edit-phone" name="phone">
                        </div>
                        <div class="mb-3">
                            <label for="edit-username" class="form-label">Username</label>
                            <input type="text" class="form-control" id="edit-username" name="username" required>
                        </div>
                        <div class="mb-3">
                            <label for="edit-password" class="form-label">Password</label>
                            <input type="password" class="form-control" id="edit-password" name="password" required>
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
        function openEditModal(userId, firstName, lastName, email, phone, username) {
            $('#edit-user-id').val(userId);
            $('#edit-firstName').val(firstName);
            $('#edit-lastName').val(lastName);
            $('#edit-email').val(email);
            $('#edit-phone').val(phone);
            $('#edit-username').val(username);
            $('#editUserModal').modal('show');
        }

        function confirmDelete(userId) {
            if (confirm('Are you sure you want to delete this user?')) {
                window.location.href = 'users?action=delete&userID=' + userId;
            }
        }
    </script>
</body>
</html>
