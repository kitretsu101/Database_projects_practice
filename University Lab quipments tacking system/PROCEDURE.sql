CREATE OR REPLACE PROCEDURE CalculateCategoryUsageHours IS
    -- ১. explicit cursor ডিক্লেয়ার করা হলো যা ক্যাটাগরিগুলোর লিস্ট আনবে
    CURSOR c_categories IS 
        SELECT CategoryID, CategoryName FROM EquipmentCategories;
        
    v_total_hours NUMBER;
BEGIN
    -- ২. Cursor FOR Loop চালানো হচ্ছে (এটি অটোমেটিক কারসর ওপেন, ফেচ এবং ক্লোজ করে)
    FOR r_cat IN c_categories LOOP
        
        -- ডেট মাইনাস করে ২৪ দিয়ে গুণ দিলে মোট ঘণ্টা বের হয়
        SELECT NVL(SUM(
            CASE 
                WHEN c.ReturnDate IS NOT NULL THEN (c.ReturnDate - c.CheckoutDate) * 24
                ELSE (SYSDATE - c.CheckoutDate) * 24 -- এখনও ফেরত না দিলে আজ পর্যন্ত সময় হিসাব হবে
            END
        ), 0) INTO v_total_hours
        FROM Checkouts c
        INNER JOIN EquipmentItems i ON c.ItemID = i.ItemID
        WHERE i.CategoryID = r_cat.CategoryID;
        
        -- কনসোলে প্রিন্ট করা
        DBMS_OUTPUT.PUT_LINE('Category: ' || r_cat.CategoryName || ' | Total Usage: ' || ROUND(v_total_hours, 2) || ' Hours.');
    END LOOP;
END;
/