WITH MonthlySales AS (
    SELECT 
        p.product_id,
        p.product_name,
        SUM(o.quantity) AS total_quantity
    FROM 
        orders o
    JOIN 
        products p ON o.product_id = p.product_id
    WHERE 
        o.order_date >= DATE_TRUNC('month', CURRENT_DATE) - INTERVAL '1 month'
        AND o.order_date < DATE_TRUNC('month', CURRENT_DATE)
    GROUP BY 
        p.product_id, p.product_name
),
WITH TopSellingProducts AS (
    SELECT 
        product_id,
        product_name,
        total_quantity,
        RANK() OVER (ORDER BY total_quantity DESC) AS sales_rank
    FROM 
        MonthlySales
)
SELECT 
    product_id,
    product_name,
    total_quantity
FROM 
    TopSellingProducts
WHERE 
    sales_rank <= 5;