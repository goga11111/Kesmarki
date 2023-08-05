Declare @PID table (ID int) -- A frissen töltött Person ID-k
Declare @VID table (ID int) -- A frissen töltött Vehicle ID-k
Declare @cur1 int
Declare @Vid1 int
Declare @Pid1 int
declare @Tol date = '2016-01-01'
declare @Ig date = '2017-12-31'
declare @Intenzitas int = 2
declare @Datum date
declare @db int = 1

-------------------------------------------------- Person -----------------------------------------

insert into dbo.Person (LastName,FirstName) values ('Péter','Kovács')
insert into @PID select @@IDENTITY
insert into dbo.Person (LastName,FirstName) values ('Nándor','Kiss')
insert into @PID select @@IDENTITY
insert into dbo.Person (LastName,FirstName) values ('Tibor','Nagy')
insert into @PID select @@IDENTITY
insert into dbo.Person (LastName,FirstName) values ('Zoltán','Török')
insert into @PID select @@IDENTITY
insert into dbo.Person (LastName,FirstName) values ('András','Gyulai')
insert into @PID select @@IDENTITY
insert into dbo.Person (LastName,FirstName) values ('András','Tisza')
insert into @PID select @@IDENTITY
insert into dbo.Person (LastName,FirstName) values ('Béla','Duna')
insert into @PID select @@IDENTITY
insert into dbo.Person (LastName,FirstName) values ('Attila','Szabó')
insert into @PID select @@IDENTITY
insert into dbo.Person (LastName,FirstName) values ('Pál','Kádár')
insert into @PID select @@IDENTITY
insert into dbo.Person (LastName,FirstName) values ('Tibor','Seres')
insert into @PID select @@IDENTITY
insert into dbo.Person (LastName,FirstName) values ('Nándor','Kiss')
insert into @PID select @@IDENTITY
insert into dbo.Person (LastName,FirstName) values ('Attila','Dunai')
insert into @PID select @@IDENTITY
insert into dbo.Person (LastName,FirstName) values ('Géza','Mezei')
insert into @PID select @@IDENTITY
insert into dbo.Person (LastName,FirstName) values ('Zoltán','Horváth')
insert into @PID select @@IDENTITY
insert into dbo.Person (LastName,FirstName) values ('Géza','Csabai')
insert into @PID select @@IDENTITY
insert into dbo.Person (LastName,FirstName) values ('Gábor','Szomolányi')
insert into @PID select @@IDENTITY
insert into dbo.Person (LastName,FirstName) values ('Tibor','Csatlós')
insert into @PID select @@IDENTITY
insert into dbo.Person (LastName,FirstName) values ('Endre','Ködi')
insert into @PID select @@IDENTITY
insert into dbo.Person (LastName,FirstName) values ('Márta','Nagy')
insert into @PID select @@IDENTITY
insert into dbo.Person (LastName,FirstName) values ('Ildikó','Gesztesi')
insert into @PID select @@IDENTITY
 

-------------------------------------------------- Vehicle -----------------------------------------

