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

-- Inserting Authors
INSERT INTO Authors (AuthorID, AuthorName, Country) VALUES
(1, 'George Orwell', 'United Kingdom'),
(2, 'Haruki Murakami', 'Japan'),
(3, 'J.K. Rowling', 'United Kingdom'),
(4, 'Jane Austen', NULL);

-- Inserting Books
INSERT INTO Books (BookID, Title, AuthorID, Publisher, ISBN, CopiesAvailable) VALUES
(1001, '1984', 1, 'Secker & Warburg', 'ISBN1111111111', 5),
(1002, 'Kafka on the Shore', 2, 'Shinchosha', 'ISBN2222222222', 3),
(1003, 'Harry Potter and the Philosopher''s Stone', 3, 'Bloomsbury', 'ISBN3333333333', 7),
(1004, 'Pride and Prejudice', 4, 'T. Egerton', 'ISBN4444444444', NULL),
(1005, 'Untitled Book', NULL, NULL, 'ISBN5555555555', NULL);

-- Inserting Members
INSERT INTO Members (MemberID, Name, Email, Phone, Address) VALUES
(201, 'Alice Johnson', 'alice.johnson@example.com', '555-1234', '123 Maple St'),
(202, 'Bob Smith', NULL, NULL, '456 Oak St'),
(203, 'Charlie Brown', 'charlie.brown@example.com', '555-5678', NULL);

-- Inserting Borrow Records
INSERT INTO Borrows (BorrowID, BookID, MemberID, BorrowDate, ReturnDate) VALUES
(301, 1001, 201, '2025-10-01', '2025-10-15'),
(302, 1003, 202, '2025-10-05', NULL),
(303, 1002, 203, '2025-10-07', '2025-10-20');

-- Update example: Set CopiesAvailable where NULL to default 1
UPDATE Books SET CopiesAvailable = 1 WHERE CopiesAvailable IS NULL;

-- Update example: Set Phone to NULL for Bob Smith
UPDATE Members SET Phone = NULL WHERE MemberID = 202;

-- Delete example: Remove Members with no Email
DELETE FROM Members WHERE Email IS NULL;

-- Select examples
SELECT * FROM Authors;
SELECT * FROM Books;
SELECT * FROM Members;
SELECT * FROM Borrows;

-- Task 3: Basic SELECT Queries

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

-- Show all books published by 'Bloomsbury' or 'Secker Warburg'
SELECT Title, Publisher
FROM Books
WHERE Publisher IN ('Bloomsbury', 'Secker Warburg');

-- Find books with ISBNs between two values
SELECT Title, ISBN
FROM Books
WHERE ISBN BETWEEN 'ISBN1111111111' AND 'ISBN3333333333';
