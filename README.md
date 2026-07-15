# GramSathi – Rural Smart Assistance Platform

GramSathi is a complete, production-quality, responsive web application designed for village communities to manage governance services, scheme discovery, local job opportunities, agricultural advice, healthcare alerts, emergency services, and community markets.

---

## 🛠️ Technology Stack

- **Frontend**: HTML5, CSS3 (Custom Glassmorphism), Bootstrap 5, Javascript
- **Backend**: Python Flask
- **Database**: MySQL / SQLite (Flask-SQLAlchemy Object Mapper)
- **APIs**: Web Speech API (Voice Synthesis/Recognition), Leaflet Maps (OpenStreetMap), Custom Weather Advisory API

---

## 🚀 Installation & Setup Guide

### Prerequisites
- Python 3.8 or higher installed on your system.
- VS Code (or any preferred text editor).
- MySQL Server (optional, defaults to zero-setup SQLite out of the box).

### Quick Setup (Using default SQLite)
1. **Clone or Extract** the project folder.
2. Open terminal in the project directory:
   ```bash
   pip install -r requirements.txt
   ```
3. Start the Flask application server:
   ```bash
   python run.py
   ```
4. Open your browser and navigate to `http://localhost:5000`.

### Configure for MySQL (Optional)
1. Log in to your MySQL terminal and run the schema setup script:
   ```sql
   SOURCE schema.sql;
   SOURCE seed_data.sql;
   ```
2. Open `app/config.py` in your text editor.
3. Change the database URI connection string:
   ```python
   # Replace with your MySQL credentials:
   SQLALCHEMY_DATABASE_URI = 'mysql+pymysql://root:password@localhost/gramsathi'
   ```
4. Start the server using `python run.py`.

---

## 🌐 API Documentation

### 1. AJAX Chatbot Endpoint
- **URL**: `/api/chat`
- **Method**: `POST`
- **Payload**: `{"message": "Is there a scheme for students?"}`
- **Response**:
  ```json
  {
    "response": "The Post Matric Scholarship Scheme provides tuition fees coverage...",
    "language": "en"
  }
  ```

### 2. Live Weather Widget Feed
- **URL**: `/api/weather`
- **Method**: `GET`
- **Response**:
  ```json
  {
    "temp": "32°C",
    "humidity": "72%",
    "condition": "Partly Cloudy",
    "location": "Nelakondapally Rural",
    "advisory": "Ideal weather for fertilizer application."
  }
  ```

### 3. Admin Panel Analytics Aggregator
- **URL**: `/api/admin/analytics`
- **Method**: `GET`
- **Response**:
  ```json
  {
    "complaints": {"Submitted": 2, "Under Review": 1, "In Progress": 0, "Resolved": 4},
    "users": {"admin": 1, "user": 12},
    "donations": {"Food": 3, "Clothes": 8, "Books": 4, "Wheelchairs": 1}
  }
  ```

---

## 📊 System Architecture & Diagrams

### 1. Architecture Diagram (MVC Model)
```mermaid
graph TD
    Client[Browser Frontend - Bootstrap 5 & JS] -->|HTTP Requests / AJAX| Controller[Flask Blueprints - auth, main, admin, api]
    Controller -->|Query / Save| Model[SQLAlchemy Models / Database Schema]
    Model -->|ORM Mapping| Database[(MySQL / SQLite Database)]
    Controller -->|Render Templates| View[Jinja2 HTML Templates - base, dashboard, chatbot]
    View -->|Return HTML/CSS/JS| Client
```

### 2. Entity-Relationship (ER) Diagram
```mermaid
erDiagram
    users {
        int id PK
        string name
        string email
        string phone
        string password_hash
        string role
        timestamp created_at
    }
    schemes {
        int id PK
        string name
        string description
        string benefits
        string required_documents
        int eligibility_age_min
        int eligibility_age_max
        string eligibility_gender
        string eligibility_occupation
        float eligibility_income_max
        string eligibility_category
        string eligibility_state
        string application_process
        string official_link
    }
    jobs {
        int id PK
        string title
        string description
        string employer_name
        string location
        string type
        string salary
        string contact_phone
        string status
        timestamp created_at
    }
    complaints {
        int id PK
        int user_id FK
        string category
        string title
        text description
        string location
        string image_path
        string status
        text admin_remarks
        timestamp created_at
    }
    donations {
        int id PK
        int user_id FK
        string category
        text description
        string quantity
        string contact_info
        string status
        timestamp created_at
    }
    blood_donors {
        int id PK
        int user_id FK
        string blood_group
        string location
        string contact_number
        boolean is_available
        date last_donated_at
    }
    
    users ||--o{ complaints : files
    users ||--o{ donations : posts
    users ||--o{ blood_donors : registers
    jobs ||--o{ users : "applied by"
```

