INSERT INTO accounts_user
SELECT 
    generate_series(3, 10000000) as id,
    substr(md5(random()::text), 10, 50) as password,
    timestamp '2014-01-10 20:00:00' + random() * (
        timestamp '2022-01-20 20:00:00' - timestamp '2014-01-10 10:00:00'
    ) as last_login,
    false as is_superuser,
    substr(md5(random()::text), 5, 25) as first_name,
    substr(md5(random()::text), 5, 25) as last_name,
    false as is_staff,
    true as is_active,
    timestamp '2014-01-10 20:00:00' as date_joined,
    substr(md5(random()::text), 5, 10) as role,
    substr(md5(random()::text), 5, 25) as email,
    FLOOR(RANDOM()*(1000 - 1) + 1)::int as city_id;
