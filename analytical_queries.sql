-- Worst selling item
WITH WorstSellingItemIdCTE AS (
    SELECT shop_orderitem.item_id AS id, SUM(shop_orderitem.quantity) AS buy_amount
    FROM shop_orderitem
    WHERE shop_orderitem.order_id IN (
        SELECT shop_order.id
        FROM shop_order
        WHERE ordered = true
    )
    GROUP BY 1
    ORDER BY 2
    LIMIT 1
)
SELECT *
FROM shop_item
WHERE shop_item.id = (
    SELECT id FROM WorstSellingItemIdCTE
)

-- Worst selling item for given company
WITH WorstSellingItemIdCTE AS (
    SELECT shop_orderitem.item_id AS id, SUM(shop_orderitem.quantity) AS buy_amount
    FROM shop_orderitem
    WHERE shop_orderitem.order_id IN (
        SELECT shop_order.id
        FROM shop_order
        WHERE ordered = true
    )
    WHERE company_id = 1
    GROUP BY 1
    ORDER BY 2
    LIMIT 1
)
SELECT *
FROM shop_item
WHERE shop_item.id = (
    SELECT id FROM WorstSellingItemIdCTE
    
)

-- Company total money from sales on ecommerce
SELECT
    SUM(shop_item.price * shop_orderitem.quantity)
FROM shop_item
    INNER JOIN shop_orderitem ON shop_item.id = shop_orderitem.item_id
WHERE shop_item.company_id = 1;