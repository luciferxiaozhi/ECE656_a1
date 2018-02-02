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
        Master.deathYear is NULL and
        Master.deathMonth is NULL and
        Master.deathDay is NULL
    )
    - 
    (
        select count(distinct HallOfFame.playerID) from Master inner join HallOfFame
        where HallOfFame.playerID = Master.playerID and
        Master.deathYear is not NULL and
        Master.deathMonth is not NULL and
        Master.deathDay is not NULL
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

/*Part2.2*/
DROP TABLE IF EXISTS Fielding;

CREATE TABLE Fielding (
    playerID VARCHAR(9),
    yearID INTEGER,
    stint INTEGER,
    teamID VARCHAR(3),
    lgID VARCHAR(2),
    POS VARCHAR(2),
    G INTEGER,
    GS INTEGER,
    InnOuts INTEGER,
    PO INTEGER,
    A INTEGER,
    E INTEGER,
    DP INTEGER,
    PB INTEGER,
    WP INTEGER,
    SB INTEGER,
    CS INTEGER,
    ZR DOUBLE,
    PRIMARY KEY ( playerID, yearID, stint, POS )
) CHARACTER SET 'UTF8';

LOAD DATA LOCAL INFILE '/home/luciferxiaozhi/workspace/ECE656/A1/Fielding.csv' INTO TABLE Fielding FIELDS TERMINATED BY ',';













