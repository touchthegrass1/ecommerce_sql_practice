WITH DataCTE AS (
    SELECT
        generate_series(1, 4000000) as id,
        substr(md5(random()::text), 10, 255) as title,
        substr(md5(random()::text), 100, 5000) as description,
        FLOOR(RANDOM()*(900000 - 300) + 300)::int as price,
        substr(md5(random()::text), 10, 50) as slug,
        FLOOR(RANDOM()*(150 - 1) + 1)::int as company_id,
        FLOOR(RANDOM()*(1000 - 1) + 1)::int as subcategory_id,
        substr(md5(random()::text), 10, 500) as image_href
)
INSERT INTO shop_item
SELECT
    DataCTE.id,
    DataCTE.title,
    DataCTE.description,
    DataCTE.price,
    DataCTE.slug,
    DataCTE.company_id,
    DataCTE.subcategory_id,
    DataCTE.image_href
FROM DataCTE;
