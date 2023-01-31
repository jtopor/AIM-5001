-- AIM 5001 M2 Assignment Solutions

-- Question 1

-- Write a SQL query that produces a list of all Kiss albums in the Chinook database. 

SELECT *
FROM "Album"
INNER JOIN "Artist" ON "Artist"."ArtistId" = "Album"."ArtistId"
WHERE "Artist"."Name" = 'Kiss';

-- To get the count:

SELECT COUNT(*)
FROM "Album"
INNER JOIN "Artist" ON "Artist"."ArtistId" = "Album"."ArtistId"
WHERE "Artist"."Name" = 'Kiss';

--Question 2

-- Referencing previous query output, how many Kiss albums are contained within the database?  2

-- Question 3

-- Identify the name of the foreign key you used to answer the question about the number of Kiss albums contained in the database. ArtistId

--------------------------------------------------------------------------

-- Question 4

-- Write a SQL query that provides a list of all the Kiss songs on Kiss albums contained within the Chinook database. The output of the query MUST include artist name, album title, track name and composer.

SELECT "Artist"."Name",
"Album"."Title",
"Track"."Name",
"Composer"
FROM "Album"
INNER JOIN "Artist" ON "Artist"."ArtistId" = "Album"."ArtistId"
INNER JOIN "Track" ON "Track"."AlbumId" = "Album"."AlbumId"
WHERE "Artist"."Name" = 'Kiss';

-- Question 5

-- Referencing previous query output, which of the following Kiss singles is NOT available via the Chinook database? Shandi

-- Question 6

-- Identify the name of the foreign key you used to join the Track table with the Album table when generating a list of all Kiss songs and their associated artist name, album title, track name and composer. AlbumId

----------------------------------------------------------------------

-- Question 7

-- Write a SQL query that produces a list of the names of all customers who have purchased Kiss songs.

SELECT 
"Customer"."FirstName",
"Customer"."LastName"
FROM "Customer"
INNER JOIN "Invoice" ON "Customer"."CustomerId" = "Invoice"."CustomerId" 
INNER JOIN "InvoiceLine" ON "Invoice"."InvoiceId" = "InvoiceLine"."InvoiceId"
INNER JOIN "Track" ON "InvoiceLine"."TrackId" = "Track"."TrackId"
INNER JOIN "Album" ON "Album"."AlbumId" = "Track"."AlbumId"
INNER JOIN "Artist" ON "Artist"."ArtistId" = "Album"."ArtistId"
WHERE "Artist"."Name" = 'Kiss'
ORDER BY "Customer"."LastName", "Customer"."FirstName";

-- Alternative query that includes more detail on song purchases
SELECT "Artist"."Name",
"Album"."Title",
"Track"."Name",
"Customer"."FirstName",
"Customer"."LastName",
"InvoiceLine"."UnitPrice",
"InvoiceLine"."Quantity"
FROM "Customer"
INNER JOIN "Invoice" ON "Customer"."CustomerId" = "Invoice"."CustomerId"
INNER JOIN "InvoiceLine" ON "Invoice"."InvoiceId" = "InvoiceLine"."InvoiceId"
INNER JOIN "Track" ON "InvoiceLine"."TrackId" = "Track"."TrackId"
INNER JOIN "Album" ON "Album"."AlbumId" = "Track"."AlbumId"
INNER JOIN "Artist" ON "Artist"."ArtistId" = "Album"."ArtistId"
WHERE "Artist"."Name" = 'Kiss'
ORDER BY "Customer"."LastName", "Customer"."FirstName";


-- Alternative query

SELECT 
c."FirstName" || ' ' || c."LastName" AS "Name", 
SUM(il."Quantity") AS "Songs Purchased" 
FROM "Customer" AS c 
INNER JOIN "Invoice" AS i 
ON c."CustomerId" = i."CustomerId" 
INNER JOIN "InvoiceLine" AS il 
ON i."InvoiceId" = il."InvoiceId" 
INNER JOIN "Track" AS trk 
ON  il."TrackId" = trk."TrackId" 
INNER JOIN "Album" AS alb 
ON trk."AlbumId" = alb."AlbumId" 
INNER JOIN "Artist" AS art 
ON alb."ArtistId" = art."ArtistId" 
AND art."Name" = 'Kiss' 
GROUP BY c."CustomerId";

-- Question 8

-- What is the last name of the customer who purchased the most Kiss songs? Hämäläinen

-- Question 9  

-- How many foreign keys did you employ to answer the request for all Kiss song purchasers? For the solution shown above, there were 5: CustomerId, InvoiceId, TrackID, AlbumID, and ArtistID