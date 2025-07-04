-- Create PRODCUT TABLE
CREATE TABLE PRODUCTS (
    PRODUCTID INT PRIMARY KEY IDENTITY(1,1),
    PRODUCTNAME NVARCHAR(100) NOT NULL,
    PRICE DECIMAL(10, 2) NOT NULL,
    STOCK INT NOT NULL
);

-- Test insert sample data
INSERT INTO PRODUCTS (PRODUCTNAME, PRICE, STOCK) VALUES
('iPhone 14', 999.99, 50),
('Samsung Galaxy S23', 899.99, 30),
('MacBook Pro', 1999.99, 15),
('Dell XPS 13', 1299.99, 25),
('AirPods Pro', 249.99, 100);