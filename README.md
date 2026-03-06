# Ocean View Resort - Hotel Reservation System

A comprehensive hotel reservation management system built with Java, JSP, Servlets, and MySQL.

## 📋 Project Overview

Ocean View Resort Reservation System is a web-based application designed to manage hotel reservations, billing, and guest information. The system provides a complete solution for hotel staff to handle daily operations including booking management, check-in/check-out processes, and billing.

## ✨ Features

### 🔐 User Authentication
- Secure login system for hotel staff
- Session management and authentication
- Logout functionality

### 🏨 Reservation Management
- **Add Reservations**: Create new room reservations with guest details
- **View Reservations**: Display all current reservations in a table format
- **Update Reservations**: Modify existing reservation details
- **Delete Reservations**: Remove reservations with confirmation
- Date validation (Check-out must be after Check-in)
- Room type selection (Standard, Deluxe, Suite)

### 💰 Billing System
- Automatic bill calculation based on:
  - Number of nights
  - Room type pricing
  - Check-in and check-out dates
- Invoice generation and printing
- Bill history storage
- Payment status tracking

### 📊 Dashboard
- Real-time statistics:
  - Total and available rooms
   - Occupied, maintenance, and cleaning room counts
  - Today's check-ins and check-outs
  - Total reservations
   - Total system users and revenue
  - Pending bills notifications
- Room status overview
- Dynamic date display and recent booking feed

### 🛏️ Room Management (MVP)
- Add rooms with room number, type, price, and status
- Change room status in one click (AVAILABLE, OCCUPIED, MAINTENANCE, CLEANING)
- Room inventory table for operational room-level tracking

### 👥 User Account Management (MVP)
- Create new user accounts (admin, staff, manager)
- View and delete existing user accounts
- Live user count shown on dashboard

### 🎨 User Interface
- Modern, responsive design
- Intuitive navigation with sidebar menu
- Success/error message notifications
- Print-friendly invoice layout
- Font Awesome icons integration

## 🛠️ Technology Stack

### Backend
- **Java**: Core programming language
- **Java Servlets**: Request handling and business logic
- **JSP (JavaServer Pages)**: Dynamic web pages
- **JDBC**: Database connectivity
- **Maven**: Dependency management

### Frontend
- **HTML5**: Structure
- **CSS3**: Styling
- **JavaScript**: Client-side validation and interactivity
- **Font Awesome**: Icons

### Database
- **MySQL 8.0**: Data storage

### Server
- **Apache Tomcat**: Web server

## 📁 Project Structure

```
oceanview-prod/
├── src/
│   ├── main/
│   │   ├── java/
│   │   │   └── com/icbt/
│   │   │       ├── controller/      # Servlets
│   │   │       │   ├── LoginServlet.java
│   │   │       │   ├── LogoutServlet.java
│   │   │       │   ├── ReservationServlet.java
│   │   │       │   ├── UpdateReservationServlet.java
│   │   │       │   ├── DeleteReservationServlet.java
│   │   │       │   └── BillServlet.java
│   │   │       ├── dao/              # Data Access Objects
│   │   │       │   ├── DBConnection.java
│   │   │       │   ├── UserDAO.java
│   │   │       │   ├── ReservationDAO.java
│   │   │       │   ├── RoomDAO.java
│   │   │       │   └── DashboardDAO.java
│   │   │       ├── model/            # Entity classes
│   │   │       │   ├── User.java
│   │   │       │   ├── Reservation.java
│   │   │       │   ├── Room.java
│   │   │       │   └── Bill.java
│   │   │       ├── service/          # Business logic
│   │   │       │   └── ReservationService.java
│   │   │       └── util/             # Utilities
│   │   │           └── DBTest.java
│   │   ├── resources/
│   │   ├── webapp/
│   │   │   ├── WEB-INF/
│   │   │   │   └── web.xml           # Servlet mappings
│   │   │   ├── common/               # Shared components
│   │   │   │   ├── navbar.jsp
│   │   │   │   └── auth-check.jsp
│   │   │   ├── views/                # JSP pages
│   │   │   │   ├── login.jsp
│   │   │   │   ├── dashboard.jsp
│   │   │   │   ├── addReservation.jsp
│   │   │   │   ├── viewReservation.jsp
│   │   │   │   ├── updateReservation.jsp
│   │   │   │   ├── bill.jsp
│   │   │   │   ├── billResult.jsp
│   │   │   │   └── help.jsp
│   │   │   ├── css/                  # Stylesheets
│   │   │   ├── js/                   # JavaScript files
│   │   │   ├── images/               # Image assets
│   │   │   ├── index.jsp
│   │   │   └── error.jsp
│   │   └── database/
│   │       └── database.sql          # Database schema
│   └── test/
├── target/                           # Compiled files
├── pom.xml                          # Maven configuration
└── README.md
```

## 🗄️ Database Schema

### Tables

#### `users`
```sql
- id (INT, PK, AUTO_INCREMENT)
- username (VARCHAR)
- password (VARCHAR)
- role (VARCHAR)
```

#### `reservations`
```sql
- id (INT, PK, AUTO_INCREMENT)
- reservation_no (VARCHAR)
- guest_name (VARCHAR)
- address (VARCHAR)
- contact (VARCHAR)
- room_type (ENUM: Standard, Deluxe, Suite)
- check_in (DATE)
- check_out (DATE)
```

