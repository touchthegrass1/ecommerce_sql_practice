-- Worst selling item
SELECT *
FROM shop_item
WHERE shop_item.id = (
    SELECT id FROM worst_selling_item_view
    LIMIT 1
)

-- Worst selling item for given company
SELECT *
FROM shop_item
WHERE shop_item.id = (
    SELECT worst_selling_item_view.id FROM worst_selling_item_view
    INNER JOIN shop_item ON worst_selling_item_view.id = shop_item.id
        INNER JOIN shop_company ON shop_item.company_id = shop_company.id
    WHERE shop_company.id = 1
    LIMIT 1
)

-- Company total money from sales on ecommerce
SELECT
    SUM(shop_item.price * shop_orderitem.quantity)
FROM shop_item
    INNER JOIN shop_orderitem ON shop_item.id = shop_orderitem.item_id
WHERE shop_item.company_id = 1;