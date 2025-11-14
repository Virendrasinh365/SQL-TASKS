# LibraryDB Management System

## About the Project
This project is a SQL database management system for a library. It is designed to manage authors, books, library members, and borrowing records. The system supports basic CRUD operations with integrity constraints and handles NULL values and default data appropriately.

## Project Objective
The main objective is to practice:
- Creating relational database tables with primary and foreign keys
- Inserting, updating, and deleting data
- Handling NULL values and default constraints
- Maintaining data integrity with foreign key relationships
- Writing queries to retrieve and manipulate data effectively

## Database Schema
The database comprises the following tables:
- **Authors**: Stores author details including name and country.
- **Books**: Contains book information linked to authors via foreign key, supports default copies available.
- **Members**: Manages library members' personal details.
- **Borrows**: Records the borrowing details linking books and members.

## SQL Operations Implemented
- Data insertion with handling of NULL fields and default values
- Updates including setting fields to NULL and conditional updates
- Deletes with WHERE clauses to clean unwanted data
- Usage of foreign keys to maintain referential integrity

## Example Use Cases
- Adding a new book without specifying the publisher (NULL usage)
- Updating member phone numbers to NULL for certain conditions
- Deleting members who lack an email address
- Querying books where authors are unknown (NULL foreign key)
  
## How to Run
- Use any SQL client or tool (e.g., DB Fiddle, SQLiteStudio, SQL Server Management Studio) to execute the provided SQL scripts.
- Create the database and tables using the schema file.
- Run the insert/update/delete scripts in sequence to populate and manipulate the data.

## Tools Used
- SQL language for database operations
- SQLite / SQL Server or any relational DBMS for implementation

## Learning Outcomes
- Understanding relational schema design
- Handling NULL versus default constraints
- Mastery of SQL DML commands (INSERT, UPDATE, DELETE)
- Ensuring database consistency through foreign keys and constraints

## Contact
For questions or feedback, reach out at [your email here].

---

*This project is part of the Elevate Labs SQL Developer Internship tasks.*
