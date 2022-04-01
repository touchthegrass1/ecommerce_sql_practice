WITH DataCTE AS (
    SELECT
        generate_series(1, 1000) as id,
        substr(md5(random()::text), 10, 50) as slug,
        substr(md5(random()::text), 10, 50) as title,
        substr(md5(random()::text), 10, 100) as image,
        FLOOR(RANDOM()*(50 - 1) + 1)::int as category_id
)
INSERT INTO shop_subcategory
SELECT
    DataCTE.id,
    DataCTE.slug,
    DataCTE.title,
    DataCTE.image,
    DataCTE.category_id
FROM DataCTE;

