CREATE MATERIALIZED VIEW worst_selling_item_view AS 
SELECT shop_orderitem.item_id AS id, SUM(shop_orderitem.quantity * shop_item.price) AS buy_profit
FROM shop_orderitem
    INNER JOIN shop_item ON shop_orderitem.item_id = shop_item.id
WHERE shop_orderitem.order_id IN (
    SELECT shop_order.id
    FROM shop_order
    WHERE ordered = true
)
GROUP BY 1
ORDER BY 2
LIMIT 5000;