### 3. Use Case Diagram
```mermaid
left_to_right_direction
actor "Village Resident" as Resident
actor "Panchayat Admin" as Admin

rectangle GramSathiPlatform {
    usecase "Register & Login" as UC1
    usecase "Voice Chatbot Assistance" as UC2
    usecase "Filter Welfare Schemes" as UC3
    usecase "Submit & Track Infrastructure Complaints" as UC4
    usecase "Browse/Apply Local Jobs" as UC5
    usecase "Register/Search Blood Donors" as UC6
    usecase "Buy/Sell Marketplace Products" as UC7
    usecase "Update Complaint Resolution Status" as UC8
    usecase "Publish Events & Announcements" as UC9
    usecase "Export Administrative CSV Reports" as UC10
}

Resident --> UC1
Resident --> UC2
Resident --> UC3
Resident --> UC4
Resident --> UC5
Resident --> UC6
Resident --> UC7

Admin --> UC1
Admin --> UC8
Admin --> UC9
Admin --> UC10
```

### 4. Class Diagram
```mermaid
classDiagram
    class User {
        +int id
        +string name
        +string email
        +string phone
        +string password_hash
        +string role
        +set_password(password)
        +check_password(password) bool
        +to_dict() dict
    }
    class Complaint {
        +int id
        +int user_id
        +string category
        +string title
        +string description
        +string location
        +string image_path
        +string status
        +string admin_remarks
        +to_dict() dict
    }
    class Job {
        +int id
        +string title
        +string description
        +string employer_name
        +string location
        +string type
        +string salary
        +string contact_phone
        +string status
        +to_dict() dict
    }
    class BloodDonor {
        +int id
        +int user_id
        +string blood_group
        +string location
        +string contact_number
        +boolean is_available
        +to_dict() dict
    }
    
    User "1" --> "many" Complaint : lodges
    User "1" --> "0..1" BloodDonor : volunteers
    Job "many" --> "many" User : applications
```

### 5. Sequence Diagram (Filing Complaint & Admin Status Shift)
```mermaid
sequenceDiagram
    autonumber
    actor Resident as Village Resident
    participant View as Web Browser (JS)
    participant Ctrl as Flask Backend (admin/main blueprints)
    participant DB as Database (SQLAlchemy)
    actor Admin as Panchayat Admin

    Resident->>View: File road complaint (attach photo)
    View->>Ctrl: POST /complaints (Multipart form)
    Ctrl->>DB: INSERT INTO complaints (status='Submitted')
    DB-->>Ctrl: Save successful
    Ctrl-->>View: Flash redirect response
    View-->>Resident: Show Tracking ID (GS-COMP-X)

    Admin->>View: Access Admin Dashboard
    View->>Ctrl: GET /admin/dashboard
    Ctrl->>DB: Query complaints list
    DB-->>Ctrl: Returns lists
    Ctrl-->>View: Render templates page
    Admin->>View: Mark GS-COMP-X as 'In Progress' with remarks
    View->>Ctrl: POST /admin/complaints/update/X
    Ctrl->>DB: UPDATE complaint SET status='In Progress'
    Ctrl->>DB: INSERT INTO notifications for resident user
    DB-->>Ctrl: Save completed
    Ctrl-->>View: Redirect dashboard tab
    View-->>Admin: Show Success Alert
```

### 6. Data Flow Diagram (Level 1)
```mermaid
graph LR
    User[Village Resident] -->|Register Details| Auth[1.0 Registration & Login]
    Auth -->|Credentials| UserDB[(Users Table)]
    
    User -->|Age, Income parameters| Finder[2.0 Scheme Finder]
    Finder -->|Select Matching| SchemesDB[(Schemes Table)]
    
    User -->|Infrastructure issue details| ComplaintPortal[3.0 Complaint Portal]
    ComplaintPortal -->|Insert complaint row| ComplaintsDB[(Complaints Table)]
    
    Admin[Panchayat Admin] -->|Review complaint & Update status| ComplaintPortal
    ComplaintsDB -->|Query lists| Admin
```

---

## 🔒 Security Practices

1. **Password Hashing**: GramSathi utilizes PBKDF2 cryptography hashes via the `werkzeug.security` module. Unencrypted passwords are never stored.
2. **SQL Injection Prevention**: SQLAlchemy parameterized ORM queries are utilized exclusively, eliminating traditional raw SQL injection vulnerabilities.
3. **Session Management**: Session isolation is maintained using server-signed cookies containing a cryptographically secure key signature.
