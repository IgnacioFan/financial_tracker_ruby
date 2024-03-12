# Financial Tracker Ruby

Design the architecture of the system considering the requirements.

## Requirements
1. As a user, I can crud a user(role: admin, owner, merchant, client)
2. As a user, I can crud a product
3. As a user, I can crud an order(status: pending, paid, canceled) 
4. As a user, I can read when a order gets paid
5. As a user, I can read the financial report by week and by month
    - Pie chart for products
    - line chart for selling rate by weekday

## Database Schema
1. users(id, name, email, role)
2. products(id, name, description, price)
3. orders(id, status, creator_id)
4. order_items(id, order_id, product_id)
5. order_transac(id, order_id, amount)

## Others
1. Google OAuth Sign-up and Log-in
2. Manually backup report to Google drive (opetional)
