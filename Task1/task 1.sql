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
    FOREIGN KEY (AuthorID) REFERENCES Author(AuthorID)
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
    FOREIGN KEY (BookID) REFERENCES Book(BookID),
    FOREIGN KEY (MemberID) REFERENCES Member(MemberID)
);
