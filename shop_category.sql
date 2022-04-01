INSERT INTO shop_category
SELECT 
    generate_series(1, 50) as id,
    substr(md5(random()::text), 10, 50) as slug,
    substr(md5(random()::text), 10, 50) as title,
    substr(md5(random()::text), 10, 50) as image
