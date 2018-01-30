# ECE 656 - Assignment 1
## Part1
### Part1.1
/* Part1.1.(a) tick*/
SELECT distinct deptName FROM Department where location = 'waterloo';
/* Part1.1.(b) tick*/
SELECT job, COUNT(empName) FROM Employee group by job;
/* Part1.1.(c) tick*/
SELECT empName, salary from Employee where job = 'engineer';
/* Part1.1.(d) tick*/
SELECT job, avg(salary) FROM Employee group by job;
/* Part1.1.(e) tick*/
select deptID from (
select deptID, count(empName) from Employee
where job = 'engineer'
group by deptID
order by count(job) desc)as table1 limit 1;
/* Part1.1.(f) tick*/
select deptID from 
(
    select T1.deptID, T1.EngineerEmp/ T2.allEmp as percentage from
    (
        (select deptID, count(job) as EngineerEmp from Employee where job = 'engineer' group by deptID) as T1,
        (select deptID, count(job) as allEmp from Employee group by deptID) as T2
    )
    where T1.deptID = T2.deptID
    order by percentage desc
) as table1 limit 1;
#____________________________________________________________________________
### Part1.2
/* Part1.2.(a) */
select empName, empID from Employee
where empID not in (select empID from Assigned);

