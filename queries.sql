use littlelemondb;

CREATE VIEW OrdersView AS
SELECT OrderID, Quantity, TotalCost AS Cost
FROM Orders
WHERE Quantity > 2;

SELECT
    C.CustomerID,
    C.CustomerName as FullName,
    O.OrderID,
    O.TotalCost AS Cost,
    M.ItemName AS MenuName,
    MI.CourseName,
    MI.StarterName
FROM CustomerDetails C
JOIN Orders O ON C.CustomerID = O.CustomerID
JOIN Menu M ON O.OrderID = M.ItemID
JOIN MenuItems MI ON M.ItemID = MI.MenuID
WHERE O.TotalCost > 150
ORDER BY O.TotalCost;

SELECT
    ItemName AS MenuName
FROM Menu
WHERE ItemID = ANY (
    SELECT MenuID
    FROM Orders
    GROUP BY MenuID
    HAVING COUNT(*) > 2
);