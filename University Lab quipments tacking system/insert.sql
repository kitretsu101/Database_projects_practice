-- স্টুডেন্ট ইনসার্ট
INSERT INTO Students VALUES (101, 'Plabon Barua', 'plabon@univ.edu', 'CSE');
INSERT INTO Students VALUES (102, 'Shuvro Sarker', 'shuvro@univ.edu', 'CSE');

-- ক্যাটাগরি ইনসার্ট
INSERT INTO EquipmentCategories VALUES (1, 'Microcontroller', 'Arduino, Raspberry Pi');
INSERT INTO EquipmentCategories VALUES (2, 'Measurement', 'Digital Oscilloscopes');

-- ফিজিক্যাল আইটেম ইনসার্ট
INSERT INTO EquipmentItems VALUES (501, 1, 'ARD-UNO-092', 'CHECKED_OUT');
INSERT INTO EquipmentItems VALUES (502, 1, 'RPI-4B-044', 'AVAILABLE');

-- ট্রানজেকশন লগ ইনসার্ট 
-- প্লাবন ১০ দিন আগে একটা ডিভাইস নিয়েছে, যেটা ৫ দিন আগে ফেরত দেওয়ার কথা ছিল কিন্তু দেয়নি (ReturnDate = NULL)
INSERT INTO Checkouts (StudentID, ItemID, CheckoutDate, DueDate, ReturnDate) 
VALUES (101, 501, SYSDATE - 10, SYSDATE - 5, NULL);

COMMIT;