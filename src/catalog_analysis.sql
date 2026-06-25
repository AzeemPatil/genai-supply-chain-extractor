/* =============================================================================
Query: Supply Chain Catalog Analytics
Description: Analyzes structured catalog data extracted via LLM.
             Calculates total inventory valuation, averages unit prices, 
             and ranks vendors by total supplied value using CTEs and Windows.
=============================================================================
*/

WITH ExtractedCatalog AS (
    -- Simulated table structure created by the LLM Python script
    SELECT 
        email_id,
        vendor_name,
        product_name,
        category,
        CAST(quantity AS INT) AS quantity,
        CAST(unit_price_inr AS FLOAT) AS unit_price_inr,
        origin_location
    FROM 
        structured_catalog
    WHERE 
        quantity IS NOT NULL 
        AND unit_price_inr IS NOT NULL
),

InventoryValuation AS (
    -- Calculate total value per line item
    SELECT 
        vendor_name,
        product_name,
        category,
        quantity,
        unit_price_inr,
        (quantity * unit_price_inr) AS total_line_value_inr,
        origin_location
    FROM 
        ExtractedCatalog
),

CategoryMetrics AS (
    -- Window function to calculate the percentage of total catalog value per item
    SELECT 
        vendor_name,
        product_name,
        category,
        total_line_value_inr,
        SUM(total_line_value_inr) OVER(PARTITION BY category) AS category_total_value,
        ROUND((total_line_value_inr / SUM(total_line_value_inr) OVER()) * 100, 2) AS pct_of_global_inventory
    FROM 
        InventoryValuation
)

-- Final Report: Aggregated by Vendor and Category
SELECT 
    vendor_name,
    category,
    COUNT(product_name) AS total_distinct_products,
    SUM(total_line_value_inr) AS total_vendor_value_inr,
    MAX(pct_of_global_inventory) AS max_inventory_share_pct
FROM 
    CategoryMetrics
GROUP BY 
    vendor_name, 
    category
ORDER BY 
    total_vendor_value_inr DESC;
