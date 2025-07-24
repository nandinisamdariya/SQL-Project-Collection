## 👩‍💻 Author

**Nandini Samdariya**  
🧑‍🎓 MCA Graduate | 💼 Aspiring Data Analyst 
📧 nandini.samdariya10@email.com 
🔗 [LinkedIn](https://www.linkedin.com/in/nandinisamdariya) 

---

A mini relational database project built with **MySQL**, designed to simulate a functional **Airline Reservation System**. It manages flights, customers, seats, and bookings with automation and real-time availability views.

---

## 📋 Project Overview

This project covers core database concepts through an interactive Airline Reservation System, managing:

- 🛫 **Flights** – Departure, arrival, source, and destination data  
- 👤 **Customers** – Passenger details with email and phone number  
- 💺 **Seats** – Track availability of seats on each flight  
- 📄 **Bookings** – Records of seat bookings with status (Confirmed/Cancelled)  

---

## ⚙️ Key Features

✅ **Relational Database Design**  
✅ **Real-time Seat Booking Management**  
✅ **Automatic Trigger-based Seat Updates**  
✅ **User-Friendly Views for Quick Access**  

---

## 🧠 What You'll Learn

- Designing normalized relational schemas  
- Writing efficient SQL queries (CRUD)  
- Creating Triggers and Views  
- Managing foreign key constraints and status updates  
- Building ER Diagrams to visualize relationships  

---

## 🛠 Technologies Used

| Tool            | Purpose                                      |
|-----------------|----------------------------------------------|
| MySQL Workbench | Schema creation, ERD, trigger development    |
| SQL             | Queries, Views, DDL & DML operations         |
| ER Diagram Tool | Visualizing the entity-relationship structure |

---

## 📸 ER Diagram Preview

> *(Added ERD screenshot for GitHub viewers)*

---

## ✅ How It Works

- **Book a Seat**: Triggers mark the seat as booked (`is_booked = TRUE`)
- **Cancel Booking**: Triggers free up the seat (`is_booked = FALSE`)
- **Check Flights**: Use `AvailableFlights` view for open seats
- **Track Bookings**: Use `BookingSummary` view to get full reports

---

## 📂 Folder Structure

📁 Airline_Reservation_System/
├── 📄 schema.sql # Table definitions & constraints
├── 📄 data.sql # Sample INSERT queries
├── 📄 triggers.sql # Trigger creation queries
├── 📄 views.sql # Useful SQL views
├── 📄 README.md # You're here!

---

## ⭐ Show Some Love

If you like this project, feel free to:

- ⭐ Star this repository  
- 📥 Fork and try it yourself  
- ✅ Connect with me on LinkedIn  # ✈️ Airline Reservation System
