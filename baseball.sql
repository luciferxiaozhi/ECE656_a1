# A1 Part2
## Part2.1
/*Part2.1.(a)*/
select count(playerID) from Master 
where birthYear is NULL or birthMonth is NULL or birthDay is NULL;
/*Part2.1.(b)*/
select 
    (
        select count(distinct HallOfFame.playerID) from Master inner join HallOfFame
        where HallOfFame.playerID = Master.playerID and
        Master.deathYear is not NULL and
        Master.deathMonth is not NULL and
        Master.deathDay is not NULL
    ) 
    - 
    (
        select count(distinct HallOfFame.playerID) from Master inner join HallOfFame
        where HallOfFame.playerID = Master.playerID and
        Master.deathYear is NULL and
        Master.deathMonth is NULL and
        Master.deathDay is NULL
    ) as res;
/*Part2.1.(c)*/
select Salaries.salary, nameFirst, nameLast, nameGiven from Master inner join Salaries
on Master.playerID = Salaries.playerID
order by Salaries.salary desc
limit 1
/*Part2.1.(d)*/
select sum(b.HR)/count(b.playerID)
from 
(
    select sum(HR) as HR, playerID from Batting group by playerID
) as b
/*Part2.1.(e)*/
select sum(b.HR)/count(b.playerID)
from 
(
    select sum(HR) as HR, playerID from Batting group by playerID having HR >= 1
) as b
/*Part2.1.(f)*/
select count(avgBat.playerID) from
(
    select b.playerID, avg(b.HR) as HR
    from Batting as b group by b.playerID
) as avgBat
where avgBat.HR > 
(
    select sum(tmpb.HR)/count(tmpb.playerID)
    from 
    (
      select sum(tb.HR) as HR, tb.playerID from Batting as tb group by tb.playerID
    ) as tmpb
)and avgBat.playerID in
(
    select avgPit.playerID from 
    (
        select p.playerID, avg(p.SHO) as SHO from Pitching as p
        group by p.playerID
    ) as avgPit
    where avgPit.SHO > 
    (
        select sum(tmpp.SHO)/count(tmpp.playerID)
        from 
        (
          select sum(tp.SHO) as SHO, tp.playerID from Pitching as tp group by tp.playerID
        ) as tmpp
    )
);


select count(gb.playerID) as good
from (select avg(b.HR) as HR, b.playerID
    from Batting as b group by b.playerID) as gb
where gb.HR > (select sum(tempb.HR)/count(tempb.playerID)
    from (select sum(t.HR) as HR, t.playerID
        from Batting as t
        group by t.playerID)
    as tempb)
and gb.playerID in (select gp.playerID
    from (select avg(p.SHO) as SHO, p.playerID
        from Pitching as p
        group by p.playerID) as gp
    where gp.SHO > (select sum(tempp.SHO)/count(tempp.playerID)
        from (select sum(s.SHO) as SHO, s.playerID
            from Pitching as s
            group by s.playerID) as tempp));
















