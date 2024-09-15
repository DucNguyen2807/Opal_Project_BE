CREATE DATABASE Opal_Exe;
GO

USE Opal_Exe;
GO

-- Quản lý thông tin người dùng với thêm cột role và user_id đổi sang NVARCHAR(36)
CREATE TABLE Users (
    user_id NVARCHAR(36) PRIMARY KEY DEFAULT NEWID(),
    username VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    email VARCHAR(100),
    phone_number VARCHAR(20),
    subscription_plan NVARCHAR(50), -- No default value
    role NVARCHAR(50), -- New role column
    created_at DATETIME,
    updated_at DATETIME
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
    event_time DATETIME NOT NULL,
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

-- Quản lý gói đăng ký
CREATE TABLE Subscriptions (
    subscription_id NVARCHAR(36) PRIMARY KEY DEFAULT NEWID(),
    user_id NVARCHAR(36),
    [plan] NVARCHAR(50) NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    payment_amount DECIMAL(10, 2),
    payment_method NVARCHAR(50) NOT NULL,
    status NVARCHAR(50), -- No default value
    created_at DATETIME,
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
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


  -- Insert sample data into Users table
INSERT INTO Users (user_id, username, password, email, phone_number, subscription_plan, role, created_at, updated_at)
VALUES 
  (NEWID(), 'admin1', 'hashedpassword1', 'admin1@example.com', '0123456789', 'Premium', 'Admin', GETDATE(), GETDATE()),
  (NEWID(), 'user1', 'hashedpassword2', 'user1@example.com', '0987654321', 'Basic', 'User', GETDATE(), GETDATE()),
  (NEWID(), 'admin2', 'hashedpassword3', 'admin2@example.com', '0123456780', 'Premium', 'Admin', GETDATE(), GETDATE()),
  (NEWID(), 'user2', 'hashedpassword4', 'user2@example.com', '0987654320', 'Free', 'User', GETDATE(), GETDATE());