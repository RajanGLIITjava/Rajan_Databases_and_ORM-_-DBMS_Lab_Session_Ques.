CREATE DEFINER=`root`@`localhost` PROCEDURE `ratingprocedure`()
BEGIN
select `order`.pricing_id, rating.ORD_ID, rating.RAT_RATSTARS from `order`
inner join
rating on rating.`ord_id`=`order`.ord_id;
SELECT 
    report.supp_id,
    report.supp_name,
    report.Average,
    CASE
        WHEN report.Average = 5 THEN 'Excellent Service'
        WHEN report.Average = 4 THEN 'Good Service'
        WHEN report.Average = 2 THEN 'Average Service'
        ELSE 'Poor Service'
    END AS Type_of_Service
FROM
    (SELECT 
        final.supp_id, supplier.supp_name, final.Average
    FROM
        (SELECT 
        test2.supp_id,
            SUM(test2.rat_ratstars) / COUNT(test2.rat_ratstars) AS AVerage
    FROM
        (SELECT 
        supplier_pricing.supp_id, test.ORD_ID, test.RAT_RATSTARS
    FROM
        supplier_pricing
    INNER JOIN (SELECT 
        `order`.pricing_id, rating.ORD_ID, rating.RAT_RATSTARS
    FROM
        `order`
    INNER JOIN rating ON rating.`ord_id` = `order`.ord_id) AS test ON test.pricing_id = supplier_pricing.pricing_id) AS test2
    GROUP BY supplier_pricing.supp_id) AS final
    INNER JOIN supplier
    WHERE
        final.supp_id = supplier.supp_id) AS report;
END