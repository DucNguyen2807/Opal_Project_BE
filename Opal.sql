CREATE DATABASE Opal_Exe;
GO

USE Opal_Exe;
GO

-- Quản lý thông tin người dùng với thêm cột role và user_id đổi sang NVARCHAR(36)
CREATE TABLE Users (
    user_id NVARCHAR(36) PRIMARY KEY DEFAULT NEWID(),
    username VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
	fullname NVARCHAR(255),
    email VARCHAR(100),
	gender NVARCHAR(100),
    phone_number VARCHAR(20),
    subscription_plan NVARCHAR(50), -- No default value
    role NVARCHAR(50), -- New role column
    created_at DATETIME,
    updated_at DATETIME
);
GO
-- Bảng OTPCode để lưu mã OTP
CREATE TABLE OTPCode (
    Id NVARCHAR(36) PRIMARY KEY DEFAULT NEWID(),
    OTP CHAR(6) NOT NULL,
    CreatedAt DATETIME NOT NULL,
    IsUsed BIT NOT NULL,
    CreatedBy NVARCHAR(36) NOT NULL,
    FOREIGN KEY (CreatedBy) REFERENCES Users(user_id)
);

GO
-- Quản lý các công việc người dùng
CREATE TABLE Tasks (
    task_id NVARCHAR(36) PRIMARY KEY DEFAULT NEWID(),
    user_id NVARCHAR(36),
    title NVARCHAR(255) NOT NULL,
    description NVARCHAR(MAX),
    priority NVARCHAR(50), -- No default value
    due_date DATETIME,
    is_completed BIT, -- No default value
    status NVARCHAR(50), -- No default value
    created_at DATETIME,
    updated_at DATETIME,
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);
GO

-- Sự kiện nhắc nhở
CREATE TABLE Events (
    event_id NVARCHAR(36) PRIMARY KEY DEFAULT NEWID(),
    user_id NVARCHAR(36),
    event_title NVARCHAR(255) NOT NULL,
    event_description NVARCHAR(MAX),
    start_time DATETIME NOT NULL,
	end_time DATETIME NOT NULL,
    notification_time DATETIME,
    recurring BIT, -- No default value
    created_at DATETIME,
    updated_at DATETIME,
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);
GO

-- Điểm tích lũy để nuôi lớn con vẹt
CREATE TABLE Seeds (
    seed_id NVARCHAR(36) PRIMARY KEY DEFAULT NEWID(),
    user_id NVARCHAR(36),
    seed_count INT, -- No default value
    parrot_level NVARCHAR(50), -- No default value
    created_at DATETIME,
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);
GO

GO
-- Quản lý gói đăng ký
CREATE TABLE Subscriptions (
    subscription_id NVARCHAR(36) PRIMARY KEY DEFAULT NEWID(),
    SubName NVARCHAR(150) NOT NULL,
    Duration DATE NOT NULL,
    Price DECIMAL(10, 2),
    SubDescription NVARCHAR(MAX) NOT NULL,
    status NVARCHAR(50), -- No default value

);
GO

-- Quản lý gói đăng ký
CREATE TABLE UserSub (
    UserSubID NVARCHAR(36) PRIMARY KEY DEFAULT NEWID(),
    user_id NVARCHAR(36),
    subscription_id NVARCHAR(36),
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    status NVARCHAR(50), -- No default value
    created_at DATETIME,
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (subscription_id) REFERENCES Subscriptions(subscription_id)

);
GO
-- Nhắc nhở công việc và sự kiện
CREATE TABLE Notifications (
    notification_id NVARCHAR(36) PRIMARY KEY DEFAULT NEWID(),
    user_id NVARCHAR(36),
    task_id NVARCHAR(36),
    event_id NVARCHAR(36),
    notification_time DATETIME NOT NULL,
    is_sent BIT, -- No default value
    notification_type NVARCHAR(50), -- No default value
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (task_id) REFERENCES Tasks(task_id),
    FOREIGN KEY (event_id) REFERENCES Events(event_id)
);
GO

-- Custom
CREATE TABLE Customizations (
    customization_id NVARCHAR(36) PRIMARY KEY DEFAULT NEWID(),
    user_id NVARCHAR(36),
    theme NVARCHAR(50), -- No default value
    parrot_hat NVARCHAR(50),
    created_at DATETIME,
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);
GO

-- Payment
CREATE TABLE Payments (
    payment_id NVARCHAR(36) PRIMARY KEY DEFAULT NEWID(),
    user_id NVARCHAR(36),
    subscription_id NVARCHAR(36), 
    transaction_id NVARCHAR(100) UNIQUE NOT NULL,
    amount DECIMAL(10, 2) NOT NULL,
    payment_method NVARCHAR(50) NOT NULL, 
    payment_date DATETIME,
    status NVARCHAR(50), -- No default value
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (subscription_id) REFERENCES Subscriptions(subscription_id)
);
GO

