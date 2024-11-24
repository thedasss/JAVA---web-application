CREATE TABLE siteusers (
    UserID INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(100) NOT NULL,
    Phone VARCHAR(20),
    Username VARCHAR(50) NOT NULL,
    Password VARCHAR(100) NOT NULL
);
CREATE TABLE Movies (
    id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(255) NOT NULL,
    genre VARCHAR(255),
    year INT,
    director VARCHAR(255),
    imageUrl VARCHAR(255),
    videoUrl VARCHAR(255)
);
-- Create Payment Table
CREATE TABLE Payment (
    PaymentID INT PRIMARY KEY AUTO_INCREMENT,
    SiteUserID INT,
    FullName VARCHAR(255),
    Email VARCHAR(255),
    CardNo VARCHAR(16),
    BankName VARCHAR(255),
    Amount DECIMAL(10, 2)
);

CREATE TABLE MovieReviews (
    id INT AUTO_INCREMENT PRIMARY KEY,
    movieId INT,
    review TEXT,
    rating DECIMAL(3, 2),
    FOREIGN KEY (movieId) REFERENCES Movies(id) ON DELETE CASCADE
);
