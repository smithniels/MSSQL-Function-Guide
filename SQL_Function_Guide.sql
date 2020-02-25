/*
This is a guide for MSSQL Function!
Most of these definitions are from: http://www.sqlservertutorial.net
*/

-----------------------------------------------------------------------
--------------------------Just a Lil Table-----------------------------
-----------------------------------------------------------------------

IF OBJECT_ID('TEMPDB..#TEMP') IS NOT NULL DROP TABLE #TEMP -- This resets the table
CREATE TABLE #TEMP(
	val INT
)
INSERT INTO #TEMP(val)
VALUES (1),(2),(3),(4)

-----------------------------------------------------------------------
--------------------------Date Functions-------------------------------
-----------------------------------------------------------------------

--DATEADD() 
--		The DATEADD() function adds a number to a specified date part of 
--		an input date and returns the modified value.
--		DATEADD (date_part , value , input_date ) 
		SELECT DATEADD(YEAR, 1, GETDATE()) yearLater

--DATEDIFF()
--		Returns a difference in date part between two dates.
		SELECT DATEDIFF(DAY, '04-17-1992',GETDATE()) daysHere

--EOMONTH()
--		Get the last day of the month of a specified date
		SELECT EOMONTH(GETDATE()) lastDayOfMonth

--GETDATE()
--		Returns the current system date and time of the operating 
--		system on which the SQL Server is running.
		SELECT GETDATE() today

--MONTH()
--		Takes a date and returns the month number
		SELECT month(GETDATE()) whatMonthIsIt

--YEAR()
--		Takes a date and returns the year
		SELECT year(GETDATE()) whatYearAreWeIn

-----------------------------------------------------------------------
----------------------------String Functions---------------------------
-----------------------------------------------------------------------

-- LOWER()
--		Converts a string into lowercase. 
		SELECT LOWER('LET US MAKE GOOD') 'IF THERE IS NOTHING, BUT WHAT WE MAKE IN THIS WORLD, BROTHERS...' 

-- LTRIM() / RTRIM()
--		Removes spaces or specified characters FROM both ends of a string.
		select      ('                     Niels                              ') 'string'
		SELECT LTRIM('                     Niels                              ') 'Left' -- period is for making the change more apparent
		SELECT RTRIM('                     Niels                              ') 'Right'


-- SUBSTRING()
--		Extracts a substring with a specified length starting FROM a location in an input string.
SELECT 
    SUBSTRING('SQL Server SUBSTRING', 5, 6) result

-----------------------------------------------------------------------
--------------------------Aggregate Functions--------------------------
-----------------------------------------------------------------------

--COUNT() 
--		The COUNT() aggregate function returns the number of rows in a group, 
--		including rows with NULL values.
		SELECT count(e.encounterid) encounterCount FROM enc e where e.date LIKE '%2019%'

--MAX()
--		The MAX() aggregate function returns the highest value (maximum) in a set of non-NULL values.
		SELECT MAX(p.pid) maximumPID FROM patients p

--SUM()
--		
		SELECT sum(t.val) sumOneToFour FROM #TEMP t

---------------------------------------------------------------------------
--------------------------Server System Functions--------------------------
---------------------------------------------------------------------------

--CONVERT()
--		Converts a value of one type to another.
		SELECT CONVERT(date, GETDATE()) DATE
		SELECT CONVERT(datetime, GETDATE()) DATETIME
		SELECT CONVERT(varchar, GETDATE()) VARCHAR
		SELECT CONVERT(int, GETDATE()) INT

--ISNULL()
--		Replaces NULL with a specified value. Checks parameter 1 if null return parameter 2 else return 1
		SELECT ISNULL(NULL, 'apple') isNull1
		SELECT ISNULL('apple','banana') isNull2

--TRY_CONVERT
--		Converts a value of one type to another. It returns NULL if the conversion fails.
		SELECT TRY_CONVERT(int,'string') anAttemptWasMade

--ROW_NUMBER()
--		Assigns a sequential integer to each row within a partition of a result set. 
--		The row number starts with one for the first row in each partition. *I don't love this example -ns*
		SELECT row_number() over (
					PARTITION BY GETDATE()
					ORDER BY GETDATE()
				) 'row_num', GETDATE() 'whatIsToday'
		FROM #TEMP t