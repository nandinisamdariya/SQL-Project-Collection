-- 🧾 Project: Personal Finance Tracker using SQL (MySQL Workbench)
-- 👩‍💻 Author: Nandini Samdariya

-- 🎯 Objective:
-- Build a personal finance tracking database to store income and expense data,
-- categorize spending, track balances, and generate monthly reports.
-- 
-- 💡 Key Features:
-- - Tracks multiple users
-- - Categorizes expenses
-- - Calculates monthly and category-wise spending
-- - Tracks balance using a SQL view
-- - Supports exporting reports for analysis

-- ================================
-- Step 1: Use the database
-- ================================
USE personalfinance;

-- ================================
-- Step 2: Create Tables
-- ================================

-- Users table to store personal details
CREATE TABLE Users (
    UserID INT PRIMARY KEY AUTO_INCREMENT,
    UserName VARCHAR(100),
    Email VARCHAR(100)
);

-- Categories table to define types of expenses
CREATE TABLE Categories (
    CategoryID INT PRIMARY KEY AUTO_INCREMENT,
    CategoryName VARCHAR(100)
);

-- Income table to record salary or freelance income
CREATE TABLE Income (
    IncomeID INT PRIMARY KEY AUTO_INCREMENT,
    UserID INT,
    Amount DECIMAL(10,2),
    IncomeDate DATE,
    Source VARCHAR(100),
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
);

-- Expenses table to track spending by category and description
CREATE TABLE Expenses (
    ExpenseID INT PRIMARY KEY AUTO_INCREMENT,
    UserID INT,
    Amount DECIMAL(10,2),
    ExpenseDate DATE,
    CategoryID INT,
    Description VARCHAR(255),
    FOREIGN KEY (UserID) REFERENCES Users(UserID),
    FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID)
);

-- ================================
-- Step 3: Insert Dummy Data
-- ================================

-- Inserting users
INSERT INTO Users (UserName, Email) VALUES
('Nandini Samdariya', 'nandini10@gmail.com'),
('Nistha Samdariya', 'nistha21@gmail.com');

-- Inserting expense categories
INSERT INTO Categories (CategoryName) VALUES
('Groceries'), ('Rent'), ('Utilities'), ('Entertainment'), ('Travel');

-- Inserting income records for users
INSERT INTO Income (UserID, Amount, IncomeDate, Source) VALUES
(1, 50000, '2025-06-01', 'Salary'),
(2, 10000, '2025-06-10', 'Freelance');

-- Inserting expenses for User 1: Nandini
INSERT INTO Expenses (UserID, Amount, ExpenseDate, CategoryID, Description) VALUES
(1, 5500.00, '2025-06-02', 1, 'Monthly groceries'),
(1, 15000.00, '2025-06-03', 2, 'Apartment Rent'),
(1, 2300.00, '2025-06-05', 3, 'Electricity and Water bills'),
(1, 1200.00, '2025-06-06', 4, 'Netflix subscription'),
(1, 3000.00, '2025-06-15', 5, 'Train tickets to hometown');

-- Inserting expenses for User 2: Nistha
INSERT INTO Expenses (UserID, Amount, ExpenseDate, CategoryID, Description) VALUES
(2, 3000.00, '2025-06-02', 1, 'Groceries for June'),
(2, 7000.00, '2025-06-05', 2, 'PG Rent'),
(2, 1500.00, '2025-06-06', 3, 'Electricity and WiFi'),
(2, 800.00, '2025-06-07', 4, 'Movie tickets'),
(2, 1200.00, '2025-06-11', 5, 'Cab fares during trip');

-- ================================
-- Step 4: Monthly Expense Summary
-- ================================

-- Summarize expenses by user for each month
SELECT 
    U.UserName,
    MONTH(E.ExpenseDate) AS ExMonth,
    YEAR(E.ExpenseDate) AS ExYear,
    SUM(E.Amount) AS TotalMonthlyExpense
FROM Expenses E
JOIN Users U ON E.UserID = U.UserID 
GROUP BY U.UserName, YEAR(E.ExpenseDate), MONTH(E.ExpenseDate)
ORDER BY U.UserName, ExYear, ExMonth;

-- ================================
-- Step 5: Category-wise Expense Summary
-- ================================

-- Total spent by each user for each category
SELECT 
    U.UserName, 
    C.CategoryName,
    SUM(E.Amount) AS TotalSpent
FROM Expenses E
JOIN Users U ON E.UserID = U.UserID 
JOIN Categories C ON E.CategoryID = C.CategoryID
GROUP BY U.UserName, C.CategoryName
ORDER BY U.UserName, TotalSpent DESC;

-- ================================
-- Step 6: Create View for User Balance
-- ================================

-- View shows total income, total expense, and current balance for each user
CREATE VIEW UserBalance AS
SELECT 
    U.UserName,
    COALESCE(SUM(I.Amount), 0) AS TotalIncome,
    COALESCE((
        SELECT SUM(E.Amount)
        FROM Expenses E
        WHERE E.UserID = U.UserID
    ), 0) AS TotalExpenses,
    COALESCE(SUM(I.Amount), 0) - 
    COALESCE((
        SELECT SUM(E.Amount)
        FROM Expenses E
        WHERE E.UserID = U.UserID
    ), 0) AS CurrentBalance
FROM Users U
LEFT JOIN Income I ON U.UserID = I.UserID
GROUP BY U.UserID;

-- View the balance
SELECT * FROM UserBalance;

-- ================================
-- Step 7: Exportable Monthly Report
-- ================================

-- Detailed expense report for June (export as CSV from MySQL Workbench)
SELECT 
    U.UserName,
    E.ExpenseDate,
    C.CategoryName,
    E.Amount,
    E.Description
FROM Expenses E
JOIN Users U ON E.UserID = U.UserID
JOIN Categories C ON E.CategoryID = C.CategoryID
WHERE MONTH(E.ExpenseDate) = 6
ORDER BY U.UserName, E.ExpenseDate;

-- 📤 Export Instructions (for MySQL Workbench):
-- 1. Run the above query.
-- 2. Right-click on result grid → "Export Resultset"
-- 3. Save as CSV: Monthly_Expense_Report_June2025.csv

