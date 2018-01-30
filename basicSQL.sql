/* Part1.1.(a) */
SELECT distinct deptName FROM Department;
/* Part1.1.(b) */
SELECT job, COUNT(empName) FROM Employee group by job;
/* Part1.1.(c) */
SELECT empName, salary from Employee where job = 'engineer';
/* Part1.1.(d) */
SELECT job, avg(salary) FROM Employee group by job;
/* Part1.1.(e) */

/* Part1.1.(f) unfi*/


