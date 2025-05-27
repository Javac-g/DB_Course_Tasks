-- 1. Enable extensions for UUID
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- 2. USERS Table
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    uuid UUID NOT NULL DEFAULT uuid_generate_v4(),
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    is_active BOOLEAN NOT NULL DEFAULT TRUE,
    password_hash TEXT NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- 3. PRODUCTS Table
CREATE TABLE products (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    price NUMERIC(10,2) NOT NULL CHECK (price >= 0)
);

-- 4. ORDERS Table
CREATE TABLE orders (
    id SERIAL PRIMARY KEY,
    user_id INT NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    total_amount NUMERIC(10,2) NOT NULL CHECK (total_amount >= 0),
    order_status VARCHAR(50) NOT NULL DEFAULT 'Pending',
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- 5. ORDER_ITEMS Table
CREATE TABLE order_items (
    id SERIAL PRIMARY KEY,
    order_id INT NOT NULL REFERENCES orders(id) ON DELETE CASCADE,
    product_id INT NOT NULL REFERENCES products(id),
    quantity INT NOT NULL CHECK (quantity > 0),
    unit_price NUMERIC(10,2) NOT NULL CHECK (unit_price >= 0)
);

-- 6. TAGS Table
CREATE TABLE tags (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) UNIQUE NOT NULL
);

-- 7. USER_TAGS Table (Many-to-Many)
CREATE TABLE user_tags (
    user_id INT NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    tag_id INT NOT NULL REFERENCES tags(id),
    PRIMARY KEY (user_id, tag_id)
);

-- 8. Trigger to auto-update updated_at
CREATE OR REPLACE FUNCTION update_updated_at()
RETURNS TRIGGER AS $$
BEGIN
   NEW.updated_at = NOW();
   RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_users_updated
BEFORE UPDATE ON users
FOR EACH ROW
EXECUTE FUNCTION update_updated_at();

CREATE TRIGGER trg_orders_updated
BEFORE UPDATE ON orders
FOR EACH ROW
EXECUTE FUNCTION update_updated_at();

-- View: Active Users With Total Orders
CREATE VIEW active_users_summary AS
SELECT
    u.id,
    u.full_name,
    u.email,
    COUNT(o.id) AS total_orders
FROM users u
LEFT JOIN orders o ON u.id = o.user_id
WHERE u.is_active = TRUE
GROUP BY u.id;

CREATE OR REPLACE FUNCTION create_order(
    p_user_id INT,
    p_items JSON
)
RETURNS VOID AS $$
DECLARE
    order_id INT;
    item JSON;
BEGIN
    -- Start transaction block manually (PostgreSQL handles this automatically, but for illustration):
    SAVEPOINT before_order;

    INSERT INTO orders (user_id, total_amount)
    VALUES (p_user_id, 0)
    RETURNING id INTO order_id;

    -- Loop through JSON array of items
    FOR item IN SELECT * FROM json_array_elements(p_items)
    LOOP
        INSERT INTO order_items (order_id, product_id, quantity, unit_price)
        VALUES (
            order_id,
            (item->>'product_id')::INT,
            (item->>'quantity')::INT,
            (item->>'unit_price')::NUMERIC
        );
    END LOOP;

    -- Recalculate total
    UPDATE orders
    SET total_amount = (
        SELECT SUM(quantity * unit_price) FROM order_items WHERE order_id = orders.id
    )
    WHERE id = order_id;

EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK TO SAVEPOINT before_order;
        RAISE;
END;
$$ LANGUAGE plpgsql;

-- Join orders with user and items
SELECT 
    o.id AS order_id,
    u.full_name,
    p.name AS product_name,
    oi.quantity,
    oi.unit_price
FROM orders o
JOIN users u ON o.user_id = u.id
JOIN order_items oi ON o.id = oi.order_id
JOIN products p ON oi.product_id = p.id;

-- 1. ROLES Table
CREATE TABLE roles (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL UNIQUE  -- e.g., ROLE_USER, ROLE_ADMIN
);

-- 2. USER_ROLES (Many-to-Many)
CREATE TABLE user_roles (
    user_id INT NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    role_id INT NOT NULL REFERENCES roles(id),
    PRIMARY KEY (user_id, role_id)
);

-- 3. Indexes for Users
CREATE INDEX idx_users_email ON users(email);
CREATE INDEX idx_users_uuid ON users(uuid);
CREATE INDEX idx_users_is_active ON users(is_active);

-- 4. Indexes for Orders
CREATE INDEX idx_orders_user_id ON orders(user_id);
CREATE INDEX idx_orders_status ON orders(order_status);

-- 5. Indexes for Order Items
CREATE INDEX idx_order_items_order_id ON order_items(order_id);
CREATE INDEX idx_order_items_product_id ON order_items(product_id);

-- 6. Indexes for Products
CREATE INDEX idx_products_price ON products(price);

-- 7. Indexes for Tags
CREATE INDEX idx_tags_name ON tags(name);

-- 8. Indexes for User_Tags
CREATE INDEX idx_user_tags_user_id ON user_tags(user_id);
CREATE INDEX idx_user_tags_tag_id ON user_tags(tag_id);

-- 9. Indexes for User_Roles
CREATE INDEX idx_user_roles_user_id ON user_roles(user_id);
CREATE INDEX idx_user_roles_role_id ON user_roles(role_id);

SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

-- SAMPLE DATA
INSERT INTO roles (name) VALUES ('ROLE_USER'), ('ROLE_ADMIN');
INSERT INTO users (full_name, email, password_hash) VALUES
('Max Admin', 'admin@example.com', '$2a$12$exampleexampleexampleexampleexampleexampleexampleexample');
INSERT INTO user_roles (user_id, role_id) VALUES
((SELECT id FROM users WHERE email = 'admin@example.com'), (SELECT id FROM roles WHERE name = 'ROLE_ADMIN'));

create table if not exists permissions (
    id bigserial primary key,
    name varchar(100) not null unique,
    description text
);

create table if not exists role_permissions (
    role_id bigint not null references roles(id) on delete cascade,
    permission_id bigint not null references permissions(id) on delete cascade,
    primary key (role_id, permission_id)
);
create table if not exists user_permissions (
    user_id bigint not null references users(id) on delete cascade,
    permission_id bigint not null references permissions(id) on delete cascade,
    primary key (user_id, permission_id)
);

-- Create PostgreSQL role used by Spring Boot app
CREATE ROLE app_user WITH LOGIN PASSWORD 'securepassword';
-- Grant read/write access to all tables
GRANT CONNECT ON DATABASE your_db TO app_user;
GRANT USAGE ON SCHEMA public TO app_user;
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA public TO app_user;
GRANT USAGE, SELECT ON ALL SEQUENCES IN SCHEMA public TO app_user;

