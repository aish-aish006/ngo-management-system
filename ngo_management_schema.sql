
-- NGO Management Database Schema

CREATE DATABASE IF NOT EXISTS ngo_management;
USE ngo_management;

-- 1. NGO Table
CREATE TABLE NGO (
    ngo_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    registration_no VARCHAR(100),
    established_date DATE,
    address TEXT,
    contact_no VARCHAR(20),
    email VARCHAR(100),
    website VARCHAR(100)
);

-- 2. Volunteer Table
CREATE TABLE Volunteer (
    volunteer_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    age INT,
    gender ENUM('Male', 'Female', 'Other'),
    contact_no VARCHAR(20),
    email VARCHAR(100),
    address TEXT,
    skills TEXT,
    availability VARCHAR(100)
);

-- 3. Donor Table
CREATE TABLE Donor (
    donor_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    phone VARCHAR(20) UNIQUE,
    email VARCHAR(100) UNIQUE,
    donation_amount DECIMAL(10,2),
    donation_date DATE,
    payment_method ENUM('Cash', 'Online', 'Cheque'),
    ngo_id INT,
    FOREIGN KEY (ngo_id) REFERENCES NGO(ngo_id)
);

-- 4. Project Table
CREATE TABLE Project (
    project_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255),
    start_date DATE,
    end_date DATE,
    budget DECIMAL(10,2),
    description TEXT,
    status ENUM('Ongoing', 'Completed', 'Pending'),
    ngo_id INT,
    FOREIGN KEY (ngo_id) REFERENCES NGO(ngo_id)
);

-- 5. Volunteer_Assignment Table
CREATE TABLE Volunteer_Assignment (
    assignment_id INT AUTO_INCREMENT PRIMARY KEY,
    volunteer_id INT,
    project_id INT,
    assigned_date DATE,
    role VARCHAR(100),
    FOREIGN KEY (volunteer_id) REFERENCES Volunteer(volunteer_id),
    FOREIGN KEY (project_id) REFERENCES Project(project_id)
);

-- 6. Beneficiary Table
CREATE TABLE Beneficiary (
    beneficiary_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255),
    age INT,
    gender ENUM('Male', 'Female', 'Other'),
    contact_no VARCHAR(20),
    address TEXT,
    support_received TEXT
);

-- 7. Event Table
CREATE TABLE Event (
    event_id INT AUTO_INCREMENT PRIMARY KEY,
    event_name VARCHAR(255),
    date DATE,
    location VARCHAR(255),
    description TEXT,
    ngo_id INT,
    FOREIGN KEY (ngo_id) REFERENCES NGO(ngo_id)
);

-- 8. Core_Team Table
CREATE TABLE Core_Team (
    member_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255),
    designation VARCHAR(100),
    contact_no VARCHAR(20),
    email VARCHAR(100),
    ngo_id INT,
    FOREIGN KEY (ngo_id) REFERENCES NGO(ngo_id)
);

-- 9. Funds Table
CREATE TABLE Funds (
    fund_id INT AUTO_INCREMENT PRIMARY KEY,
    source VARCHAR(255),
    amount DECIMAL(10,2),
    received_date DATE,
    allocated_to VARCHAR(255),
    ngo_id INT,
    FOREIGN KEY (ngo_id) REFERENCES NGO(ngo_id)
);
