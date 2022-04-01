INSERT INTO shop_company
SELECT 
    generate_series(1, 150) as id,
    substr(md5(random()::text), 10, 400) as name,
    substr(md5(random()::text), 10, 400) as location,
    substr(md5(random()::text), 10, 28) as phone_number,
    substr(md5(random()::text), 10, 80) as logo
