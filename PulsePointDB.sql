-- Create the PulsePointDB database
CREATE DATABASE PulsePointDB;
GO

USE PulsePointDB;
GO

-- ====================================================
-- Create Patients Table (for registration and login)
-- ====================================================
CREATE TABLE Patients (
    PatientId INT IDENTITY(1,1) PRIMARY KEY,
    FirstName NVARCHAR(50) NOT NULL,
    LastName NVARCHAR(50) NOT NULL,
    ContactNumber NVARCHAR(20) NULL,
    Email NVARCHAR(100) NOT NULL UNIQUE,
    Password NVARCHAR(256) NOT NULL,  -- store hashed passwords in production
    CreatedDate DATETIME DEFAULT GETDATE()
);
GO

-- ====================================================
-- Create Doctors Table
-- ====================================================
CREATE TABLE Doctors (
    DoctorId INT IDENTITY(1,1) PRIMARY KEY,
    Name NVARCHAR(100) NOT NULL,
    Specialty NVARCHAR(100) NULL,
    Email NVARCHAR(100) NOT NULL UNIQUE,
    Phone NVARCHAR(20) NULL,
    Password NVARCHAR(256) NOT NULL,
    CreatedDate DATETIME DEFAULT GETDATE()
);
GO

-- ====================================================
-- Create Secretaries Table
-- ====================================================
CREATE TABLE Secretaries (
    SecretaryId INT IDENTITY(1,1) PRIMARY KEY,
    FirstName NVARCHAR(50) NOT NULL,
    LastName NVARCHAR(50) NOT NULL,
    Email NVARCHAR(100) NOT NULL UNIQUE,
    ContactNumber NVARCHAR(20) NULL,
    Password NVARCHAR(256) NOT NULL,
    CreatedDate DATETIME DEFAULT GETDATE()
);
GO

-- ====================================================
-- Create Appointments Table
-- ====================================================
CREATE TABLE Appointments (
    AppointmentId INT IDENTITY(1,1) PRIMARY KEY,
    AppointmentDateTime DATETIME NOT NULL,
    PatientId INT NOT NULL,
    DoctorId INT NOT NULL,
    MedicalReason NVARCHAR(100) NOT NULL,  -- e.g. Consultation, Clearance, Follow Up, Check Up
    Status NVARCHAR(50) NOT NULL DEFAULT 'Pending',
    QueueNumber INT NULL,
    CreatedDate DATETIME DEFAULT GETDATE(),
    CONSTRAINT FK_Appointments_Patients FOREIGN KEY (PatientId) REFERENCES Patients(PatientId),
    CONSTRAINT FK_Appointments_Doctors FOREIGN KEY (DoctorId) REFERENCES Doctors(DoctorId)
);
GO

-- ====================================================
-- Insert Sample Data into Patients Table
-- ====================================================
INSERT INTO Patients (FirstName, LastName, ContactNumber, Email, Password)
VALUES 
('John', 'Doe', '1234567890', 'johndoe@example.com', 'hashed_password1'),
('Jane', 'Smith', '2345678901', 'janesmith@example.com', 'hashed_password2');
GO

-- ====================================================
-- Insert Sample Data into Doctors Table
-- ====================================================
INSERT INTO Doctors (Name, Specialty, Email, Phone, Password)
VALUES
('Fabio Enrique Posas', 'Cardiologist', 'fabio.posas@example.com', '9876543210', 'hashed_password_doc');
GO

-- ====================================================
-- Insert Sample Data into Secretaries Table
-- ====================================================
INSERT INTO Secretaries (FirstName, LastName, Email, ContactNumber, Password)
VALUES
('Alice', 'Wonderland', 'alice@example.com', '5551112222', 'hashed_password_sec');
GO

-- ====================================================
-- Insert Sample Data into Appointments Table
-- ====================================================
INSERT INTO Appointments (AppointmentDateTime, PatientId, DoctorId, MedicalReason, Status, QueueNumber)
VALUES
(DATEADD(HOUR, 2, GETDATE()), 1, 1, 'Consultation', 'Pending', 1),
(DATEADD(HOUR, 3, GETDATE()), 2, 1, 'Follow Up', 'Pending', 2);
GO

-- ====================================================
-- Select Statements to View Data in Each Table
-- ====================================================
SELECT * FROM Patients;
GO

SELECT * FROM Doctors;
GO

SELECT * FROM Secretaries;
GO

SELECT * FROM Appointments;
GO

