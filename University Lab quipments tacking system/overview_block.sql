CREATE OR REPLACE TRIGGER trg_block_overdue_checkouts
BEFORE INSERT ON Checkouts
FOR EACH ROW
DECLARE
    v_overdue_count INT := 0;
BEGIN
    -- চেক করা হচ্ছে এই স্টুডেন্টের কোনো ওভারডিউ আইটেম আছে কিনা
    SELECT COUNT(*) INTO v_overdue_count
    FROM Checkouts
    WHERE StudentID = :NEW.StudentID   -- যে স্টুডেন্ট নতুন করে নিতে চাচ্ছে তার আইডি
      AND ReturnDate IS NULL           -- এখনও ফেরত দেয়নি
      AND SYSDATE > DueDate;           -- আজিকার তারিখ ডিউ ডেট পার হয়ে গেছে

    -- যদি একটিও ওভারডিউ আইটেম পাওয়া যায়, তবে এরর থ্রো করো
    IF v_overdue_count > 0 THEN
        RAISE_APPLICATION_ERROR(-20001, 'Access Denied: আপনার কাছে ওভারডিউ ল্যাব ইকুইপমেন্ট আছে!');
    END IF;
END;
/