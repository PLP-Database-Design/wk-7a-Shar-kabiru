-- Question 1

USE sales;

-- Create the ProductDetail table
CREATE TABLE ProductDetail (
    OrderID INT,
    CustomerName VARCHAR(100),
    Product VARCHAR(50)
);

-- Insert data in 1NF format
INSERT INTO ProductDetail (OrderID, CustomerName, Product)
VALUES 
    (101, 'John Doe', 'Laptop'),
    (101, 'John Doe', 'Mouse'),
    (102, 'Jane Smith', 'Tablet'),
    (102, 'Jane Smith', 'Keyboard'),
    (102, 'Jane Smith', 'Mouse'),
    (103, 'Emily Clark', 'Phone');
    
SELECT * FROM ProductDetail;

-- Question 2

-- Create the OrderDetails table (already in 1NF but not in 2NF)
CREATE TABLE OrderDetails (
    OrderID INT,
    CustomerName VARCHAR(100),
    Product VARCHAR(50),
    Quantity INT,
    PRIMARY KEY (OrderID, Product)  -- Composite primary key
);

-- Insert the data
INSERT INTO OrderDetails (OrderID, CustomerName, Product, Quantity)
VALUES 
    (101, 'John Doe', 'Laptop', 2),
    (101, 'John Doe', 'Mouse', 1),
    (102, 'Jane Smith', 'Tablet', 3),
    (102, 'Jane Smith', 'Keyboard', 1),
    (102, 'Jane Smith', 'Mouse', 2),
    (103, 'Emily Clark', 'Phone', 1);
    
SELECT * From OrderDetails;
    
-- Create the Orders table (removes CustomerName partial dependency)
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(100)
);

-- Create the OrderProducts table (preserves full dependencies)
CREATE TABLE OrderProducts (
    OrderID INT,
    Product VARCHAR(50),
    Quantity INT,
    PRIMARY KEY (OrderID, Product),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

--  insert into Orders (order information)
INSERT INTO Orders (OrderID, CustomerName)
SELECT DISTINCT OrderID, CustomerName
FROM OrderDetails;

SELECT * From Orders;

--  insert into Order_Products (all product items)
INSERT INTO OrderProducts (OrderID, Product, Quantity)
SELECT OrderID, Product, Quantity
FROM OrderDetails;

SELECT * From OrderProducts;