#### `rooms`
```sql
- room_type (VARCHAR, PK)
- price_per_night (DOUBLE)
```

#### `room_inventory`
```sql
- room_no (VARCHAR, PK)
- room_type (VARCHAR)
- price_per_night (DOUBLE)
- status (VARCHAR)
- created_at (TIMESTAMP)
```

#### `bills`
```sql
- bill_id (INT, PK, AUTO_INCREMENT)
- reservation_no (VARCHAR)
- guest_name (VARCHAR)
- room_type (VARCHAR)
- check_in (DATE)
- check_out (DATE)
- number_of_nights (INT)
- price_per_night (DOUBLE)
- total_amount (DOUBLE)
- bill_date (DATE)
- payment_status (VARCHAR)
```

## 🚀 Installation & Setup

### Prerequisites
- Java JDK 8 or higher
- Apache Tomcat 9 or higher
- MySQL 8.0 or higher
- Maven 3.6 or higher

### Setup Steps

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd oceanview-prod
   ```

2. **Create the database**
   ```bash
   mysql -u root -p
   ```
   ```sql
   CREATE DATABASE oceanview_db;
   USE oceanview_db;
   source src/main/database/database.sql;
   ```

3. **Configure database connection**
   
   Update `src/main/java/com/icbt/dao/DBConnection.java` with your MySQL credentials:
   ```java
   connection = DriverManager.getConnection(
       "jdbc:mysql://localhost:3306/oceanview_db",
       "your_username",
       "your_password"
   );
   ```

4. **Build the project**
   ```bash
   mvn clean install
   ```

5. **Deploy to Tomcat**
   - Copy the generated WAR file from `target/oceanview.war` to Tomcat's `webapps` directory
   - Or use your IDE's deployment feature

6. **Access the application**
   ```
   http://localhost:8080/oceanview/
   ```

## 👤 Default Login Credentials

```
Username: admin
Password: password
```

## 📖 Usage Guide

### Adding a Reservation
1. Navigate to **Add Reservation** from the dashboard
2. Fill in the guest details (name, address, contact)
3. Enter a unique reservation number
4. Select room type
5. Choose check-in and check-out dates
6. Click **Save Reservation**

### Viewing Reservations
1. Go to **View Reservations**
2. Browse all current reservations
3. Use **Update** button to edit details
4. Use **Delete** button to remove a reservation (with confirmation)

### Generating Bills
1. Navigate to **Billing**
2. Enter the reservation number
3. Click **Calculate Bill**
4. Review the generated invoice
5. Use **Print Invoice** button to print

### Dashboard Insights
- View real-time statistics
- Monitor today's check-ins and check-outs
- Track available rooms
- Check pending bills

### Managing Rooms
1. Go to **Rooms** from the sidebar
2. Add room details (room number, type, price, status)
3. Use the room list to change status instantly

### Managing User Accounts
1. Go to **User Accounts** from the sidebar
2. Create a username, password, and role
3. Remove obsolete accounts from the user list

## 🔒 Security Features

- Session-based authentication
- Protected pages with authentication checks
- SQL injection prevention using PreparedStatements
- Input validation on both client and server side
- Secure logout functionality

## 🎯 Key Functionalities

### Data Validation
- Date validation (check-out after check-in)
- Contact number format validation (10 digits)
- Required field validation
- Room type enum validation

### Auto-calculations
- Number of nights between dates
- Total bill amount (nights × price per night)
- Room availability tracking

### User Experience
- Auto-hide success/error messages
- Confirmation dialogs for delete operations
- Form data retention on validation errors
- Responsive navigation menu
- Print-optimized invoice layout

## 🐛 Troubleshooting

### Database Connection Issues
- Verify MySQL service is running
- Check database credentials in `DBConnection.java`
- Ensure database 'oceanview_db' exists
- Verify MySQL JDBC driver is in classpath

### Build Errors
```bash
# Clean and rebuild
mvn clean install -U
```

### Tomcat Deployment Issues
- Check Tomcat logs in `logs/catalina.out`
- Verify Tomcat is running: `http://localhost:8080`
- Ensure no port conflicts (default: 8080)

## 📝 Future Enhancements

- [ ] Room availability calendar
- [ ] Email notifications
- [ ] Advanced search and filtering
- [ ] Report generation (PDF/Excel)
- [ ] Multi-user roles (Admin, Receptionist, Manager)
- [ ] Password encryption
- [ ] Payment gateway integration
- [ ] Guest profile management
- [ ] Housekeeping module
- [ ] Mobile responsive improvements

## 👨‍💻 Developer Information

**Developed by**: Sathira Sri Sathsara  
**Institution**: Cardiff Metropolitan University  
**Purpose**: Academic Assignment  
**Year**: 2026

## 📄 License

This project is developed for educational purposes as part of Cardiff Metropolitan University coursework.

## 🤝 Contributing

This is an academic project. For suggestions or issues, please contact the developer.

## 📞 Support

For technical support or questions:
- Email: [Your Email]
- University Portal: [Link]

---

**Note**: This system is designed for educational purposes. For production use, implement additional security measures, password hashing, and comprehensive error handling.
