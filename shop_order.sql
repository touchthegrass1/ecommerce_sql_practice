WITH DataCTE AS (
    SELECT
        generate_series(1, 5000000) as id,
        true as ordered,
        false as shipped,
        timestamp '2019-01-10 20:00:00' + random() * (
            timestamp '2022-01-20 20:00:00' - timestamp '2019-01-10 10:00:00'
        ) as ordered_date,
        FLOOR(RANDOM()*(10000000 - 1) + 1)::int as user_id,
        uuid_generate_v4() as uuid
)
INSERT INTO shop_order
SELECT
    DataCTE.id,
    DataCTE.ordered,
    DataCTE.shipped,
    DataCTE.ordered_date,
    DataCTE.user_id,
    DataCTE.uuid
FROM DataCTE
WHERE NEXTVAL('query_progress') != 0;

