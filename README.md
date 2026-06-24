#🎬 Online Movie Ticket Booking System (ASP.NET)

This is a web-based Online Movie Ticket Booking System developed using ASP.NET (C#) and SQL Server. The system enables users to browse movies, book tickets online, select seats, and manage bookings, while administrators can efficiently manage movies, shows, users, and reports.

#🚀 Features

##👤 User Portal

- Register and log in securely.
- Browse available movies and show timings.
- View real-time seat availability.
- Select preferred seats and book tickets.
- Cancel booked tickets.

##🛠️ Admin Dashboard

- Add, update, and delete movie details.
- Schedule movie shows and timings.
- Manage seat allotments and booking status.
- Monitor user registrations and ticket bookings.

##📊 Reporting Management

Generate administrative reports using Crystal Reports:

- User Information Report
- Movie Details Report
- Date-wise Seat Allotment Report

##🔐 Secure Authentication

- Role-based authentication for Admin and User.
- Secure login and access control.

#🛠️ Technologies Used

Technology| Details
Framework| ASP.NET (C#)
IDE| Visual Studio 2012
Architecture| Web Forms
Database| SQL Server
Reporting| Crystal Reports 2012

#▶️ How to Run Locally

1. Clone the Repository

git clone https://github.com/anuja89/Online-Movie-Ticket-Booking.git

2. Database Setup

1. Open SQL Server Management Studio (SSMS).
2. Create a new database named "MovieTicketBookingDB".
3. Run the SQL script located in the "/Database" folder to create all required tables.

3. Configure Connection

1. Create a "Web.config" file in the project root.
2. Update the "connectionString" with your local SQL Server details.

4. Build and Run

1. Open the ".sln" file in Visual Studio 2012.
2. Build the solution.
3. Press F5 to run the project.

#📂 Project Structure

/Admin      → Admin module for managing movies, shows, users, and reports
/User       → User module for registration, login, and booking
/Booking    → Ticket booking, seat selection, and cancellation
/Reports    → Crystal Reports
/Database   → SQL database scripts
/Images     → Movie posters and related images
Web.config  → Configuration file

#🗄️ Database Setup

1. Open SQL Server Management Studio (SSMS).
2. Create a database named "MovieTicketBookingDB".
3. Execute the SQL script located in the "/Database" folder.
4. Update the "connectionString" in "Web.config" with your SQL Server credentials.

#⚠️ Important Note

For security reasons, the "Web.config" file is not included in this repository.

Please create your own "Web.config" file and update the "connectionString" according to your local SQL Server environment before running the project.

#👩‍💻 Author

Anuja Chavan
