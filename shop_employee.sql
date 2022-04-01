WITH UserCTE AS (
    SELECT id AS id
    FROM accounts_user
    ORDER BY random()
    LIMIT 150000
), UserEnumeratedCTE AS (
    SELECT UserCTE.id AS id, row_number() OVER(order by (select null)) as row_num
    FROM UserCTE
), DataCTE AS (
    SELECT
        generate_series(1, 150000) as id,
        substr(md5(random()::text), 10, 25) as phone_number,
        substr(md5(random()::text), 10, 50) as photo,
        FLOOR(RANDOM()*(150 - 1) + 1)::int as company_id
)
INSERT INTO shop_employee
SELECT
    DataCTE.id,
    DataCTE.phone_number,
    DataCTE.photo,
    DataCTE.company_id,
    UserEnumeratedCTE.id
FROM DataCTE
INNER JOIN UserEnumeratedCTE ON DataCTE.id = UserEnumeratedCTE.row_num;
