<%@ page contentType="text/html;charset=UTF-8" language="java" import="java.util.List, models.Payment" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Payment List</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
    $(document).ready(function() {
        $('#searchInput').on('keyup', function() {
            var value = $(this).val().toLowerCase();
            $('#paymentsTable tbody tr').filter(function() {
                $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
            });
        });
    });

    function confirmDelete(paymentID) {
        if (confirm('Are you sure you want to delete this payment?')) {
            window.location.href = 'payments?action=delete&id=' + paymentID;
        }
    }
    </script>
</head>
<body style="padding:20px">
    <div class="container">
        <div class="d-flex justify-content-between">
            <a href="Dashboard.jsp" class="btn btn-secondary">Back to Dashboard</a>
            <h2>Payment List</h2>
        </div>
        <hr class="hr" />

        <!-- Search input -->
        <input type="text" id="searchInput" class="form-control mb-3" placeholder="Search by UserID, Full Name, Email, or Card No...">

        <table class="table table-striped" id="paymentsTable">
            <thead>
                <tr>
                    <th>Payment ID</th>
                    <th>User ID</th>
                    <th>Full Name</th>
                    <th>Email</th>
                    <th>Card No</th>
                    <th>Bank Name</th>
                    <th>Amount</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <% 
                List<Payment> payments = (List<Payment>) request.getAttribute("payments");
                for (Payment payment : payments) {
                %>
                    <tr>
                        <td><%= payment.getPaymentID() %></td>
                        <td><%= payment.getSiteUserID() %></td>
                        <td><%= payment.getFullName() %></td>
                        <td><%= payment.getEmail() %></td>
                        <td><%= payment.getCardNo() %></td>
                        <td><%= payment.getBankName() %></td>
                        <td><%= payment.getAmount() %></td>
                        <td>
                            <button type="button" class="btn btn-danger" onclick="confirmDelete(<%= payment.getPaymentID() %>)">Delete</button>
                        </td>
                    </tr>
                <% } %>
            </tbody>
        </table>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.min.js" integrity="sha384-cuYeSxntonz0PPNlHhBs68uyIAVpIIOZZ5JqeqvYYIcEL727kskC66kF92t6Xl2V" crossorigin="anonymous"></script>
</body>
</html>
