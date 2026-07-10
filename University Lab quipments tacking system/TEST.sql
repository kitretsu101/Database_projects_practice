SET SERVEROUTPUT ON;

BEGIN
    -- টেস্ট ১: প্রসিডিউর রান করে দেখা
    CalculateCategoryUsageHours;
    
    -- টেস্ট ২: ওভারডিউ থাকা প্লাবনকে (ID: 101) জোর করে আরেকটি ডিভাইস (502) দেওয়ার চেষ্টা
    DBMS_OUTPUT.PUT_LINE('প্লাবনের জন্য নতুন ডিভাইস নেওয়ার চেষ্টা করা হচ্ছে...');
    INSERT INTO Checkouts (StudentID, ItemID, CheckoutDate, DueDate, ReturnDate)
    VALUES (101, 502, SYSDATE, SYSDATE + 7, NULL);
EXCEPTION
    WHEN OTHERS THEN
        -- ট্রিগার এটিকে ব্লক করবে এবং এখানে এসে এরর মেসেজটি প্রিন্ট হবে
        DBMS_OUTPUT.PUT_LINE('ট্রিগার সফলভাবে ব্লক করেছে! কারণ: ' || SQLERRM);
END;
/