insert into dbo.Vehicle (Type,Brand,PlateNr,OwnerPersonID) values('T1','B1','PLT001',NULL)
insert into @VID select @@IDENTITY
insert into dbo.Vehicle (Type,Brand,PlateNr,OwnerPersonID) values('T2','B2','PLT002',NULL)
insert into @VID select @@IDENTITY
insert into dbo.Vehicle (Type,Brand,PlateNr,OwnerPersonID) values('T3','B3','PLT003',NULL)
insert into @VID select @@IDENTITY
insert into dbo.Vehicle (Type,Brand,PlateNr,OwnerPersonID) values('T4','B4','PLT004',NULL)
insert into @VID select @@IDENTITY
insert into dbo.Vehicle (Type,Brand,PlateNr,OwnerPersonID) values('T5','B5','PLT005',NULL)
insert into @VID select @@IDENTITY
insert into dbo.Vehicle (Type,Brand,PlateNr,OwnerPersonID) values('T6','B6','PLT006',NULL)
insert into @VID select @@IDENTITY
insert into dbo.Vehicle (Type,Brand,PlateNr,OwnerPersonID) values('T7','B7','PLT007',NULL)
insert into @VID select @@IDENTITY
insert into dbo.Vehicle (Type,Brand,PlateNr,OwnerPersonID) values('T8','B8','PLT008',NULL)
insert into @VID select @@IDENTITY
insert into dbo.Vehicle (Type,Brand,PlateNr,OwnerPersonID) values('T9','B9','PLT009',NULL)
insert into @VID select @@IDENTITY
insert into dbo.Vehicle (Type,Brand,PlateNr,OwnerPersonID) values('T10','B10','PLT010',NULL)
insert into @VID select @@IDENTITY
insert into dbo.Vehicle (Type,Brand,PlateNr,OwnerPersonID) values('T11','B11','PLT011',NULL)
insert into @VID select @@IDENTITY
insert into dbo.Vehicle (Type,Brand,PlateNr,OwnerPersonID) values('T12','B12','PLT012',NULL)
insert into @VID select @@IDENTITY
insert into dbo.Vehicle (Type,Brand,PlateNr,OwnerPersonID) values('T13','B13','PLT013',NULL)
insert into @VID select @@IDENTITY
insert into dbo.Vehicle (Type,Brand,PlateNr,OwnerPersonID) values('T14','B14','PLT014',NULL)
insert into @VID select @@IDENTITY
insert into dbo.Vehicle (Type,Brand,PlateNr,OwnerPersonID) values('T15','B15','PLT015',NULL)
insert into @VID select @@IDENTITY
insert into dbo.Vehicle (Type,Brand,PlateNr,OwnerPersonID) values('T16','B16','PLT016',NULL)
insert into @VID select @@IDENTITY
insert into dbo.Vehicle (Type,Brand,PlateNr,OwnerPersonID) values('T17','B17','PLT017',NULL)
insert into @VID select @@IDENTITY
insert into dbo.Vehicle (Type,Brand,PlateNr,OwnerPersonID) values('T18','B18','PLT018',NULL)
insert into @VID select @@IDENTITY
insert into dbo.Vehicle (Type,Brand,PlateNr,OwnerPersonID) values('T19','B19','PLT019',NULL)
insert into @VID select @@IDENTITY
insert into dbo.Vehicle (Type,Brand,PlateNr,OwnerPersonID) values('T20','B20','PLT020',NULL)
insert into @VID select @@IDENTITY
 

-- Vehicle.OwnerPersonID töltés
select @Vid1=min(ID) from dbo.Vehicle
select @Pid1=min(ID) from @PID

DECLARE cur CURSOR FOR (SELECT ID from @VID)
OPEN cur;
FETCH NEXT FROM cur INTO @cur1;
WHILE (@@FETCH_STATUS <> -1)
BEGIN
	update dbo.Vehicle set OwnerPersonID=@Pid1 where ID=@cur1
	select @Pid1=min(ID) from @PID where ID > @Pid1
	FETCH NEXT FROM cur INTO @cur1;
END
CLOSE cur
DEALLOCATE cur

-------------------------------------------------- HasLicense -----------------------------------------

insert into dbo.HasLicense (PersonID,VehicleID)
select top 20 a.OwnerPersonID ,a.ID
from dbo.Vehicle a
	join @VID b on a.ID=b.ID

DECLARE cur CURSOR FOR (SELECT top 10 ID from @VID)
OPEN cur;
FETCH NEXT FROM cur INTO @cur1;
WHILE (@@FETCH_STATUS <> -1)
BEGIN
	insert into dbo.HasLicense (PersonID,VehicleID)
	select top 1 c.ID, a.VehicleID
	from dbo.HasLicense a
		join @VID b on a.VehicleID=b.ID
		join dbo.Person c on a.PersonID!=c.ID
		join @PID d on a.PersonID=d.ID
	where a.VehicleID=@cur1

	FETCH NEXT FROM cur INTO @cur1;
END
CLOSE cur
DEALLOCATE cur

 
-------------------------------------------------- Refueling -----------------------------------------

select @Datum=@Tol
 
DECLARE cur CURSOR FOR (SELECT ID from @VID)
OPEN cur;
FETCH NEXT FROM cur INTO @cur1;
WHILE (@@FETCH_STATUS <> -1)
BEGIN

	WHILE (@Datum < @Ig) and (@db < 6)
	BEGIN
		set @Datum = CASE
						WHEN @Intenzitas=1 THEN dateadd(day,1,@Datum)
						WHEN @Intenzitas=2 THEN dateadd(month,1,@Datum)
						WHEN @Intenzitas=3 THEN dateadd(month,3,@Datum)
					END

		SET @Datum=dateadd(day,cast(RAND()*10 as int),@Datum)
		SET @db=@db+1

		insert into dbo.Refueling (VehicleID,PersonID,RefuelingDate,Amount)
		select @cur1,(SELECT TOP 1 ID FROM @PID ORDER BY NEWID()),@Datum,cast(RAND()*100 as int)

	END

	select @Datum=@Tol
	select @db=1

	FETCH NEXT FROM cur INTO @cur1;
END
CLOSE cur
DEALLOCATE cur
