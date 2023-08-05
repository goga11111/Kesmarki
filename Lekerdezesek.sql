-- 3.1
select b.LastName, b.FirstName, a.Type, a. Brand, a.PlateNr
from dbo.Vehicle a
	join dbo.Person b on a.OwnerPersonID=b.ID


-- 3.2
select b.LastName, b.FirstName, c.Type, c. Brand, c.PlateNr
from dbo.HasLicense a
	join dbo.Person b on a.PersonID=b.ID
	join dbo.Vehicle c on a.VehicleID=c.ID


-- 3.3 !!!!!!!!!!!!!!!!!!!
select a.Type, a.Brand, a.PlateNr, b.LastName, b.FirstName
from dbo.Vehicle a
	join dbo.HasLicense b on a.ID=b.VehicleID
	join dbo.Person b on b.ID=a.PersonID
where not exists (select top 1 1 from dbo.HasLicense where PersonID=b.ID and VehicleID=a.ID)


-- 3.4
select a.RefuelingDate, a.Amount, b.Type, b.Brand, b.PlateNr, c.LastName, c.FirstName
from Refueling a
	join dbo.Vehicle b on a.VehicleID=b.ID
	join dbo.Person c on a.PersonID=c.ID
where c.ID!=b.OwnerPersonID


-- 3.5
select a.RefuelingDate, a.Amount, b.Type, b.Brand, b.PlateNr, c.LastName, c.FirstName
from Refueling a
	join dbo.Vehicle b on a.VehicleID=b.ID
	join dbo.Person c on a.PersonID=c.ID
where not exists (select top 1 1 from dbo.HasLicense where PersonID=c.ID and VehicleID=b.ID)


-- 3.6
select b.Type, b.Brand, b.PlateNr, Year(a.RefuelingDate) Ev, sum(a.Amount) Amount
from Refueling a
	join dbo.Vehicle b on a.VehicleID=b.ID
group by b.Type, b.Brand, b.PlateNr, Year(a.RefuelingDate)


-- 3.7
select top 1 b.Type, b.Brand, b.PlateNr, sum(a.Amount) Amount
from Refueling a
	join dbo.Vehicle b on a.VehicleID=b.ID
where Year(a.RefuelingDate)='2016'
group by b.Type, b.Brand, b.PlateNr
order by sum(a.Amount)


-- 3.8
select c.LastName, c.FirstName, b.Type, b.Brand, b.PlateNr
from Refueling a
	join dbo.Vehicle b on a.VehicleID=b.ID
	join dbo.Person c on a.PersonID=c.ID and b.OwnerPersonID!=c.ID


-- 3.9
CREATE FUNCTION dbo.AtlagFogy (@Tol date,@Ig date,@PlateNr varchar(20)) 
RETURNS int

AS
BEGIN

	RETURN
	(select avg(a.Amount)
	from Refueling a
		join dbo.Vehicle b on a.VehicleID=b.ID
	where b.PlateNr=@PlateNr
		and a.RefuelingDate between @Tol and @Ig)

END


select dbo.AtlagFogy ('2016-01-01','2017-12-31','PLT001')


-- 3.10
CREATE PROCEDURE dbo.Tankolas @PlateNr varchar(20), @Tol date, @Ig date, @Intenzitas int
AS
BEGIN

	declare @Datum date
	select @Datum=@Tol


	WHILE (@Datum < @Ig)
	BEGIN
		set @Datum = CASE
						WHEN @Intenzitas=1 THEN dateadd(day,1,@Datum)
						WHEN @Intenzitas=2 THEN dateadd(month,1,@Datum)
						WHEN @Intenzitas=3 THEN dateadd(month,3,@Datum)
					END

		SET @Datum=dateadd(day,cast(RAND()*10 as int),@Datum)

		insert into dbo.Refueling (VehicleID,PersonID,RefuelingDate,Amount)
		select (select ID from dbo.Vehicle where PlateNr=@PlateNr),(SELECT TOP 1 ID FROM dbo.Person ORDER BY NEWID()),@Datum,cast(RAND()*100 as int)

	END

END


Exec dbo.Tankolas 'PLT001', '2016-01-01', '2017-12-31', 2
