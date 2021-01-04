-- 1. There are three issues that include the words "index" and "Oracle". Find the call_date for each of them
SELECT Call_date, Call_ref FROM Issue 
WHERE Detail LIKE '%index%' AND detail LIKE '%Oracle%';

-- 2. Samantha Hall made three calls on 2017-08-14. Show the date and time for each
SELECT Call_date, first_name, last_name FROM Issue JOIN Caller ON(Issue.Caller_id = Caller.Caller_id)
WHERE first_name = 'Samantha' AND last_name = 'Hall' AND Call_date LIKE '%2017-08-14%';

-- 3. There are 500 calls in the system (roughly). Write a query that shows the number that have each status.
SELECT status, COUNT(status) as Volume FROM Issue
GROUP BY status;

-- 4. Calls are not normally assigned to a manager but it does happen. How many calls have been assigned to staff who are at Manager Level?
SELECT COUNT(*) as mlcc FROM Issue JOIN Staff ON(Issue.Assigned_to = Staff.Staff_code)
JOIN Level ON(Staff.Level_code = Level.Level_code)
WHERE Manager = 'Y';

-- 5. Show the manager for each shift. Your output should include the shift date and type; also the first and last name of the manager.
SELECT Shift_date, Shift_type, first_name, last_name FROM Shift JOIN Staff ON(Shift.Manager = Staff.Staff_code)
ORDER BY Shift_date;

-- 6. List the Company name and the number of calls for those companies with more than 18 calls.
SELECT Company_name, COUNT(Call_ref) as cc FROM Customer JOIN Caller ON(Customer.Company_ref = Caller.Company_ref) 
JOIN Issue ON(Caller.Caller_id = Issue.Caller_id) 
GROUP BY Company_name 
HAVING cc > 18;

-- 7. Find the callers who have never made a call. Show first name and last name
SELECT first_name, last_name FROM Caller LEFT JOIN Issue ON(Caller.Caller_id = Issue.Caller_id)
WHERE Issue.Caller_id IS NULL;

-- 8. For each customer show: Company name, contact name, number of calls where the number of calls is fewer than 5
--First make a query for the companies with a number of calls < 5. Then Join the table with the Caller table to only display the names matching the 
SELECT a.Company_name, b.first_name, b.last_name FROM(
  SELECT Customer.Company_name, Customer.Contact_id, COUNT(*) AS nc FROM Customer JOIN Caller ON(Customer.Company_ref = Caller.Company_ref) 
  JOIN Issue ON(Caller.Caller_id = Issue.Caller_id) 
  GROUP BY Customer.Company_name, Customer.Contact_id 
  HAVING COUNT(*) < 5) AS a 
  JOIN (SELECT * FROM Caller) AS b 
  ON (a.Contact_id = b.Caller_id);
