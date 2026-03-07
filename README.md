# Ocean View Hotel Management System

## Project Overview

Ocean View is a comprehensive Hotel Management System designed to streamline hotel operations including reservation management, room management, billing, and user administration. The system is built using Java EE technologies with a Model-View-Controller (MVC) architecture pattern.

### Technology Stack
- **Backend**: Java Servlets, JSP
- **Database**: MySQL 8.0
- **Build Tool**: Maven
- **Server**: Apache Tomcat
- **Frontend**: HTML, CSS, JavaScript

---

## Table of Contents
1. [UML Diagrams](#uml-diagrams)
   - [Use Case Diagram](#use-case-diagram)
   - [Class Diagram](#class-diagram)
   - [Sequence Diagrams](#sequence-diagrams)
2. [Design Decisions and Assumptions](#design-decisions-and-assumptions)
3. [Test Plan and Test-Driven Development](#test-plan-and-test-driven-development)
4. [Application Screenshots](#application-screenshots)
5. [Comprehensive User Manual](#comprehensive-user-manual)
6. [Installation and Setup](#installation-and-setup)

---

## UML Diagrams

### Use Case Diagram

```
┌──────────────────────────────────────────────────────────────────┐
│                    Ocean View Hotel System                       │
│                                                                  │
│   ┌────────────┐                                   ┌──────────┐ │
│   │            │                                   │          │ │
│   │   Admin    │───────────────────────────────────│  Login   │ │
│   │            │                                   │          │ │
│   └────────────┘                                   └──────────┘ │
│        │                                                         │
│        │  ┌─────────────────────────────────────────┐           │
│        ├──│ Manage Reservations                     │           │
│        │  │  - Add Reservation                      │           │
│        │  │  - View Reservations                    │           │
│        │  │  - Update Reservation                   │           │
│        │  │  - Delete Reservation                   │           │
│        │  └─────────────────────────────────────────┘           │
│        │                                                         │
│        │  ┌─────────────────────────────────────────┐           │
│        ├──│ Manage Rooms                            │           │
│        │  │  - View Room Types                      │           │
│        │  │  - Update Room Prices                   │           │
│        │  │  - Add Room Type                        │           │
│        │  │  - Delete Room Type                     │           │
│        │  └─────────────────────────────────────────┘           │
│        │                                                         │
│        │  ┌─────────────────────────────────────────┐           │
│        ├──│ Manage Bills                            │           │
│        │  │  - Generate Bill                        │           │
│        │  │  - View Bill                            │           │
│        │  │  - Update Payment Status                │           │
│        │  └─────────────────────────────────────────┘           │
│        │                                                         │
│        │  ┌─────────────────────────────────────────┐           │
│        ├──│ Manage Users                            │           │
│        │  │  - Add User                             │           │
│        │  │  - View Users                           │           │
│        │  │  - Update User                          │           │
│        │  │  - Delete User                          │           │
│        │  └─────────────────────────────────────────┘           │
│        │                                                         │
│        │  ┌─────────────────────────────────────────┐           │
│        └──│ View Dashboard                          │           │
│           │  - Total Reservations                   │           │
│           │  - Available Rooms                      │           │
│           │  - Revenue Statistics                   │           │
│           └─────────────────────────────────────────┘           │
│                                                                  │
└──────────────────────────────────────────────────────────────────┘
```

#### Use Case Descriptions

**Actor: Admin/Staff User**

1. **Login**: User authenticates with username and password to access the system
2. **Manage Reservations**: Create, read, update, and delete guest reservations
3. **Manage Rooms**: Configure room types and pricing information
4. **Manage Bills**: Generate bills for reservations and track payment status
5. **Manage Users**: Administer system users and their roles
6. **View Dashboard**: Monitor key metrics and system statistics

---

### Class Diagram

```
┌─────────────────────────────────────────────────────────────────────────┐
│                         PRESENTATION LAYER                              │
├─────────────────────────────────────────────────────────────────────────┤
│                                                                         │
│  ┌──────────────────┐  ┌──────────────────┐  ┌──────────────────┐    │
│  │ LoginServlet     │  │ ReservationServlet│ │ BillServlet      │    │
│  ├──────────────────┤  ├──────────────────┤  ├──────────────────┤    │
│  │ +doPost()        │  │ +doGet()         │  │ +doPost()        │    │
│  └──────────────────┘  │ +doPost()        │  └──────────────────┘    │
│                        └──────────────────┘                            │
│  ┌──────────────────┐  ┌──────────────────┐  ┌──────────────────┐    │
│  │RoomManagement    │  │UserManagement    │  │ Dashboard        │    │
│  │Servlet           │  │Servlet           │  │ Servlet          │    │
│  ├──────────────────┤  ├──────────────────┤  ├──────────────────┤    │
│  │ +doGet()         │  │ +doGet()         │  │ +doGet()         │    │
│  │ +doPost()        │  │ +doPost()        │  └──────────────────┘    │
│  └──────────────────┘  └──────────────────┘                            │
└─────────────────────────────────────────────────────────────────────────┘
                                   │
                                   ↓
┌─────────────────────────────────────────────────────────────────────────┐
│                         SERVICE LAYER                                   │
├─────────────────────────────────────────────────────────────────────────┤
│                                                                         │
│  ┌──────────────────────────────────────────┐                          │
│  │ ReservationService                       │                          │
│  ├──────────────────────────────────────────┤                          │
│  │ - reservationDAO: ReservationDAO         │                          │
│  ├──────────────────────────────────────────┤                          │
│  │ + addReservation(reservation): void      │                          │
│  └──────────────────────────────────────────┘                          │
└─────────────────────────────────────────────────────────────────────────┘
                                   │
                                   ↓
┌─────────────────────────────────────────────────────────────────────────┐
│                         DATA ACCESS LAYER                               │
├─────────────────────────────────────────────────────────────────────────┤
│                                                                         │
│  ┌──────────────────────────────────────────┐                          │
│  │ ReservationDAO                           │                          │
│  ├──────────────────────────────────────────┤                          │
│  │ + saveReservation(r): void               │                          │
│  │ + getAllReservations(): List             │                          │
│  │ + getReservationById(id): Reservation    │                          │
│  │ + updateReservation(r): boolean          │                          │
│  │ + deleteReservation(id): boolean         │                          │
│  └──────────────────────────────────────────┘                          │
│                                                                         │
│  ┌──────────────────────────────────────────┐                          │
│  │ RoomDAO                                  │                          │
│  ├──────────────────────────────────────────┤                          │
│  │ + getAllRooms(): List                    │                          │
│  │ + getRoomByType(type): Room              │                          │
│  │ + saveRoom(room): void                   │                          │
│  │ + updateRoom(room): boolean              │                          │
│  │ + deleteRoom(type): boolean              │                          │
│  └──────────────────────────────────────────┘                          │
│                                                                         │
│  ┌──────────────────────────────────────────┐                          │
│  │ UserDAO                                  │                          │
│  ├──────────────────────────────────────────┤                          │
│  │ + validateUser(u, p): User               │                          │
│  │ + getAllUsers(): List                    │                          │
│  │ + saveUser(user): void                   │                          │
│  │ + updateUser(user): boolean              │                          │
│  │ + deleteUser(id): boolean                │                          │
│  └──────────────────────────────────────────┘                          │
│                                                                         │
│  ┌──────────────────────────────────────────┐                          │
│  │ DashboardDAO                             │                          │
│  ├──────────────────────────────────────────┤                          │
│  │ + getTotalReservations(): int            │                          │
│  │ + getTotalRevenue(): double              │                          │
│  │ + getRevenueByRoomType(): Map            │                          │
│  └──────────────────────────────────────────┘                          │
│                                                                         │
│  ┌──────────────────────────────────────────┐                          │
│  │ DBConnection                             │                          │
│  ├──────────────────────────────────────────┤                          │
│  │ - JDBC_URL: String                       │                          │
│  │ - USERNAME: String                       │                          │
│  │ - PASSWORD: String                       │                          │
│  ├──────────────────────────────────────────┤                          │
│  │ + getConnection(): Connection            │                          │
│  └──────────────────────────────────────────┘                          │
└─────────────────────────────────────────────────────────────────────────┘
                                   │
                                   ↓
┌─────────────────────────────────────────────────────────────────────────┐
│                         MODEL LAYER                                     │
├─────────────────────────────────────────────────────────────────────────┤
│                                                                         │
│  ┌──────────────────────────────────────────┐                          │
│  │ Reservation                              │                          │
│  ├──────────────────────────────────────────┤                          │
│  │ - id: int                                │                          │
│  │ - reservationNo: String                  │                          │
│  │ - guestName: String                      │                          │
│  │ - address: String                        │                          │
│  │ - contact: String                        │                          │
│  │ - roomType: String                       │                          │
│  │ - checkIn: String                        │                          │
│  │ - checkOut: String                       │                          │
│  ├──────────────────────────────────────────┤                          │
│  │ + getters/setters                        │                          │
│  └──────────────────────────────────────────┘                          │
│                                                                         │
│  ┌──────────────────────────────────────────┐                          │
│  │ Room                                     │                          │
│  ├──────────────────────────────────────────┤                          │
│  │ - roomNo: String                         │                          │
│  │ - roomType: String                       │                          │
│  │ - pricePerNight: double                  │                          │
│  │ - status: String                         │                          │
│  ├──────────────────────────────────────────┤                          │
│  │ + getters/setters                        │                          │
│  └──────────────────────────────────────────┘                          │
│                                                                         │
│  ┌──────────────────────────────────────────┐                          │
│  │ Bill                                     │                          │
│  ├──────────────────────────────────────────┤                          │
│  │ - billId: int                            │                          │
│  │ - reservationNo: String                  │                          │
│  │ - guestName: String                      │                          │
│  │ - roomType: String                       │                          │
│  │ - checkIn: LocalDate                     │                          │
│  │ - checkOut: LocalDate                    │                          │
│  │ - numberOfNights: long                   │                          │
│  │ - pricePerNight: double                  │                          │
│  │ - totalAmount: double                    │                          │
│  │ - billDate: LocalDate                    │                          │
│  │ - paymentStatus: String                  │                          │
│  ├──────────────────────────────────────────┤                          │
│  │ + getters/setters                        │                          │
│  └──────────────────────────────────────────┘                          │
│                                                                         │
│  ┌──────────────────────────────────────────┐                          │
│  │ User                                     │                          │
│  ├──────────────────────────────────────────┤                          │
│  │ - id: int                                │                          │
│  │ - username: String                       │                          │
│  │ - password: String                       │                          │
│  │ - role: String                           │                          │
│  ├──────────────────────────────────────────┤                          │
│  │ + getters/setters                        │                          │
│  └──────────────────────────────────────────┘                          │
└─────────────────────────────────────────────────────────────────────────┘
```

---

### Sequence Diagrams

#### 1. User Login Sequence

```
┌──────┐          ┌──────────────┐        ┌─────────┐         ┌──────────┐
│Client│          │LoginServlet  │        │UserDAO  │         │Database  │
└──┬───┘          └──────┬───────┘        └────┬────┘         └────┬─────┘
   │                     │                     │                   │
   │ POST login request  │                     │                   │
   │ (username, password)│                     │                   │
   ├─────────────────────>                     │                   │
   │                     │                     │                   │
   │                     │ validateUser()      │                   │
   │                     ├─────────────────────>                   │
   │                     │                     │                   │
   │                     │                     │ SELECT * FROM     │
   │                     │                     │ users WHERE...    │
   │                     │                     ├──────────────────>│
   │                     │                     │                   │
   │                     │                     │   User data       │
   │                     │                     │<──────────────────┤
   │                     │                     │                   │
   │                     │   User object       │                   │
   │                     │<─────────────────────                   │
   │                     │                     │                   │
   │   [Valid User]      │                     │                   │
   │   Create session    │                     │                   │
   │   Redirect to       │                     │                   │
   │   dashboard.jsp     │                     │                   │
   │<─────────────────────                     │                   │
   │                     │                     │                   │
   │   [Invalid User]    │                     │                   │
   │   Redirect to       │                     │                   │
   │   login.jsp         │                     │                   │
   │<─────────────────────                     │                   │
```

#### 2. Add Reservation Sequence

```
┌──────┐     ┌───────────────┐   ┌──────────────┐   ┌───────────────┐   ┌─────────┐
│Client│     │Reservation    │   │Reservation   │   │Reservation    │   │Database │
│      │     │Servlet        │   │Service       │   │DAO            │   │         │
└──┬───┘     └───────┬───────┘   └──────┬───────┘   └───────┬───────┘   └────┬────┘
   │                 │                   │                   │                │
   │ POST reservation│                   │                   │                │
   │ data            │                   │                   │                │
   ├─────────────────>                   │                   │                │
   │                 │                   │                   │                │
   │                 │ Validate input    │                   │                │
   │                 │ Create Reservation│                   │                │
   │                 │ object            │                   │                │
   │                 │                   │                   │                │
   │                 │ addReservation()  │                   │                │
   │                 ├───────────────────>                   │                │
   │                 │                   │                   │                │
   │                 │                   │ saveReservation() │                │
   │                 │                   ├───────────────────>                │
   │                 │                   │                   │                │
   │                 │                   │                   │ INSERT INTO    │
   │                 │                   │                   │ reservations   │
   │                 │                   │                   ├───────────────>│
   │                 │                   │                   │                │
   │                 │                   │                   │   Success      │
   │                 │                   │                   │<───────────────┤
   │                 │                   │                   │                │
   │                 │                   │    Return         │                │
   │                 │                   │<───────────────────                │
   │                 │                   │                   │                │
   │                 │    Return         │                   │                │
   │                 │<───────────────────                   │                │
   │                 │                   │                   │                │
   │   Redirect to   │                   │                   │                │
   │   Success page  │                   │                   │                │
   │<─────────────────                   │                   │                │
```

#### 3. Generate Bill Sequence

```
┌──────┐       ┌──────────┐        ┌─────────────┐       ┌──────────┐
│Client│       │Bill      │        │Reservation  │       │Database  │
│      │       │Servlet   │        │DAO/RoomDAO  │       │          │
└──┬───┘       └────┬─────┘        └──────┬──────┘       └────┬─────┘
   │                │                      │                   │
   │ POST reservation│                     │                   │
   │ number          │                     │                   │
   ├────────────────>│                     │                   │
   │                │                      │                   │
   │                │ getReservationById() │                   │
   │                ├──────────────────────>                   │
   │                │                      │                   │
   │                │                      │ SELECT * FROM     │
   │                │                      │ reservations      │
   │                │                      ├──────────────────>│
   │                │                      │                   │
   │                │                      │ Reservation data  │
   │                │                      │<──────────────────┤
   │                │                      │                   │
   │                │  Reservation object  │                   │
   │                │<──────────────────────                   │
   │                │                      │                   │
   │                │ getRoomByType()      │                   │
   │                ├──────────────────────>                   │
   │                │                      │                   │
   │                │                      │ SELECT price      │
   │                │                      │ FROM rooms        │
   │                │                      ├──────────────────>│
   │                │                      │                   │
   │                │                      │ Price data        │
   │                │                      │<──────────────────┤
   │                │                      │                   │
   │                │  Room object         │                   │
   │                │<──────────────────────                   │
   │                │                      │                   │
   │                │ Calculate:           │                   │
   │                │ - Number of nights   │                   │
   │                │ - Total amount       │                   │
   │                │                      │                   │
   │                │ Create Bill object   │                   │
   │                │                      │                   │
   │                │ saveBill()           │                   │
   │                ├──────────────────────>                   │
   │                │                      │                   │
   │                │                      │ INSERT INTO bills │
   │                │                      ├──────────────────>│
   │                │                      │                   │
   │                │                      │   Success         │
   │                │                      │<──────────────────┤
   │                │                      │                   │
   │                │  Return              │                   │
   │                │<──────────────────────                   │
   │                │                      │                   │
   │   Display bill │                      │                   │
   │   (billResult. │                      │                   │
   │    jsp)        │                      │                   │
   │<────────────────                      │                   │
```

---

## Design Decisions and Assumptions

### Architecture Design Decisions

#### 1. **Layered Architecture (MVC Pattern)**
**Decision**: Implemented a clear separation of concerns using Model-View-Controller architecture.

**Rationale**:
- **Maintainability**: Separating business logic from presentation makes the code easier to maintain and debug
- **Testability**: Individual components can be tested in isolation
- **Scalability**: Layers can be modified or replaced without affecting others
- **Reusability**: Business logic can be reused across different presentation layers

**Layers**:
- **Presentation Layer**: JSP pages for view, Servlets for controllers
- **Business Logic Layer**: Service classes for complex operations
- **Data Access Layer**: DAO classes for database operations
- **Model Layer**: POJOs representing business entities

#### 2. **DAO Pattern**
**Decision**: Used Data Access Object pattern to abstract database operations.

**Rationale**:
- **Separation of Concerns**: Database logic is isolated from business logic
- **Database Independence**: Easy to switch databases or modify queries without affecting business logic
- **Code Reusability**: Common CRUD operations are centralized
- **Testing**: Can be mocked for unit testing

#### 3. **Session Management**
**Decision**: Implemented server-side session management with authentication checks.

**Rationale**:
- **Security**: Prevents unauthorized access to protected resources
- **User Experience**: Maintains user state across multiple requests
- **Centralized Auth Check**: `auth-check.jsp` is included in all protected pages

#### 4. **Database Design**
**Decision**: Normalized database schema with separate tables for entities.

**Rationale**:
- **Data Integrity**: Foreign key relationships ensure referential integrity
- **Flexibility**: Easy to extend with new features
- **Performance**: Proper indexing on frequently queried columns

---

### Key Assumptions

1. **Single Hotel Location**
   - System assumes management of a single hotel property
   - All rooms are at one location

2. **User Roles**
   - System assumes all logged-in users are staff/admin with full access
   - No guest self-service portal implemented

3. **Room Types**
   - Fixed room types: Standard, Deluxe, Suite
   - Room types are configurable through room management interface

4. **Reservation System**
   - No double-booking prevention mechanism (assumed to be handled manually)
   - Reservations are identified by unique reservation numbers
   - Check-in and check-out dates are mandatory

5. **Billing System**
   - Bills are generated after reservation is created
   - Payment status can be: PENDING, PAID, CANCELLED
   - Total amount = Number of nights × Price per night

6. **Data Validation**
   - Client-side validation using JavaScript
   - Server-side validation in servlets
   - Database constraints as final validation layer

7. **Concurrency**
   - Application assumes moderate concurrent user load
   - No explicit locking mechanism for concurrent updates

8. **Browser Compatibility**
   - Modern browsers with JavaScript enabled
   - Responsive design not implemented (desktop-first approach)

---

## Database Design

### Database Overview

The Ocean View Hotel Management System uses a MySQL 8.0 database with normalized schema. The database consists of 5 main tables designed to manage users, rooms, reservations, bills, and inventory.

**Database Name**: `oceanview_db`  
**Character Set**: UTF8MB4  
**Default Collation**: utf8mb4_0900_ai_ci

---

### Entity Relationship Diagram (ER Diagram)

```
┌─────────────────────┐          ┌─────────────────────────┐
│      USERS          │          │      ROOMS              │
├─────────────────────┤          ├─────────────────────────┤
│ id (PK)             │          │ room_type (PK)          │
│ username            │          │ price_per_night         │
│ password            │          └─────────────────────────┘
│ role                │                      ▲
└─────────────────────┘                      │
                                             │
                                             │ (1:M)
                                             │ references
                                             │
┌─────────────────────────────────────────────────────────────────┐
│                    RESERVATIONS                                │
├─────────────────────────────────────────────────────────────────┤
│ id (PK)                                                         │
│ reservation_no                                                  │
│ guest_name                                                      │
│ address                                                         │
│ contact                                                         │
│ room_type (FK) ─────────────────────────────────────────────────┤
│ check_in                                                        │
│ check_out                                                       │
└─────────────────────────────────────────────────────────────────┘
         │
         │ (1:M)
         │ creates
         │
         ▼
┌─────────────────────────────────────────────────────────────────┐
│                      BILLS                                      │
├─────────────────────────────────────────────────────────────────┤
│ bill_id (PK)                                                    │
│ reservation_no                                                  │
│ guest_name                                                      │
│ room_type                                                       │
│ check_in                                                        │
│ check_out                                                       │
│ number_of_nights                                                │
│ price_per_night                                                 │
│ total_amount                                                    │
│ bill_date                                                       │
│ payment_status                                                  │
└─────────────────────────────────────────────────────────────────┘

┌──────────────────────────────────────┐
│      ROOM_INVENTORY                  │
├──────────────────────────────────────┤
│ room_no (PK)                         │
│ room_type (FK)                       │
│ price_per_night                      │
│ status                               │
│ created_at                           │
└──────────────────────────────────────┘
         │
         │ (M:1)
         │ belongs to
         │
         ▼
    ROOMS table
```

---

### Database Schema

#### 1. USERS Table
**Purpose**: Store system user credentials and roles

| Column | Type | Constraints | Description |
|--------|------|-------------|-------------|
| `id` | INT | PRIMARY KEY, AUTO_INCREMENT | Unique user identifier |
| `username` | VARCHAR(50) | NOT NULL | User login name |
| `password` | VARCHAR(50) | NOT NULL | User password (should be hashed in production) |
| `role` | VARCHAR(20) | NOT NULL | User role (admin, staff) |

**Sample Data**:
```sql
INSERT INTO users VALUES (1, 'admin', 'password', 'admin');
```

**Indexes**: PRIMARY KEY on `id`

---

#### 2. ROOMS Table
**Purpose**: Store room types and their pricing information

| Column | Type | Constraints | Description |
|--------|------|-------------|-------------|
| `room_type` | VARCHAR(50) | PRIMARY KEY | Room type identifier (Standard, Deluxe, Suite) |
| `price_per_night` | DOUBLE | NOT NULL | Nightly rate for the room type |

**Sample Data**:
```sql
INSERT INTO rooms VALUES 
('Standard', 8000),
('Deluxe', 12000),
('Suite', 20000);
```

**Indexes**: PRIMARY KEY on `room_type`

**Relationships**:
- Referenced by `reservations.room_type`
- Referenced by `room_inventory.room_type`

---

#### 3. RESERVATIONS Table
**Purpose**: Store guest reservation information

| Column | Type | Constraints | Description |
|--------|------|-------------|-------------|
| `id` | INT | PRIMARY KEY, AUTO_INCREMENT | Unique reservation record ID |
| `reservation_no` | VARCHAR(50) | NOT NULL | Reservation number (unique identifier) |
| `guest_name` | VARCHAR(100) | NOT NULL | Guest's full name |
| `address` | VARCHAR(100) | NOT NULL | Guest's address |
| `contact` | VARCHAR(20) | NOT NULL | Guest's contact number |
| `room_type` | ENUM('Standard','Deluxe','Suite') | NOT NULL, FK | Type of room reserved |
| `check_in` | DATE | NOT NULL | Reservation check-in date |
| `check_out` | DATE | NOT NULL | Reservation check-out date |

**Indexes**:
- PRIMARY KEY on `id`
- INDEX `room_type_idx` on `room_type`

**Constraints**:
- Foreign Key: `room_type` references `rooms.room_type`
- Date Validation: `check_out` must be after `check_in`

**Sample Data**:
```sql
INSERT INTO reservations VALUES 
(1, '1', 'test', '', 'test', 'Standard', '2026-02-26', '2026-03-20'),
(19, '7', 'Dasun Alwis', 'test', '0774563215', 'Deluxe', '2026-03-08', '2026-03-10');
```

---

#### 4. BILLS Table
**Purpose**: Store billing information for reservations

| Column | Type | Constraints | Description |
|--------|------|-------------|-------------|
| `bill_id` | INT | PRIMARY KEY, AUTO_INCREMENT | Unique bill identifier |
| `reservation_no` | VARCHAR(50) | NOT NULL | Reference to reservation |
| `guest_name` | VARCHAR(100) | NOT NULL | Guest's name (denormalized from reservation) |
| `room_type` | VARCHAR(50) | NOT NULL | Room type (denormalized from reservation) |
| `check_in` | DATE | NOT NULL | Check-in date (denormalized from reservation) |
| `check_out` | DATE | NOT NULL | Check-out date (denormalized from reservation) |
| `number_of_nights` | INT | NOT NULL | Calculated: days between check-out and check-in |
| `price_per_night` | DOUBLE | NOT NULL | Room rate at bill creation time |
| `total_amount` | DOUBLE | NOT NULL | Calculated: number_of_nights × price_per_night |
| `bill_date` | DATE | NOT NULL | Date bill was generated |
| `payment_status` | VARCHAR(20) | NOT NULL | Payment status (PENDING, PAID, CANCELLED) |

**Indexes**: PRIMARY KEY on `bill_id`

**Calculation Logic**:
- `number_of_nights` = DATEDIFF(check_out, check_in)
- `total_amount` = number_of_nights × price_per_night

**Sample Data**:
```sql
INSERT INTO bills VALUES 
(1, '7', 'Dasun Alwis', 'Deluxe', '2026-03-08', '2026-03-10', 
 2, 12000, 24000, '2026-03-05', 'PENDING');
```

---

#### 5. ROOM_INVENTORY Table
**Purpose**: Track individual room status and availability

| Column | Type | Constraints | Description |
|--------|------|-------------|-------------|
| `room_no` | VARCHAR(20) | PRIMARY KEY | Physical room number (e.g., A-101) |
| `room_type` | VARCHAR(50) | NOT NULL, FK | Room type classification |
| `price_per_night` | DOUBLE | NOT NULL | Current room rate |
| `status` | VARCHAR(20) | NOT NULL, DEFAULT 'AVAILABLE' | Current room status |
| `created_at` | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP | Record creation timestamp |

**Indexes**: 
- PRIMARY KEY on `room_no`
- FOREIGN KEY on `room_type` references `rooms.room_type`

**Status Values**:
- `AVAILABLE`: Room ready for guests
- `OCCUPIED`: Room currently occupied
- `CLEANING`: Room being cleaned
- `MAINTENANCE`: Room under maintenance

**Sample Data**:
```sql
INSERT INTO room_inventory VALUES 
('A-101', 'Standard', 8000, 'AVAILABLE', '2026-03-06 04:00:00'),
('A-102', 'Standard', 8000, 'OCCUPIED', '2026-03-06 04:00:00'),
('B-201', 'Deluxe', 12000, 'CLEANING', '2026-03-06 04:00:00'),
('C-301', 'Suite', 20000, 'MAINTENANCE', '2026-03-06 04:00:00');
```

**Relationships**:
- Foreign Key: `room_type` references `rooms.room_type`

---

### Database Normalization

The database follows **Third Normal Form (3NF)** design principles:

#### 1. **First Normal Form (1NF)**
- All tables have atomic columns (single values, not arrays)
- Each row is uniquely identifiable
- No repeating groups

#### 2. **Second Normal Form (2NF)**
- Meets 1NF requirements
- All non-key attributes depend on the entire primary key
- No partial dependencies

#### 3. **Third Normal Form (3NF)**
- Meets 2NF requirements
- No transitive dependencies
- Non-key attributes depend only on the primary key

**Normalization Example**:
- `rooms` table stores room type info separately
- `reservations` references `room_type`, avoiding data duplication
- `room_inventory` maintains individual room tracking separately

---

### Key Database Design Decisions

1. **Denormalization in BILLS Table**
   - Guest name, dates, and prices are copied from reservation and rooms
   - **Rationale**: Historical data preservation (prices may change over time)
   - **Trade-off**: Slight redundancy for audit trail integrity

2. **ENUM Type for Room Types in Reservations**
   - Restricts room_type to predefined values
   - **Rationale**: Data integrity, query optimization
   - **Values**: 'Standard', 'Deluxe', 'Suite'

3. **Separate ROOM_INVENTORY Table**
   - Tracks individual rooms separate from room types
   - **Rationale**: Allows per-room status tracking
   - **Benefit**: Can manage specific room maintenance, cleaning status

4. **AUTO_INCREMENT Primary Keys**
   - Used for users, reservations, and bills
   - **Rationale**: System-generated IDs ensure uniqueness
   - **Performance**: Integer keys are more efficient than strings

5. **Indexes on Foreign Keys**
   - `room_type_idx` on reservations table
   - **Rationale**: Faster joins and lookups

6. **Timestamps with CURRENT_TIMESTAMP**
   - `created_at` in room_inventory
   - **Rationale**: Track record creation time automatically

---

### Database Constraints

#### Primary Key Constraints
```sql
-- Users
PRIMARY KEY (id)

-- Rooms
PRIMARY KEY (room_type)

-- Reservations
PRIMARY KEY (id)

-- Bills
PRIMARY KEY (bill_id)

-- Room Inventory
PRIMARY KEY (room_no)
```

#### Foreign Key Constraints
```sql
-- Reservations references Rooms
ALTER TABLE reservations ADD CONSTRAINT fk_res_room 
FOREIGN KEY (room_type) REFERENCES rooms(room_type);

-- Room Inventory references Rooms
ALTER TABLE room_inventory ADD CONSTRAINT fk_inv_room 
FOREIGN KEY (room_type) REFERENCES rooms(room_type);
```

#### Unique Constraints (Recommended)
```sql
-- Ensure unique usernames
ALTER TABLE users ADD UNIQUE (username);

-- Ensure unique room numbers
ALTER TABLE room_inventory ADD UNIQUE (room_no);
```

---

### Data Relationships

#### One-to-Many Relationships

**ROOMS → RESERVATIONS**
- One room type can have many reservations
- Relationship: `rooms.room_type` = `reservations.room_type`

**RESERVATIONS → BILLS**
- One reservation generates one bill
- Relationship: Via `reservation_no`

**ROOMS → ROOM_INVENTORY**
- One room type has many physical rooms
- Relationship: `rooms.room_type` = `room_inventory.room_type`

---

### Sample Database Queries

#### View All Reservations for a Guest
```sql
SELECT * FROM reservations 
WHERE guest_name = 'Dasun Alwis'
ORDER BY check_in DESC;
```

#### Calculate Revenue by Room Type
```sql
SELECT room_type, COUNT(*) as total_bills, SUM(total_amount) as total_revenue
FROM bills
GROUP BY room_type
ORDER BY total_revenue DESC;
```

#### Find Available Rooms
```sql
SELECT room_no, room_type, price_per_night
FROM room_inventory
WHERE status = 'AVAILABLE'
ORDER BY room_type;
```

#### Get Reservation with Associated Bill
```sql
SELECT r.reservation_no, r.guest_name, r.room_type, r.check_in, r.check_out,
       b.bill_id, b.total_amount, b.payment_status
FROM reservations r
LEFT JOIN bills b ON r.reservation_no = b.reservation_no
WHERE r.id = 19;
```

#### List Pending Payments
```sql
SELECT bill_id, guest_name, room_type, total_amount, bill_date
FROM bills
WHERE payment_status = 'PENDING'
ORDER BY bill_date ASC;
```

---

### Backup and Recovery

**Backup Command**:
```bash
mysqldump -u username -p oceanview_db > oceanview_backup.sql
```

**Restore Command**:
```bash
mysql -u username -p oceanview_db < oceanview_backup.sql
```

---

## Test Plan and Test-Driven Development

### Testing Strategy

The Ocean View Hotel Management System follows Test-Driven Development (TDD) principles where tests are written before implementation code. This ensures:
- Code correctness
- Better design decisions
- Regression prevention
- Living documentation

### Test Rationale

**Why Testing Matters in This Project**:
1. **Data Integrity**: Ensures reservation data, billing calculations, and user information remain accurate
2. **Business Logic Validation**: Verifies calculations (nights, totals) are correct
3. **Security**: Validates authentication and authorization mechanisms
4. **Database Operations**: Confirms CRUD operations work correctly
5. **Integration**: Ensures different components work together seamlessly

---

### Test Plan

#### 1. Unit Tests

**1.1 Model Classes Testing**

**Test Case ID**: TC-MODEL-001  
**Test Name**: Test Reservation Object Creation  
**Objective**: Verify Reservation model correctly stores and retrieves data  
**Test Data**:
```java
Reservation res = new Reservation("R001", "John Doe", 
    "123 Main St", "1234567890", "Deluxe", 
    "2026-03-10", "2026-03-15");
```
**Expected Result**: All getters return correct values  
**Test Type**: Unit Test

**Test Case ID**: TC-MODEL-002  
**Test Name**: Test Bill Calculation Logic  
**Objective**: Verify bill calculates total amount correctly  
**Test Data**:
- Check-in: 2026-03-10
- Check-out: 2026-03-15
- Price per night: 12000
- Expected nights: 5
- Expected total: 60000
**Expected Result**: `totalAmount = 60000`, `numberOfNights = 5`  
**Test Type**: Unit Test

---

**1.2 DAO Layer Testing**

**Test Case ID**: TC-DAO-001  
**Test Name**: Test Save Reservation  
**Objective**: Verify ReservationDAO.saveReservation() inserts data correctly  
**Pre-conditions**: Database connection available  
**Test Data**: Valid Reservation object  
**Expected Result**: Reservation inserted in database, no exceptions thrown  
**Test Type**: Integration Test (requires database)

**Test Case ID**: TC-DAO-002  
**Test Name**: Test Retrieve All Reservations  
**Objective**: Verify ReservationDAO.getAllReservations() returns list  
**Pre-conditions**: Database has test data  
**Test Data**: Database with 5 reservations  
**Expected Result**: Returns list with 5 Reservation objects  
**Test Type**: Integration Test

**Test Case ID**: TC-DAO-003  
**Test Name**: Test Update Reservation  
**Objective**: Verify ReservationDAO.updateReservation() modifies existing record  
**Pre-conditions**: Reservation exists in database  
**Test Data**: Modified Reservation object  
**Expected Result**: Database record updated, method returns true  
**Test Type**: Integration Test

**Test Case ID**: TC-DAO-004  
**Test Name**: Test Delete Reservation  
**Objective**: Verify ReservationDAO.deleteReservation() removes record  
**Pre-conditions**: Reservation exists in database  
**Test Data**: Reservation ID = 1  
**Expected Result**: Record deleted, method returns true  
**Test Type**: Integration Test

---

**1.3 Service Layer Testing**

**Test Case ID**: TC-SERVICE-001  
**Test Name**: Test Add Reservation Service  
**Objective**: Verify ReservationService.addReservation() delegates to DAO  
**Test Approach**: Mock ReservationDAO  
**Test Data**: Valid Reservation object  
**Expected Result**: DAO.saveReservation() called once with correct parameters  
**Test Type**: Unit Test (with mocking)

---

#### 2. Integration Tests

**Test Case ID**: TC-INT-001  
**Test Name**: Test Login Flow  
**Objective**: Verify complete login process  
**Test Steps**:
1. Submit POST request to /login with valid credentials
2. Verify session created
3. Verify redirect to dashboard
**Test Data**: username="admin", password="admin123"  
**Expected Result**: Session contains user object, redirected to dashboard.jsp  
**Test Type**: Integration Test

**Test Case ID**: TC-INT-002  
**Test Name**: Test Complete Reservation Flow  
**Objective**: Verify end-to-end reservation creation  
**Test Steps**:
1. POST reservation data to /addReservation
2. Verify data saved in database
3. Verify redirect to success page
**Test Data**: Complete reservation form data  
**Expected Result**: Reservation visible in database and view page  
**Test Type**: Integration Test

**Test Case ID**: TC-INT-003  
**Test Name**: Test Bill Generation Flow  
**Objective**: Verify bill generation from reservation  
**Test Steps**:
1. Create a reservation
2. POST reservation number to /generateBill
3. Verify bill calculation
4. Verify bill saved in database
**Test Data**: Existing reservation number  
**Expected Result**: Bill created with correct calculations  
**Test Type**: Integration Test

---

#### 3. Validation Tests

**Test Case ID**: TC-VAL-001  
**Test Name**: Test Empty Form Submission  
**Objective**: Verify client-side validation prevents empty submission  
**Test Data**: Empty form fields  
**Expected Result**: JavaScript validation shows error messages, form not submitted  
**Test Type**: Frontend Validation Test

**Test Case ID**: TC-VAL-002  
**Test Name**: Test Invalid Date Range  
**Objective**: Verify system rejects check-out before check-in  
**Test Data**: check-in="2026-03-15", check-out="2026-03-10"  
**Expected Result**: Validation error displayed  
**Test Type**: Validation Test

**Test Case ID**: TC-VAL-003  
**Test Name**: Test Contact Number Format  
**Objective**: Verify phone number validation  
**Test Data**: "invalid-phone"  
**Expected Result**: Validation error for invalid format  
**Test Type**: Validation Test

---

#### 4. Security Tests

**Test Case ID**: TC-SEC-001  
**Test Name**: Test Unauthorized Access  
**Objective**: Verify protected pages redirect unauthenticated users  
**Test Steps**:
1. Access /views/dashboard.jsp without login
2. Verify redirect to login page
**Expected Result**: Redirected to login.jsp  
**Test Type**: Security Test

**Test Case ID**: TC-SEC-002  
**Test Name**: Test Invalid Login  
**Objective**: Verify system rejects invalid credentials  
**Test Data**: username="invalid", password="wrong"  
**Expected Result**: Login fails, error message shown, no session created  
**Test Type**: Security Test

---

#### 5. Database Tests

**Test Case ID**: TC-DB-001  
**Test Name**: Test Database Connection  
**Objective**: Verify DBConnection.getConnection() returns valid connection  
**Expected Result**: Non-null Connection object  
**Test Type**: Integration Test

**Test Case ID**: TC-DB-002  
**Test Name**: Test Transaction Rollback  
**Objective**: Verify failed operations rollback properly  
**Test Approach**: Force an error during insert  
**Expected Result**: No partial data in database  
**Test Type**: Integration Test

---

### Test-Driven Development Approach

#### TDD Cycle Applied to This Project

**1. RED Phase (Write Failing Test)**
```java
@Test
public void testSaveReservation() {
    ReservationDAO dao = new ReservationDAO();
    Reservation reservation = new Reservation(
        "R001", "John Doe", "123 Main St", 
        "1234567890", "Deluxe", 
        "2026-03-10", "2026-03-15"
    );
    
    // This test will fail initially
    boolean result = dao.saveReservation(reservation);
    assertTrue(result);
}
```

**2. GREEN Phase (Make Test Pass)**
- Implement `ReservationDAO.saveReservation()` method
- Write minimum code to make test pass
- Run test until it succeeds

**3. REFACTOR Phase**
- Improve code quality
- Extract common patterns
- Optimize database queries
- Ensure tests still pass

---

### Test Automation

#### Automation Framework Setup

**Tools Used**:
- **JUnit**: Unit testing framework
- **Mockito**: Mocking framework for isolating dependencies
- **Selenium WebDriver**: End-to-end browser automation
- **Maven Surefire Plugin**: Test execution in build process

#### Sample Test Implementation

**Example 1: Unit Test for Model**
```java
package com.icbt.model;

import org.junit.Test;
import static org.junit.Assert.*;

public class ReservationTest {
    
    @Test
    public void testReservationCreation() {
        // Arrange
        Reservation res = new Reservation(
            "R001", "John Doe", "123 Main St",
            "1234567890", "Deluxe",
            "2026-03-10", "2026-03-15"
        );
        
        // Act & Assert
        assertEquals("R001", res.getReservationNo());
        assertEquals("John Doe", res.getGuestName());
        assertEquals("Deluxe", res.getRoomType());
    }
    
    @Test
    public void testReservationSetters() {
        // Arrange
        Reservation res = new Reservation();
        
        // Act
        res.setGuestName("Jane Smith");
        res.setRoomType("Suite");
        
        // Assert
        assertEquals("Jane Smith", res.getGuestName());
        assertEquals("Suite", res.getRoomType());
    }
}
```

**Example 2: DAO Layer Test**
```java
package com.icbt.dao;

import com.icbt.model.Reservation;
import org.junit.Before;
import org.junit.Test;
import java.sql.Connection;
import static org.junit.Assert.*;

public class ReservationDAOTest {
    
    private ReservationDAO dao;
    private Connection conn;
    
    @Before
    public void setUp() {
        dao = new ReservationDAO();
        // Setup test database connection
    }
    
    @Test
    public void testSaveReservation() {
        // Arrange
        Reservation res = new Reservation(
            "TEST001", "Test User", "Test Address",
            "1234567890", "Standard",
            "2026-03-10", "2026-03-12"
        );
        
        // Act
        dao.saveReservation(res);
        Reservation retrieved = dao.getReservationById(res.getId());
        
        // Assert
        assertNotNull(retrieved);
        assertEquals("TEST001", retrieved.getReservationNo());
        assertEquals("Test User", retrieved.getGuestName());
    }
    
    @Test
    public void testDeleteReservation() {
        // Arrange - create a test reservation first
        Reservation res = createTestReservation();
        dao.saveReservation(res);
        int id = res.getId();
        
        // Act
        boolean deleted = dao.deleteReservation(id);
        
        // Assert
        assertTrue(deleted);
        assertNull(dao.getReservationById(id));
    }
}
```

**Example 3: Service Layer Test with Mocking**
```java
package com.icbt.service;

import com.icbt.dao.ReservationDAO;
import com.icbt.model.Reservation;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.MockitoJUnitRunner;

import static org.mockito.Mockito.*;

@RunWith(MockitoJUnitRunner.class)
public class ReservationServiceTest {
    
    @Mock
    private ReservationDAO mockDAO;
    
    @InjectMocks
    private ReservationService service;
    
    @Test
    public void testAddReservation() {
        // Arrange
        Reservation res = new Reservation(
            "R001", "John Doe", "Address",
            "1234567890", "Deluxe",
            "2026-03-10", "2026-03-15"
        );
        
        // Act
        service.addReservation(res);
        
        // Assert
        verify(mockDAO, times(1)).saveReservation(res);
    }
}
```

**Example 4: End-to-End Test with Selenium**
```java
package com.icbt.e2e;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;
import static org.junit.Assert.*;

public class LoginE2ETest {
    
    private WebDriver driver;
    
    @Before
    public void setUp() {
        System.setProperty("webdriver.chrome.driver", 
            "path/to/chromedriver");
        driver = new ChromeDriver();
    }
    
    @Test
    public void testSuccessfulLogin() {
        // Navigate to login page
        driver.get("http://localhost:8080/oceanview/login.jsp");
        
        // Fill login form
        WebElement username = driver.findElement(By.name("username"));
        WebElement password = driver.findElement(By.name("password"));
        
        username.sendKeys("admin");
        password.sendKeys("admin123");
        
        // Submit form
        WebElement submitBtn = driver.findElement(
            By.cssSelector("button[type='submit']"));
        submitBtn.click();
        
        // Verify redirect to dashboard
        assertTrue(driver.getCurrentUrl().contains("dashboard"));
        
        // Verify dashboard elements present
        WebElement welcomeMsg = driver.findElement(
            By.className("welcome-message"));
        assertNotNull(welcomeMsg);
    }
    
    @After
    public void tearDown() {
        driver.quit();
    }
}
```

---

### Test Execution and Continuous Integration

#### Maven Integration

Add to `pom.xml`:
```xml
<build>
    <plugins>
        <plugin>
            <groupId>org.apache.maven.plugins</groupId>
            <artifactId>maven-surefire-plugin</artifactId>
            <version>2.22.2</version>
            <configuration>
                <includes>
                    <include>**/*Test.java</include>
                </includes>
            </configuration>
        </plugin>
    </plugins>
</build>
```

#### Running Tests

**Run all tests**:
```bash
mvn test
```

**Run specific test class**:
```bash
mvn test -Dtest=ReservationDAOTest
```

**Run with coverage report**:
```bash
mvn clean test jacoco:report
```

---

### Test Coverage Goals

| Component | Target Coverage | Rationale |
|-----------|----------------|-----------|
| Model Classes | 100% | Simple POJOs, easy to test completely |
| DAO Layer | 90% | Critical data access, high coverage needed |
| Service Layer | 85% | Business logic validation |
| Servlets | 70% | Integration tested via E2E tests |
| Overall | 80% | Balanced coverage across application |

---

### Benefits Achieved Through TDD

1. **Early Bug Detection**: Issues caught during development, not production
2. **Better Design**: TDD forces modular, testable code design
3. **Regression Prevention**: Test suite prevents breaking existing features
4. **Living Documentation**: Tests serve as usage examples
5. **Confidence in Refactoring**: Can improve code without fear
6. **Faster Development**: Less debugging time in the long run

---

## Application Screenshots

The following screenshots demonstrate the complete functionality of the Ocean View Hotel Management System:

### 1. Login Page
![Login Page](screen-shots/Screenshot%202026-03-07%20035007.png)
*User authentication interface where staff members log in to access the system*

---

### 2. Dashboard
![Dashboard](screen-shots/Screenshot%202026-03-07%20033732.png)
*Main dashboard showing key metrics: total reservations, room statistics, and revenue information*

---

### 3. Add Reservation
![Add Reservation](screen-shots/Screenshot%202026-03-07%20033809.png)
*Form for creating new guest reservations with guest details and room preferences*

---

### 4. View Reservations
![View Reservations](screen-shots/Screenshot%202026-03-07%20033835.png)
*Complete list of all reservations with search and filter capabilities*

---

### 5. Update Reservation
![Update Reservation](screen-shots/Screenshot%202026-03-07%20033857.png)
*Interface for modifying existing reservation details*

---

### 6. Reservation Details
![Reservation Details](screen-shots/Screenshot%202026-03-07%20033914.png)
*Detailed view of individual reservation information*

---

### 7. Room Management
![Room Management](screen-shots/Screenshot%202026-03-07%20033933.png)
*Manage room types and pricing information*

---

### 8. Add Room Type
![Add Room Type](screen-shots/Screenshot%202026-03-07%20033953.png)
*Interface for adding new room types to the system*

---

### 9. Update Room
![Update Room](screen-shots/Screenshot%202026-03-07%20034009.png)
*Modify existing room type details and pricing*

---

### 10. Bill Generation
![Bill Generation](screen-shots/Screenshot%202026-03-07%20034044.png)
*Generate bills for reservations by entering reservation number*

---

### 11. Bill Result
![Bill Result](screen-shots/Screenshot%202026-03-07%20034112.png)
*Detailed bill showing all charges, calculations, and payment status*

---

### 12. Bill Details
![Bill Details](screen-shots/Screenshot%202026-03-07%20034129.png)
*Comprehensive bill information with breakdown of charges*

---

### 13. User Management
![User Management](screen-shots/Screenshot%202026-03-07%20034201.png)
*Manage system users and their access permissions*

---

### 14. Add User
![Add User](screen-shots/Screenshot%202026-03-07%20034219.png)
*Create new user accounts for staff members*

---

### 15. Update User
![Update User](screen-shots/Screenshot%202026-03-07%20034245.png)
*Modify existing user account details*

---

### 16. Help/Documentation
![Help Page](screen-shots/Screenshot%202026-03-07%20034303.png)
*In-application help and documentation for users*

---

### 17. Navigation Menu
![Navigation](screen-shots/Screenshot%202026-03-07%20034318.png)
*Side navigation showing all available modules*

---

### 18. Additional Views
![Additional View 1](screen-shots/Screenshot%202026-03-07%20034339.png)
![Additional View 2](screen-shots/Screenshot%202026-03-07%20034357.png)
![Additional View 3](screen-shots/Screenshot%202026-03-07%20034413.png)
*Additional system views and interfaces*

---

## Comprehensive User Manual

### 1. Purpose of the User Manual

This section provides a complete operational guide for hotel staff and administrators to use the Ocean View Hotel Management System in day-to-day work.

**Target users**:
- Reception and front desk staff
- Billing and accounts staff
- Hotel administrators

**Main modules covered**:
- Authentication (Login/Logout)
- Dashboard monitoring
- Reservation management
- Room and room inventory management
- Bill generation and payment status tracking
- User administration
- Help and support navigation

---

### 2. System Access

#### 2.1 Login URL
Use the following URL after deployment:

```text
http://localhost:8080/oceanview/login.jsp
```

#### 2.2 Login Credentials
Use a valid system account.

Example default account:

```text
Username: admin
Password: password
```

#### 2.3 Login Screen
![Login Page - User Manual](screen-shots/Screenshot%202026-03-07%20035007.png)

**Fields and actions**:
- `Username`: Enter your assigned username
- `Password`: Enter your password
- `Login` button: Submit credentials and start session

---

### 3. Quick Start Workflow

Use this quick operational order for normal hotel operations:

1. Login to the system
2. Check Dashboard for current status
3. Add or update reservations
4. Verify room availability and room status
5. Generate bill for guest at checkout
6. Update payment status
7. Logout after work

---

### 4. Dashboard Module

#### 4.1 Purpose
Dashboard provides a snapshot of hotel operations, including reservation counts and financial indicators.

#### 4.2 Dashboard Screen
![Dashboard - User Manual](screen-shots/Screenshot%202026-03-07%20033732.png)

#### 4.3 How to Use
1. Open dashboard immediately after login
2. Review key cards/widgets
3. Identify pending tasks (new reservations, pending bills, room status)
4. Navigate using side menu to required module

#### 4.4 Best Practice
- Refresh dashboard before shift handover
- Use dashboard as daily summary for admin reporting

---

### 5. Reservation Management Module

#### 5.1 Add Reservation

**Screen**:
![Add Reservation - User Manual](screen-shots/Screenshot%202026-03-07%20033809.png)

**Step-by-step**:
1. Open `Add Reservation`
2. Enter reservation number
3. Enter guest name, address, and contact number
4. Select room type
5. Select check-in and check-out dates
6. Click save/submit

**Validation rules**:
- All mandatory fields must be filled
- Contact number must be in valid format
- Check-out date must be after check-in date

**Expected outcome**:
- Reservation record is stored in database
- Confirmation appears or user is redirected to reservation view

#### 5.2 View Reservations

**Screen**:
![View Reservations - User Manual](screen-shots/Screenshot%202026-03-07%20033835.png)

**What you can do**:
- View complete list of reservations
- Search/filter by guest, reservation number, or room type
- Open update or delete actions for selected record

#### 5.3 Update Reservation

**Screen**:
![Update Reservation - User Manual](screen-shots/Screenshot%202026-03-07%20033857.png)

**Steps**:
1. Open reservation list
2. Select reservation to edit
3. Modify required fields
4. Save changes
5. Verify updated values in the reservation table

#### 5.4 Reservation Details View

**Screen**:
![Reservation Details - User Manual](screen-shots/Screenshot%202026-03-07%20033914.png)

Use this page to confirm complete guest and stay details before billing or check-in decisions.

#### 5.5 Operational Tips
- Always verify contact number before saving
- Confirm dates twice to avoid billing mistakes
- Use reservation number consistently when generating bills

---

### 6. Room Management Module

#### 6.1 Room Types and Pricing

**Room Management Screen**:
![Room Management - User Manual](screen-shots/Screenshot%202026-03-07%20033933.png)

Use this module to maintain room categories and nightly rates.

#### 6.2 Add Room Type

**Screen**:
![Add Room Type - User Manual](screen-shots/Screenshot%202026-03-07%20033953.png)

**Steps**:
1. Open room management
2. Click add room type
3. Enter room type name
4. Enter price per night
5. Save record

#### 6.3 Update Room Type / Price

**Screen**:
![Update Room - User Manual](screen-shots/Screenshot%202026-03-07%20034009.png)

**Steps**:
1. Select room type to edit
2. Update price or configuration
3. Save changes
4. Confirm update in room list

#### 6.4 Inventory and Status Concepts
Room inventory status values generally include:
- `AVAILABLE`
- `OCCUPIED`
- `CLEANING`
- `MAINTENANCE`

Use inventory status to prevent assigning unavailable rooms.

---

### 7. Billing Module

#### 7.1 Generate Bill

**Screen**:
![Bill Generation - User Manual](screen-shots/Screenshot%202026-03-07%20034044.png)

**Steps**:
1. Open bill generation page
2. Enter reservation number
3. Submit to fetch reservation details
4. System calculates number of nights
5. System calculates total amount
6. Save generated bill

#### 7.2 View Bill Result

**Screen**:
![Bill Result - User Manual](screen-shots/Screenshot%202026-03-07%20034112.png)

This page shows generated bill details and payment information.

#### 7.3 Bill Details and Verification

**Screen**:
![Bill Details - User Manual](screen-shots/Screenshot%202026-03-07%20034129.png)

Verify:
- Reservation number
- Guest name
- Room type
- Check-in/check-out
- Number of nights
- Price per night
- Total amount
- Payment status

#### 7.4 Billing Formula
```text
Number of Nights = Check-Out Date - Check-In Date
Total Amount = Number of Nights x Price Per Night
```

#### 7.5 Billing Best Practices
- Verify reservation dates before bill generation
- Confirm room type rate against current room settings
- Update payment status immediately after payment is received

---

### 8. User Management Module

#### 8.1 User List and Access Control

**Screen**:
![User Management - User Manual](screen-shots/Screenshot%202026-03-07%20034201.png)

Use this module to manage operator and admin accounts.

#### 8.2 Add User

**Screen**:
![Add User - User Manual](screen-shots/Screenshot%202026-03-07%20034219.png)

**Steps**:
1. Open user management
2. Click add user
3. Enter username and password
4. Assign role
5. Save user

#### 8.3 Update User

**Screen**:
![Update User - User Manual](screen-shots/Screenshot%202026-03-07%20034245.png)

**Steps**:
1. Select target user
2. Edit username, password, or role
3. Save changes

#### 8.4 User Management Best Practices
- Avoid sharing one account among multiple staff
- Change passwords periodically
- Keep at least one admin account active

---

### 9. Navigation and Help Module

#### 9.1 Help Page

**Screen**:
![Help Page - User Manual](screen-shots/Screenshot%202026-03-07%20034303.png)

Use this page for in-application guidance and operational notes.

#### 9.2 Side Navigation Menu

**Screen**:
![Navigation - User Manual](screen-shots/Screenshot%202026-03-07%20034318.png)

Main navigation provides direct access to:
- Dashboard
- Reservations
- Rooms
- Bills
- Users
- Help

#### 9.3 Additional UI Views
![Additional View 1 - User Manual](screen-shots/Screenshot%202026-03-07%20034339.png)
![Additional View 2 - User Manual](screen-shots/Screenshot%202026-03-07%20034357.png)
![Additional View 3 - User Manual](screen-shots/Screenshot%202026-03-07%20034413.png)

These screens represent supplementary interfaces and workflow states used by staff during operations.

---

### 10. Logout and Session Safety

1. Complete all pending updates
2. Click logout from navigation
3. Confirm redirect to login page
4. Close browser on shared computers

**Important**:
- Do not leave dashboard open on public/shared devices
- Re-login if session expires

---

### 11. Error Handling and Troubleshooting

#### 11.1 Common Issues and Fixes

**Issue**: Login fails with valid username format  
**Action**: Verify password case sensitivity and check if user exists in `users` table

**Issue**: Reservation not saved  
**Action**: Confirm all required fields are filled and date range is valid

**Issue**: Bill total seems incorrect  
**Action**: Recheck check-in/check-out dates and room rate configuration

**Issue**: Room not available  
**Action**: Check room inventory status (`AVAILABLE`, `OCCUPIED`, `CLEANING`, `MAINTENANCE`)

**Issue**: Database connectivity problem  
**Action**: Verify MySQL service status and `DBConnection.java` credentials

#### 11.2 Error Page
If a system error occurs, the application redirects to:

```text
error.jsp
```

Collect screenshot and timestamp of the error before reporting to technical support.

---

### 12. Daily Operations Checklist

Use this checklist at each shift:

1. Login and review dashboard
2. Confirm room inventory readiness
3. Process new reservations
4. Update reservation changes/cancellations
5. Generate checkout bills
6. Mark paid bills correctly
7. Verify no pending critical tasks
8. Logout securely

---

### 13. User Manual Assumptions

1. User has valid account credentials
2. Database is running and accessible
3. Room types are pre-configured
4. Staff follows standard reservation and billing process
5. Application is deployed at `/oceanview`

---

## Installation and Setup

### Prerequisites
- Java JDK 8 or higher
- Apache Tomcat 9.0 or higher
- MySQL 8.0 or higher
- Maven 3.6 or higher

### Database Setup

1. **Create Database**:
```sql
CREATE DATABASE oceanview_db;
```

2. **Import Schema**:
```bash
mysql -u root -p oceanview_db < src/main/database/database.sql
```

3. **Configure Connection**:
Update database credentials in `DBConnection.java`:
```java
private static final String JDBC_URL = "jdbc:mysql://localhost:3306/oceanview_db";
private static final String USERNAME = "your_username";
private static final String PASSWORD = "your_password";
```

### Application Deployment

1. **Clone Repository**:
```bash
git clone <repository-url>
cd oceanview-prod
```

2. **Build Project**:
```bash
mvn clean package
```

3. **Deploy to Tomcat**:
- Copy `target/oceanview.war` to Tomcat `webapps/` directory
- Or deploy via Tomcat Manager

4. **Access Application**:
```
http://localhost:8080/oceanview/login.jsp
```

### Default Login Credentials
```
Username: admin
Password: admin123
```

---

## Project Structure

```
oceanview-prod/
├── src/
│   ├── main/
│   │   ├── java/com/icbt/
│   │   │   ├── controller/     # Servlets
│   │   │   ├── dao/            # Data Access Objects
│   │   │   ├── model/          # Entity classes
│   │   │   ├── service/        # Business logic
│   │   │   └── util/           # Utilities
│   │   ├── webapp/
│   │   │   ├── views/          # JSP pages
│   │   │   ├── css/            # Stylesheets
│   │   │   ├── js/             # JavaScript files
│   │   │   └── WEB-INF/        # Configuration
│   │   └── database/           # SQL scripts
│   └── test/                   # Test files
├── pom.xml                     # Maven configuration
└── README.md                   # This file
```

---

## Features

✅ User Authentication and Authorization  
✅ Reservation Management (CRUD)  
✅ Room Type Management  
✅ Automated Bill Generation  
✅ Dashboard with Analytics  
✅ User Management  
✅ Responsive UI  
✅ Form Validation  
✅ Session Management  

---

## Future Enhancements

- [ ] Room availability calendar
- [ ] Email notifications for reservations
- [ ] Payment gateway integration
- [ ] Guest self-service portal
- [ ] Mobile responsive design
- [ ] Advanced reporting and analytics
- [ ] Multi-property support
- [ ] API endpoints for third-party integration

---

## License

This project is developed as part of academic coursework.

---

## Contact

For questions or support, please contact the development team.

---

**Last Updated**: March 7, 2026  
**Version**: 1.0.0  
**Status**: Production Ready
