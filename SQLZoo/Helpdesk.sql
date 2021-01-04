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
