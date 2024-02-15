CREATE TABLE Node (
	ID SERIAL, 
	PARENT_ID int, 
	TYPE char(20), 
	LABEL char(20), 
	VALUE char(50));

INSERT INTO Node (PARENT_ID, TYPE, LABEL, VALUE)
	VALUES 
		(NULL, 'element', 'FamilyTree', NULL),
		(1, 'attribute', 'userID', '123'),
		(1, 'element', 'Person', NULL),
		(2, 'attribute', 'id', 'p1'),
		(2, 'element', 'FirstName', 'Kalindi'),
		(2, 'element', 'LastName', 'Parekh'),
		(2, 'element', 'YearOfBirth', '1997'),
		(2, 'element', 'Mother', 'Kavita'),
		(2, 'element', 'Father', 'Ram'),
        (1, 'element', 'Person', NULL),
		(8, 'attribute', 'id', 'p2'),		
		(8, 'element', 'FirstName', 'Jane'),
		(8, 'element', 'LastName', 'Smith'),
		(8, 'element', 'YearOfBirth', '1982'),
		(8, 'element', 'Mother', 'Mary'),
		(8, 'element', 'Father', 'Bob');

SELECT 
    FirstName.VALUE as "FirstName", 
    LastName.VALUE as "LastName", 
    YearOfBirth.VALUE as "YearOfBirth" 
FROM 
    Node FirstName
    JOIN Node LastName ON FirstName.PARENT_ID = LastName.PARENT_ID
    JOIN Node YearOfBirth ON FirstName.PARENT_ID = YearOfBirth.PARENT_ID
WHERE 
    FirstName.LABEL = 'FirstName' 
    AND LastName.LABEL = 'LastName' 
    AND YearOfBirth.LABEL = 'YearOfBirth' 
    AND CAST(YearOfBirth.VALUE AS INTEGER) BETWEEN 1980 AND 2000;
