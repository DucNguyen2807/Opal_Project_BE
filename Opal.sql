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
	Devicetoken Nvarchar(100),
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
	time_task Time,
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
	priority NVARCHAR(100),
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);
GO

-- Điểm tích lũy để nuôi lớn con vẹt
CREATE TABLE Seeds (
    seed_id NVARCHAR(36) PRIMARY KEY DEFAULT NEWID(),
    user_id NVARCHAR(36),
	percent_growth float,
    seed_count INT, -- No default value
    parrot_level INT, -- No default value
    created_at DATETIME,
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);
GO

GO
-- Quản lý gói đăng ký
CREATE TABLE Subscriptions (
    subscription_id NVARCHAR(36) PRIMARY KEY DEFAULT NEWID(),
    SubName NVARCHAR(150) NOT NULL,
    Duration INT NOT NULL,
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

CREATE TABLE Customizations (
    customization_id INT IDENTITY(1,1) PRIMARY KEY, -- Tự động tăng
    ui_color NVARCHAR(50),
    font_color NVARCHAR(50),
    font_1 NVARCHAR(50), 
    font_2 NVARCHAR(50),
    textBox_color NVARCHAR(50),
    button_color NVARCHAR(50),
    created_at DATETIME
);


GO

-- Tạo bảng trung gian UserCustomizations
CREATE TABLE UserCustomizations (
    userCustomization_id NVARCHAR(36) PRIMARY KEY DEFAULT NEWID(),
    user_id NVARCHAR(36),
    customization_id INT,
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (customization_id) REFERENCES Customizations(customization_id)
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



INSERT INTO Customizations (
    ui_color,
    font_color,
    font_1,
    font_2,
    textBox_color,
    button_color,
    created_at
) VALUES (
    '0xFFFFE29A', -- ui_color
    'green', -- font_color
    'Arista', -- font_1
    'KeepCalm', -- font_2
    '0xFFFFA965', -- textBox_color
    '0xFFFFA965', -- button_color
    GETDATE() -- created_at sử dụng thời gian hiện tại
);


  -- Tạo 10 gói đăng ký với subscription_id khác nhau
INSERT INTO Subscriptions (subscription_id, SubName, Duration, Price, SubDescription, status)
VALUES 
(NEWID(), 'Basic Plan', 1, 500000, '1-month basic subscription', 'Active '),
(NEWID(), 'Standard Plan', 3, 12000, '3-month standard subscription', 'Active '),
(NEWID(), 'Premium Plan', 6, 19000, '6-month premium subscription', 'Active '),
(NEWID(), 'Enterprise Plan', 12, 39000, '12-month enterprise subscription', 'Active '),
(NEWID(), 'Student Plan', 12, 90000, '12-month student subscription', 'Active '),
(NEWID(), 'Family Plan', 6, 29999, '6-month family subscription', 'Active '),
(NEWID(), 'Pro Plan', 1, 15000, '1-month pro subscription', 'Active '),
(NEWID(), 'Advanced Plan', 3, 2500000, '3-month advanced subscription', 'Active '),
(NEWID(), 'Ultimate Plan', 12, 45000, '12-month ultimate subscription', 'Active '),
(NEWID(), 'VIP Plan', 12, 99000, '12-month VIP subscription', 'Active ');


-- Tạo 10 bản ghi thanh toán và liên kết với 10 gói đăng ký khác nhau
INSERT INTO Payments (payment_id, user_id, subscription_id, transaction_id, amount, payment_method, payment_date, status)
VALUES 
(NEWID(), 'ec6514b1-4600-45ad-9e67-b8424dd580db', (SELECT subscription_id FROM Subscriptions WHERE SubName = 'Basic Plan'), 'TXN1234567891', 500000, 'Credit Card', GETDATE(), 'Completed'),
(NEWID(), 'ec6514b1-4600-45ad-9e67-b8424dd580db', (SELECT subscription_id FROM Subscriptions WHERE SubName = 'Standard Plan'), 'TXN1234567892', 12999, 'Credit Card', GETDATE(), 'Completed'),
(NEWID(), 'ec6514b1-4600-45ad-9e67-b8424dd580db', (SELECT subscription_id FROM Subscriptions WHERE SubName = 'Premium Plan'), 'TXN1234567893', 199999, 'Credit Card', GETDATE(), 'Completed'),
(NEWID(), 'ec6514b1-4600-45ad-9e67-b8424dd580db', (SELECT subscription_id FROM Subscriptions WHERE SubName = 'Enterprise Plan'), 'TXN1234567894', 390000, 'Credit Card', GETDATE(), 'Completed'),
(NEWID(), 'ec6514b1-4600-45ad-9e67-b8424dd580db', (SELECT subscription_id FROM Subscriptions WHERE SubName = 'Student Plan'), 'TXN1234567895', 999000, 'Credit Card', GETDATE(), 'Completed'),
(NEWID(), 'ec6514b1-4600-45ad-9e67-b8424dd580db', (SELECT subscription_id FROM Subscriptions WHERE SubName = 'Family Plan'), 'TXN1234567896', 29000, 'Credit Card', GETDATE(), 'Completed'),
(NEWID(), 'ec6514b1-4600-45ad-9e67-b8424dd580db', (SELECT subscription_id FROM Subscriptions WHERE SubName = 'Pro Plan'), 'TXN1234567897', 156000, 'Credit Card', GETDATE(), 'Completed'),
(NEWID(), 'ec6514b1-4600-45ad-9e67-b8424dd580db', (SELECT subscription_id FROM Subscriptions WHERE SubName = 'Advanced Plan'), 'TXN1234567898', 250000, 'Credit Card', GETDATE(), 'Completed'),
(NEWID(), 'ec6514b1-4600-45ad-9e67-b8424dd580db', (SELECT subscription_id FROM Subscriptions WHERE SubName = 'Ultimate Plan'), 'TXN1234567899', 4950000, 'Credit Card', GETDATE(), 'Completed'),
(NEWID(), 'ec6514b1-4600-45ad-9e67-b8424dd580db', (SELECT subscription_id FROM Subscriptions WHERE SubName = 'VIP Plan'), 'TXN1234567810', 999000, 'Credit Card', GETDATE(), 'Completed');

-- Tạo 10 bản ghi gói đăng ký người dùng
INSERT INTO UserSub (UserSubID, user_id, subscription_id, start_date, end_date, status, created_at)
VALUES
(NEWID(), 'ec6514b1-4600-45ad-9e67-b8424dd580db', (SELECT subscription_id FROM Subscriptions WHERE SubName = 'Basic Plan'), GETDATE(), DATEADD(MONTH, 1, GETDATE()), 'Active ', GETDATE()),
(NEWID(), 'ec6514b1-4600-45ad-9e67-b8424dd580db', (SELECT subscription_id FROM Subscriptions WHERE SubName = 'Standard Plan'), GETDATE(), DATEADD(MONTH, 3, GETDATE()), 'Active ', GETDATE()),
(NEWID(), 'ec6514b1-4600-45ad-9e67-b8424dd580db', (SELECT subscription_id FROM Subscriptions WHERE SubName = 'Premium Plan'), GETDATE(), DATEADD(MONTH, 6, GETDATE()), 'Active ', GETDATE()),
(NEWID(), 'ec6514b1-4600-45ad-9e67-b8424dd580db', (SELECT subscription_id FROM Subscriptions WHERE SubName = 'Enterprise Plan'), GETDATE(), DATEADD(MONTH, 12, GETDATE()), 'Active ', GETDATE()),
(NEWID(), 'ec6514b1-4600-45ad-9e67-b8424dd580db', (SELECT subscription_id FROM Subscriptions WHERE SubName = 'Student Plan'), GETDATE(), DATEADD(MONTH, 12, GETDATE()), 'Active ', GETDATE()),
(NEWID(), 'ec6514b1-4600-45ad-9e67-b8424dd580db', (SELECT subscription_id FROM Subscriptions WHERE SubName = 'Family Plan'), GETDATE(), DATEADD(MONTH, 6, GETDATE()), 'Active ', GETDATE()),
(NEWID(), 'ec6514b1-4600-45ad-9e67-b8424dd580db', (SELECT subscription_id FROM Subscriptions WHERE SubName = 'Pro Plan'), GETDATE(), DATEADD(MONTH, 1, GETDATE()), 'Active ', GETDATE()),
(NEWID(), 'ec6514b1-4600-45ad-9e67-b8424dd580db', (SELECT subscription_id FROM Subscriptions WHERE SubName = 'Advanced Plan'), GETDATE(), DATEADD(MONTH, 3, GETDATE()), 'Active ', GETDATE()),
(NEWID(), 'ec6514b1-4600-45ad-9e67-b8424dd580db', (SELECT subscription_id FROM Subscriptions WHERE SubName = 'Ultimate Plan'), GETDATE(), DATEADD(MONTH, 12, GETDATE()), 'Active ', GETDATE()),
(NEWID(), 'ec6514b1-4600-45ad-9e67-b8424dd580db', (SELECT subscription_id FROM Subscriptions WHERE SubName = 'VIP Plan'), GETDATE(), DATEADD(MONTH, 12, GETDATE()), 'Active ', GETDATE());
