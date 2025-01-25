SELECT dept.department, 
SUM(SUM(p.reordered)) OVER (PARTITION BY dept.department) AS total_prior_reordered, 
SUM(SUM(c.reordered)) OVER (PARTITION BY dept.department) AS total_curr_reordered,
(SUM(SUM(p.reordered)) OVER (PARTITION BY dept.department) - SUM(SUM(c.reordered)) OVER (PARTITION BY dept.department)) AS difference
FROM ic_order_products_prior p
JOIN ic_order_products_curr c
ON p.product_id = c.product_id
JOIN ic_products prod
ON p.product_id = prod.product_id
JOIN ic_departments dept
ON prod.department_id = dept.department_id
JOIN ic_aisles a 
ON prod.aisle_id = a.aisle_id
GROUP BY dept.department
ORDER BY difference DESC;