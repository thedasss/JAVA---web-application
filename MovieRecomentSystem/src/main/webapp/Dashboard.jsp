<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Dashboard</title>
    <style>
        body {
            margin: 0;
            padding: 0;
            font-family: Arial, sans-serif;
            background-image: url('https://www.notebookcheck.net/fileadmin/Notebooks/News/_nc3/netflixteaser.png');
            background-size: cover;
            background-position: center;
            height: 100vh;
            overflow: hidden;
            display: flex;
            justify-content: center;
            align-items: center;
            color: #fff;
        }
        .container {
            text-align: center;
        }
        h1 {
            font-size: 3rem;
            margin-bottom: 30px;
        }
        .button {
            padding: 10px 20px;
            font-size: 1.2rem;
            background-color: #e50914;
            border: none;
            border-radius: 5px;
            color: #fff;
            cursor: pointer;
            transition: background-color 0.3s;
        }
        .button:hover {
            background-color: #d10812;
        }
    </style>
</head>
<body>
    <div class="container">
    
          <a href= "/MovieRecomentSystem/users?action=list" class="button">Users</a>
          <a href= "/MovieRecomentSystem/movies?action=list"  class="button">Movies & Content</a>
          <a href= "/MovieRecomentSystem/payments?action=list" class="button">Payments</a>
          <a href="movies?action=user" class="button">Get Started</a>
    </div>
</body>
</html>
