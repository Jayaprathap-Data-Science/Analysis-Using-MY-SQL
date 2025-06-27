DROP TABLE IF EXISTS sales_data;

CREATE TABLE sales_data (
    order_id INT,
    product_name VARCHAR(100),
    category VARCHAR(50),
    quantity INT,
    price_per_unit DECIMAL(10,2),
    revenue DECIMAL(10,2),
    order_date DATE,
    region VARCHAR(50),
    customer_id INT
);

LOAD DATA LOCAL INFILE 'C:/Users/sanja/Downloads/sales_data.csv'
INTO TABLE sales_data
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;
SELECT * FROM sales_data
WHERE region = 'South'
ORDER BY revenue DESC;
SELECT category, SUM(revenue) AS total_revenue, AVG(price_per_unit) AS avg_price
FROM sales_data
GROUP BY category;
-- INNER JOIN
SELECT s.order_id, c.customer_name, s.revenue
FROM sales_data s
INNER JOIN customers c ON s.customer_id = c.customer_id;

-- LEFT JOIN
SELECT s.order_id, c.customer_name
FROM sales_data s
LEFT JOIN customers c ON s.customer_id = c.customer_id;

-- RIGHT JOIN
SELECT s.order_id, c.customer_name
FROM sales_data s
RIGHT JOIN customers c ON s.customer_id = c.customer_id;
-- Orders with revenue greater than average revenue
SELECT * FROM sales_data
WHERE revenue > (
    SELECT AVG(revenue) FROM sales_data
);
CREATE VIEW region_summary AS
SELECT region, SUM(revenue) AS total_sales
FROM sales_data
GROUP BY region;
-- Index on customer_id for fast joins
CREATE INDEX idx_customer_id ON sales_data(customer_id);

-- Index on order_date for filtering
CREATE INDEX idx_order_date ON sales_data(order_date);
