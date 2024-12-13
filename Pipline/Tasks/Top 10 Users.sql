WITH SalesData AS (
    SELECT 
        p.product_id,
        p.product_name,
        SUM(s.quantity) AS total_quantity
    FROM 
        sales s
    JOIN 
        products p ON s.product_id = p.product_id
    WHERE 
        s.sale_date >= DATE_TRUNC('month', CURRENT_DATE) - INTERVAL '1 month'
        AND s.sale_date < DATE_TRUNC('month', CURRENT_DATE)
    GROUP BY 
        p.product_id, p.product_name
),
TopSellingProducts AS (
    SELECT 
        product_id,
        product_name,
        total_quantity,
        ROW_NUMBER() OVER (ORDER BY total_quantity DESC) AS rn
    FROM 
        SalesData
)
SELECT 
    product_id,
    product_name,
    total_quantity
FROM 
    TopSellingProducts
WHERE 
    rn <= 5;