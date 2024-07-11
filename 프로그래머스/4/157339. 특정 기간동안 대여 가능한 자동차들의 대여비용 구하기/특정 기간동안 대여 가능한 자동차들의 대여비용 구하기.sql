WITH Available_Cars AS (
    SELECT 
        c.CAR_ID,
        c.CAR_TYPE,
        c.DAILY_FEE,
        c.OPTIONS
    FROM 
        CAR_RENTAL_COMPANY_CAR c
    LEFT JOIN 
        CAR_RENTAL_COMPANY_RENTAL_HISTORY r
    ON 
        c.CAR_ID = r.CAR_ID
        AND (
            (r.START_DATE <= '2022-11-30' AND r.END_DATE >= '2022-11-01')
            OR r.HISTORY_ID IS NULL
        )
    WHERE 
        c.CAR_TYPE IN ('세단', 'SUV')
        AND r.HISTORY_ID IS NULL
),
Discounted_Cars AS (
    SELECT
        ac.CAR_ID,
        ac.CAR_TYPE,
        ac.DAILY_FEE,
        ac.DAILY_FEE * 30 AS BASE_FEE,
        dp.DISCOUNT_RATE,
        ROUND(ac.DAILY_FEE * 30 * (1 - dp.DISCOUNT_RATE / 100.0)) AS FINAL_FEE
    FROM 
        Available_Cars ac
    LEFT JOIN 
        CAR_RENTAL_COMPANY_DISCOUNT_PLAN dp
    ON 
        ac.CAR_TYPE = dp.CAR_TYPE
        AND dp.DURATION_TYPE = '30일 이상'
),
Filtered_Cars AS (
    SELECT
        CAR_ID,
        CAR_TYPE,
        FINAL_FEE AS FEE
    FROM
        Discounted_Cars
    WHERE
        FINAL_FEE >= 500000 AND FINAL_FEE < 2000000
)
SELECT
    CAR_ID,
    CAR_TYPE,
    FEE
FROM
    Filtered_Cars
ORDER BY
    FEE DESC,
    CAR_TYPE ASC,
    CAR_ID DESC;


