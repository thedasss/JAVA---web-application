<%@ page contentType="text/html;charset=UTF-8" language="java" import="models.Payment" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>User Payment</title>
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
        <h2 class="mb-4">Make Payment</h2>
        <!-- Payment Form -->
        <form id="paymentForm" action="payments?action=add" method = "post">
            <!-- Display User ID -->
            <div class="mb-3">
                <label for="userId" class="form-label">User ID</label>
                <input type="text" class="form-control" name="userId" id="userId" value="<%= session.getAttribute("loggedInUser") %>" readonly>
            </div>
            <!-- Payment Details -->
            <div class="mb-3">
                <label for="cardNo" class="form-label">Card Number</label>
                <input type="text" name="cardNo"  class="form-control" id="cardNo" required>
            </div>
            <div class="mb-3">
                <label for="bankName" class="form-label">Bank Name</label>
                <input type="text"  name="bankName" class="form-control" id="bankName" required>
            </div>
            <div class="mb-3">
                <label for="amount" class="form-label">Amount</label>
                <input type="number" name = "amount"  class="form-control" id="amount" min="0" step="0.01" required>
            </div>
            <button type="submit" class="btn btn-primary">Pay Now</button>
        </form>
    </div>

    <!-- Bootstrap JS (Optional) -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <!-- jQuery (Optional, if you are using AJAX) -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script>
       
    </script>
</body>
</html>
