-- Worst selling item
WITH WorstSellingItemCTE AS (
    SELECT worst_selling_item_view.id, worst_selling_item_view.buy_profit as buy_profit
    FROM worst_selling_item_view
    LIMIT 1
)
SELECT shop_item.*, WorstSellingItemCTE.buy_profit
FROM shop_item 
    INNER JOIN WorstSellingItemCTE ON shop_item.id = WorstSellingItemCTE.id

-- Worst selling item for given company
WITH WorstSellingItemForCompanyCTE AS (
    SELECT worst_selling_item_view.id, worst_selling_item_view.buy_profit
    FROM worst_selling_item_view
    INNER JOIN shop_item ON worst_selling_item_view.id = shop_item.id
        INNER JOIN shop_company ON shop_item.company_id = shop_company.id
    WHERE shop_company.id = 2
    LIMIT 1
)
SELECT shop_item.*, WorstSellingItemForCompanyCTE.buy_profit
FROM shop_item
    INNER JOIN WorstSellingItemForCompanyCTE ON shop_item.id = WorstSellingItemForCompanyCTE.id
