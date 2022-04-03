-- Sequence to track query progress, by running SELECT nextval('query_progress')
CREATE SEQUENCE query_progress START 1;

WITH DataCTE AS (
    SELECT
        generate_series(1, 50000000) as id,
        FLOOR(RANDOM()*(20 - 1) + 1)::int as quantity,
        FLOOR(RANDOM()*(4000000 - 1) + 1)::int as item_id,
        FLOOR(RANDOM()*(5000000 - 1) + 1)::int as order_id
)
INSERT INTO shop_orderitem
SELECT
    DataCTE.id,
    DataCTE.quantity,
    DataCTE.item_id,
    DataCTE.order_id
FROM DataCTE
WHERE NEXTVAL('query_progress') != 0;


DROP SEQUENCE query_progress;

-- Delete duplicates
DELETE FROM shop_orderitem WHERE (shop_orderitem.item_id, shop_orderitem.order_id) in (
    SELECT shop_orderitem.item_id, shop_orderitem.order_id
    FROM shop_orderitem
    WHERE NEXTVAL('query_progress') != 0
    GROUP BY 1, 2
    HAVING COUNT(*) > 1
);

CREATE UNIQUE INDEX order_item_item_id_order_id ON shop_orderitem (item_id, order_id);
