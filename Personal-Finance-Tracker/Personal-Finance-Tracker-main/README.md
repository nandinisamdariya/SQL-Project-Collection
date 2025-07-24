# 💰 Personal Finance Tracker using SQL + Tableau

A complete beginner-friendly project to track, manage, and visualize monthly personal expenses using **MySQL** for backend data management and **Tableau** for dashboards.

---

## 👩‍💻 Author
**Nandini Samdariya**  
Email: [nandini.samdariya10@gmail.com](mailto:nandini.samdariya10@gmail.com)

---

## 🧠 Objective

Design and implement a personal finance database that:
- Tracks **income** and **expenses**
- Categorizes spending
- Computes monthly and category-wise totals
- Visualizes data using Tableau
- Helps users understand their financial behavior

---

## 🛠️ Tools Used

| Tool        | Purpose                         |
|-------------|----------------------------------|
| MySQL Workbench | Database design and querying   |
| Tableau Desktop | Data visualization and dashboard |
| CSV Export  | Data transfer from SQL to Tableau |

---

## 🗃️ SQL Database Schema

- `Users` — stores user info  
- `Categories` — predefined spending categories  
- `Income` — logs user's income  
- `Expenses` — logs user's expenses by category  

---

## 🧾 Key Features

✅ Tracks multiple users  
✅ Categorizes expenses (Rent, Travel, Groceries, etc.)  
✅ Calculates monthly spending and balance  
✅ View for `UserBalance` showing income - expenses  
✅ Tableau dashboard of June expenses  

---

## 📊 Tableau Visuals

### 🔹 Monthly June Expenses Dashboard
![Dashboard](screenshot_dashboard.png)

### 🔹 Detailed Worksheet View
![Worksheet](screenshot_worksheet.png)

---

## 📤 Export Instructions (SQL to Tableau)

1. Run the June monthly report query in MySQL.
2. Export result grid → Save as `Monthly_Expense_Report_June2025.csv`
3. Open Tableau → Connect to CSV → Build charts
4. Create bar charts grouped by `UserName`, `CategoryName`, and `ExpenseDate`

---

## 📌 Learnings
Practiced SQL queries, joins, views, and data aggregation

Worked with real-world financial data

Created visual dashboards using Tableau

Understood the connection between backend and BI tools

---

## 📌 SQL Code Snippet

```sql
-- View user balance
CREATE VIEW UserBalance AS
SELECT 
    U.UserName,
    COALESCE(SUM(I.Amount), 0) AS TotalIncome,
    COALESCE((SELECT SUM(E.Amount) FROM Expenses E WHERE E.UserID = U.UserID), 0) AS TotalExpenses,
    COALESCE(SUM(I.Amount), 0) - COALESCE((SELECT SUM(E.Amount) FROM Expenses E WHERE E.UserID = U.UserID), 0) AS CurrentBalance
FROM Users U
LEFT JOIN Income I ON U.UserID = I.UserID
GROUP BY U.UserID;

---


