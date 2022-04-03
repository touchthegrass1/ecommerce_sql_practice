SELECT "shop_order"."id", "shop_order"."ordered", "shop_order"."shipped", "shop_order"."ordered_date", "shop_order"."uuid", "shop_order"."user_id"
FROM "shop_order"
WHERE (NOT "shop_order"."ordered" AND NOT "shop_order"."shipped" AND "shop_order"."user_id" = 1);

SELECT "shop_orderstep"."id", "shop_orderstep"."step_id", "shop_orderstep"."order_id", "shop_orderstep"."date_step_begin", "shop_orderstep"."date_step_end"
FROM "shop_orderstep"
WHERE "shop_orderstep"."order_id" = 3;

SELECT "shop_order"."id", "shop_order"."ordered", "shop_order"."shipped", "shop_order"."ordered_date", "shop_order"."uuid", "shop_order"."user_id"
FROM "shop_order"
WHERE ("shop_order"."shipped" AND "shop_order"."user_id" = 4);

SELECT "shop_order"."id", "shop_order"."ordered", "shop_order"."shipped", "shop_order"."ordered_date", "shop_order"."uuid", "shop_order"."user_id"
FROM "shop_order" WHERE "shop_order"."uuid" = '20e24dc4-a8a5-49b1-90cc-da6f7b28c617';

WITH OrderCTE AS (
    UPDATE shop_order
    SET ordered_date = %s,
        ordered = TRUE
    WHERE shop_order.uuid = %s
    RETURNING id AS order_id
), StepCTE AS (
    SELECT shop_step.id AS step_id, shop_step.name_step
    FROM shop_step
)
UPDATE shop_orderstep
SET date_step_end = (
    CASE
        WHEN shop_orderstep.step_id = (
            SELECT step_id FROM StepCTE WHERE name_step = 'оплата'
        )
        THEN %s
        ELSE NULL
    END
), date_step_begin = (
    CASE
        WHEN shop_orderstep.step_id = (
            SELECT step_id FROM StepCTE WHERE name_step = 'упаковка'
        )
        THEN %s
        ELSE NULL
    END
)
WHERE shop_orderstep.order_id = (
    SELECT order_id FROM OrderCTE
);

SELECT "shop_item"."id", "shop_item"."title", "shop_item"."description", "shop_item"."price", "shop_item"."image_href", "shop_item"."slug", "shop_item"."subcategory_id", "shop_item"."company_id"
FROM "shop_item"
    INNER JOIN "shop_subcategory" ON "shop_item"."subcategory_id" = "shop_subcategory"."id"
WHERE "shop_subcategory"."slug" = '0eee36585928ed4c23f0e87'
ORDER BY "shop_item"."price" ASC, "shop_item"."title" ASC;

SELECT "shop_orderitem"."id", "shop_orderitem"."quantity", "shop_orderitem"."item_id", "shop_orderitem"."order_id"
FROM "shop_orderitem"
    INNER JOIN "shop_item" ON "shop_orderitem"."item_id" = "shop_item"."id"
WHERE "shop_orderitem"."order_id" = 3
ORDER BY "shop_item"."title" ASC;

SELECT "shop_order"."id", "shop_order"."ordered", "shop_order"."shipped", "shop_order"."ordered_date", "shop_order"."uuid", "shop_order"."user_id"
FROM "shop_order"
WHERE (NOT "shop_order"."ordered" AND NOT "shop_order"."shipped" AND "shop_order"."user_id" = 4);

WITH OrderCTE AS (
    SELECT shop_order.id
    FROM shop_order
    WHERE shop_order.ordered = FALSE AND shop_order.shipped = FALSE AND shop_order.user_id = 1
), OrderStepJoinedCTE AS (
    SELECT OrderCTE.id AS order_id, shop_step.id AS step_id
    FROM OrderCTE, shop_step
)
INSERT INTO shop_orderstep(order_id, step_id)
SELECT OrderStepJoinedCTE.order_id, OrderStepJoinedCTE.step_id
FROM OrderStepJoinedCTE
RETURNING order_id;

WITH ItemCTE AS (
    SELECT shop_item.id AS item_id
    FROM shop_item
    WHERE slug = %s
)
INSERT INTO shop_orderitem(quantity, item_id, order_id)
SELECT 1, ItemCTE.item_id, %s
FROM ItemCTE
ON CONFLICT(item_id, order_id) DO NOTHING;

WITH ItemCTE AS (
    SELECT shop_item.id AS item_id
    FROM shop_item
    WHERE slug = %s
), OrderCTE AS (
    SELECT shop_order.id AS order_id
    FROM shop_order
    WHERE shop_order.ordered = FALSE AND shop_order.shipped = FALSE AND shop_order.user_id = %s
)
DELETE FROM shop_orderitem
WHERE item_id = (
    SELECT item_id FROM ItemCTE
) AND order_id = (
    SELECT order_id FROM OrderCTE
);

WITH ItemCTE AS (
    SELECT shop_item.id AS item_id
    FROM shop_item
    WHERE slug = %s
), OrderCTE AS (
    SELECT shop_order.id AS order_id
    FROM shop_order
    WHERE shop_order.ordered = FALSE AND shop_order.shipped = FALSE AND shop_order.user_id = %s
)
UPDATE shop_orderitem
SET quantity = %s
WHERE item_id = (
    SELECT item_id FROM ItemCTE
) AND order_id = (
    SELECT order_id FROM OrderCTE
);

