-- ১. স্টুডেন্টদের ইনফরমেশন রাখার টেবিল
CREATE TABLE Students (
    StudentID INT PRIMARY KEY,
    Name VARCHAR2(100) NOT NULL,
    Email VARCHAR2(100) UNIQUE,
    Department VARCHAR2(10) NOT NULL
);

-- ২. ইকুইপমেন্টের ক্যাটাগরি (যেমন: মাইক্রোকন্ট্রোলার, অসিলোস্কোপ)
CREATE TABLE EquipmentCategories (
    CategoryID INT PRIMARY KEY,
    CategoryName VARCHAR2(50) NOT NULL,
    Description VARCHAR2(200)
);

-- ৩. ল্যাবের আসল ডিভাইস বা আইটেমগুলোর টেবিল
CREATE TABLE EquipmentItems (
    ItemID INT PRIMARY KEY,
    CategoryID INT NOT NULL,
    SerialNo VARCHAR2(50) UNIQUE NOT NULL,
    Status VARCHAR2(20) DEFAULT 'AVAILABLE' CHECK (Status IN ('AVAILABLE', 'CHECKED_OUT', 'MAINTENANCE')),
    CONSTRAINT fk_category FOREIGN KEY (CategoryID) REFERENCES EquipmentCategories(CategoryID)
);

-- ৪. কোন স্টুডেন্ট কোন ডিভাইস নিল এবং কবে ফেরত দিল, তার ট্র্যাকিং বা লগ টেবিল
CREATE TABLE Checkouts (
    CheckoutID INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    StudentID INT NOT NULL,
    ItemID INT NOT NULL,
    CheckoutDate DATE DEFAULT SYSDATE NOT NULL,
    DueDate DATE NOT NULL,
    ReturnDate DATE, -- ডিভাইস ফেরত না দেওয়া পর্যন্ত এটি NULL থাকবে
    CONSTRAINT fk_student FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
    CONSTRAINT fk_item FOREIGN KEY (ItemID) REFERENCES EquipmentItems(ItemID),
    CONSTRAINT chk_dates CHECK (DueDate >= CheckoutDate) -- ডিউ ডেট অবশ্যই নেওয়ার ডেটের পরে হবে
);