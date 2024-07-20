WITH ReviewCount AS (
    SELECT
        MEMBER_ID,
        COUNT(*) AS REVIEW_COUNT
    FROM
        REST_REVIEW
    GROUP BY
        MEMBER_ID
),
MaxReviewer AS (
    SELECT
        MEMBER_ID
    FROM
        ReviewCount
    WHERE
        REVIEW_COUNT = (SELECT MAX(REVIEW_COUNT) FROM ReviewCount)
)
SELECT
    mp.MEMBER_NAME,
    rr.REVIEW_TEXT,
    DATE_FORMAT(rr.REVIEW_DATE, '%Y-%m-%d') AS REVIEW_DATE
FROM
    REST_REVIEW rr
JOIN
    MEMBER_PROFILE mp
ON
    rr.MEMBER_ID = mp.MEMBER_ID
JOIN
    MaxReviewer mr
ON
    rr.MEMBER_ID = mr.MEMBER_ID
ORDER BY
    rr.REVIEW_DATE ASC,
    rr.REVIEW_TEXT ASC;