-- Refresh
CREATE TABLE RefreshTokens (
    token_id NVARCHAR(36) PRIMARY KEY DEFAULT NEWID(),
    user_id NVARCHAR(36),
    refresh_token NVARCHAR(255) NOT NULL,
    issued_at DATETIME,
    expires_at DATETIME NOT NULL,
    is_revoked BIT, -- No default value
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);
GO


  -- Insert dữ liệu vào bảng Tasks
INSERT INTO Tasks (task_id, user_id, title, description, priority, due_date, is_completed, status, created_at, updated_at) 
VALUES 
(NEWID(), 'b34c95b2-b96e-40e0-9c93-bd80b5b7a179', 'Complete Flutter Project', 'Finish the Flutter project by the end of the month', 'High', '2024-09-30', 0, 'Pending', GETDATE(), GETDATE()),
(NEWID(), 'b34c95b2-b96e-40e0-9c93-bd80b5b7a179', 'Write SQL Scripts', 'Write SQL insert scripts for database', 'Medium', '2024-09-25', 0, 'In Progress', GETDATE(), GETDATE());

-- Insert dữ liệu vào bảng Events
INSERT INTO Events (event_id, user_id, event_title, event_description, event_time, notification_time, recurring, created_at, updated_at) 
VALUES 
(NEWID(), 'b34c95b2-b96e-40e0-9c93-bd80b5b7a179', 'Team Meeting', 'Monthly meeting with the team', '2024-09-28 10:00:00', '2024-09-28 09:00:00', 0, GETDATE(), GETDATE()),
(NEWID(), 'b34c95b2-b96e-40e0-9c93-bd80b5b7a179', 'Doctor Appointment', 'Regular health checkup', '2024-10-01 14:00:00', '2024-10-01 13:30:00', 0, GETDATE(), GETDATE());

-- Insert dữ liệu vào bảng Seeds
INSERT INTO Seeds (seed_id, user_id, seed_count, parrot_level, created_at) 
VALUES 
(NEWID(), 'b34c95b2-b96e-40e0-9c93-bd80b5b7a179', 100, 'Level 1', GETDATE());

-- Insert dữ liệu vào bảng Subscriptions
INSERT INTO Subscriptions (subscription_id, SubName, Duration, Price, SubDescription, status) 
VALUES 
(NEWID(), 'Premium', '2024-12-31', 9.99, 'Access to premium features including task scheduling and parrot upgrades', 'Active'),
(NEWID(), 'Standard', '2024-12-31', 4.99, 'Access to basic features like task management and notifications', 'Active');

-- Insert dữ liệu vào bảng UserSub
INSERT INTO UserSub (UserSubID, user_id, subscription_id, start_date, end_date, status, created_at) 
VALUES 
(NEWID(), 'b34c95b2-b96e-40e0-9c93-bd80b5b7a179', (SELECT subscription_id FROM Subscriptions WHERE SubName = 'Premium'), '2024-09-22', '2025-09-22', 'Active', GETDATE());

-- Insert dữ liệu vào bảng Notifications
INSERT INTO Notifications (notification_id, user_id, task_id, event_id, notification_time, is_sent, notification_type) 
VALUES 
(NEWID(), 'b34c95b2-b96e-40e0-9c93-bd80b5b7a179', (SELECT task_id FROM Tasks WHERE title = 'Complete Flutter Project'), NULL, '2024-09-30 08:00:00', 0, 'Task'),
(NEWID(), 'b34c95b2-b96e-40e0-9c93-bd80b5b7a179', NULL, (SELECT event_id FROM Events WHERE event_title = 'Team Meeting'), '2024-09-28 09:00:00', 0, 'Event');

-- Insert dữ liệu vào bảng Customizations
INSERT INTO Customizations (customization_id, user_id, theme, parrot_hat, created_at) 
VALUES 
(NEWID(), 'b34c95b2-b96e-40e0-9c93-bd80b5b7a179', 'Dark', 'Pirate Hat', GETDATE());

-- Insert dữ liệu vào bảng Payments
INSERT INTO Payments (payment_id, user_id, subscription_id, transaction_id, amount, payment_method, payment_date, status) 
VALUES 
(NEWID(), 'b34c95b2-b96e-40e0-9c93-bd80b5b7a179', (SELECT subscription_id FROM Subscriptions WHERE SubName = 'Premium'), 'TX123456789', 9.99, 'Credit Card', GETDATE(), 'Completed');

