-- Step 1: Create Database
CREATE DATABASE LibraryDB;

-- Step 2: Create Table - Author
CREATE TABLE Authors (
    AuthorID INT PRIMARY KEY,
    AuthorName VARCHAR(100) NOT NULL,
    Country VARCHAR(50)
);

-- Step 3: Create Table - Book
CREATE TABLE Books (
    BookID INT PRIMARY KEY,
    Title VARCHAR(150) NOT NULL,
    AuthorID INT,
    Publisher VARCHAR(100),
    ISBN VARCHAR(20) UNIQUE,
    CopiesAvailable INT DEFAULT 1,
    FOREIGN KEY (AuthorID) REFERENCES Authors(AuthorID)
);

-- Step 4: Create Table - Member
CREATE TABLE Members (
    MemberID INT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Email VARCHAR(100) UNIQUE,
    Phone VARCHAR(15),
    Address VARCHAR(200)
);

-- Step 5: Create Table - Borrow
CREATE TABLE Borrows (
    BorrowID INT PRIMARY KEY,
    BookID INT,
    MemberID INT,
    BorrowDate DATE,
    ReturnDate DATE,
    FOREIGN KEY (BookID) REFERENCES Books(BookID),
    FOREIGN KEY (MemberID) REFERENCES Members(MemberID)
);

-- Insert sample data
INSERT INTO Authors (AuthorID, AuthorName, Country) VALUES
(1, 'George Orwell', 'United Kingdom'),
(2, 'Haruki Murakami', 'Japan'),
(3, 'J.K. Rowling', 'United Kingdom'),
(4, 'Jane Austen', NULL);

INSERT INTO Books (BookID, Title, AuthorID, Publisher, ISBN, CopiesAvailable) VALUES
(1, '1984', 1, 'Secker & Warburg', 'ISBN1234567890', 5),
(2, 'Kafka on the Shore', 2, 'Shinchosha', 'ISBN0987654321', 2),
(3, 'Harry Potter and the Philosopher\'s Stone', 3, 'Bloomsbury', 'ISBN1111111111', 3),
(4, 'Pride and Prejudice', 4, NULL, 'ISBN2222222222', 4);

INSERT INTO Members (MemberID, Name, Email, Phone, Address) VALUES
(1, 'Alice Johnson', 'alice@example.com', '1234567890', '123 Maple St'),
(2, 'Bob Smith', 'bob@example.com', '0987654321', '456 Oak St');

INSERT INTO Borrows (BorrowID, BookID, MemberID, BorrowDate, ReturnDate) VALUES
(1, 1, 1, '2025-11-01', NULL),
(2, 3, 2, '2025-11-10', '2025-11-15'),
(3, 2, 1, '2025-10-20', NULL);

-- Task 3: Writing Basic SELECT Queries

-- Select all authors from the UK
SELECT AuthorName, Country
FROM Authors
WHERE Country = 'United Kingdom';

-- List all books with more than 3 copies available, ordered by number of copies descending
SELECT Title, CopiesAvailable
FROM Books
WHERE CopiesAvailable > 3
ORDER BY CopiesAvailable DESC;

-- Show all members whose names start with 'A'
SELECT Name, Email
FROM Members
WHERE Name LIKE 'A%';

-- Get details of books borrowed but not yet returned
SELECT B.Title, M.Name, BR.BorrowDate
FROM Borrows BR
JOIN Books B ON BR.BookID = B.BookID
JOIN Members M ON BR.MemberID = M.MemberID
WHERE BR.ReturnDate IS NULL
ORDER BY BR.BorrowDate ASC;

-- List the first 2 borrow records (limited output)
SELECT *
FROM Borrows
ORDER BY BorrowDate DESC
LIMIT 2;

-- Show distinct countries from authors table
SELECT DISTINCT Country
FROM Authors
WHERE Country IS NOT NULL;

-- Show all books published by 'Bloomsbury' or 'Secker & Warburg'
SELECT Title, Publisher
FROM Books
WHERE Publisher IN ('Bloomsbury', 'Secker & Warburg');

-- Find books with ISBNs between two values
SELECT Title, ISBN
FROM Books
WHERE ISBN BETWEEN 'ISBN1111111111' AND 'ISBN3333333333';

-- Task 4: Aggregate Functions and Grouping

-- Count the total number of books in the library
SELECT COUNT(*) AS TotalBooks
FROM Books;

-- Find the average number of copies available per book
SELECT AVG(CopiesAvailable) AS AverageCopies
FROM Books;

-- List the total number of books by each author
SELECT A.AuthorName, COUNT(B.BookID) AS BookCount
FROM Books B
JOIN Authors A ON B.AuthorID = A.AuthorID
GROUP BY A.AuthorName;

-- Show the number of members from each address (grouped)
SELECT Address, COUNT(MemberID) AS TotalMembers
FROM Members
GROUP BY Address;

-- Get the sum of total copies per publisher (shows which publishers supply more books)
SELECT Publisher, SUM(CopiesAvailable) AS TotalCopies
FROM Books
GROUP BY Publisher;

-- For each author, show the average copies per book, only if average is more than 2
SELECT A.AuthorName, AVG(B.CopiesAvailable) AS AvgCopies
FROM Books B
JOIN Authors A ON B.AuthorID = A.AuthorID
GROUP BY A.AuthorName
HAVING AVG(B.CopiesAvailable) > 2;

-- Round off the average number of copies per publisher to 1 decimal place
SELECT Publisher, ROUND(AVG(CopiesAvailable), 1) AS AvgCopies
FROM Books
GROUP BY Publisher;

-- Count total books borrowed by each member
SELECT M.Name, COUNT(BR.BorrowID) AS TotalBorrowed
FROM Borrows BR
JOIN Members M ON BR.MemberID = M.MemberID
GROUP BY M.Name;

-- Count the distinct number of countries authors are from
SELECT COUNT(DISTINCT Country) AS DistinctCountries
FROM Authors;

-- Task 5: SQL Joins (Inner, Left, Right, Full)

-- INNER JOIN: Get all borrow records with book titles and member names where matching records exist
SELECT BR.BorrowID, B.Title, M.Name, BR.BorrowDate, BR.ReturnDate
FROM Borrows BR
INNER JOIN Books B ON BR.BookID = B.BookID
INNER JOIN Members M ON BR.MemberID = M.MemberID;

-- LEFT JOIN: List all books and their borrower names if any (NULL if not borrowed)
SELECT B.Title, M.Name AS BorrowerName
FROM Books B
LEFT JOIN Borrows BR ON B.BookID = BR.BookID
LEFT JOIN Members M ON BR.MemberID = M.MemberID;

-- RIGHT JOIN: List all members and titles of books they borrowed (NULL if none)
-- (Note: Some databases like MySQL do not support RIGHT JOIN, emulate with LEFT JOIN by reversing tables if needed)
SELECT M.Name, B.Title
FROM Members M
RIGHT JOIN Borrows BR ON M.MemberID = BR.MemberID
RIGHT JOIN Books B ON BR.BookID = B.BookID;

-- FULL OUT
