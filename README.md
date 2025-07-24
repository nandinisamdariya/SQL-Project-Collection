# SQL Project Collection by Nandini Samdariya

This repository contains three distinct SQL-based projects demonstrating database design, data manipulation, and real-world use cases.

---
## Author

**Nandini Samdariya**  
MCA Graduate | Data Analytics Enthusiast  
[LinkedIn](https://www.linkedin.com/in/nandinisamdariya) | [GitHub](https://github.com/nandinisamdariya)  
Email: nandini.samdariya10@email.com

---

## Projects Included

### 1. Airline Reservation System
- MySQL-based system managing flights, customers, seats, and bookings.
- Includes real-time seat availability, automatic booking status updates via triggers, and user-friendly views.
- Focuses on relational schema design and trigger-based automation.

### 2. Personal Finance Tracker
- MySQL database to track user income and expenses by categories.
- Calculates monthly balances and spending summaries.
- Integrated with Tableau for data visualization and dashboard creation.

### 3. Employee Management & Attendance Tracker
- PostgreSQL system to manage employee details, roles, departments, and attendance tracking.
- Automated dummy data generation using SQL loops and `generate_series()`.
- Features triggers and functions for attendance status, working hours, and monthly summaries.
---

## Tools & Technologies Used
- PostgreSQL, MySQL Workbench
- pgAdmin 4
- SQL scripting (DDL, DML, Triggers, Views)
- Tableau Desktop (for Personal Finance project visualization)

---
## Report of Employee Management & Attendance Tracker 
Includes a detailed project report (`Employee Management & Attendance Tracker Report.pdf`).

## How Dummy Data Was Created (Summary)
- Employee Attendance Tracker uses loops and `generate_series()` to simulate realistic attendance data.
- Other projects include manually inserted sample data and example SQL scripts.

---

## Folder Structure

```plaintext
SQL-Project-Collection/
├── Airline-Reservation-System/
│   ├── schema.sql
│   ├── data.sql
│   ├── triggers.sql
│   ├── views.sql
│   └── README.md
│
├── Personal-Finance-Tracker/
│   ├── schema.sql
│   ├── data.sql
│   ├── views.sql
│   ├── tableau-dashboard/  # Tableau files, screenshots
│   └── README.md
│
├── Employee-Attendance-Tracker/
│   ├── schema.sql          # Table creation, constraints
│   ├── data.sql            # Dummy data insert scripts
│   ├── functions.sql       # Stored procedures, functions
│   ├── triggers.sql        # Trigger definitions
│   └── README.md           # (Optional) Project-specific README
│
└── README.md               # Main combined README file 




