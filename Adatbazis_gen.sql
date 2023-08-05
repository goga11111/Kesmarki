CREATE TABLE dbo.Person(
       ID int IDENTITY(1,1) NOT NULL,
       LastName varchar(100) NULL,
       FirstName varchar(100) NULL,
CONSTRAINT PK_Person PRIMARY KEY CLUSTERED (ID ASC))


CREATE TABLE dbo.Vehicle(
       ID int IDENTITY(1,1) NOT NULL,
       Type varchar(100) NULL,
       Brand varchar(100) NULL,
       PlateNr varchar(20) NULL,
       OwnerPersonID int NULL,
CONSTRAINT PK_Vehicle PRIMARY KEY CLUSTERED (ID ASC))

ALTER TABLE dbo.Vehicle  WITH CHECK ADD  CONSTRAINT FK_Person FOREIGN KEY(OwnerPersonID) REFERENCES dbo.Person (ID)
ALTER TABLE dbo.Vehicle CHECK CONSTRAINT FK_Person


CREATE TABLE dbo.HasLicense(
       ID int IDENTITY(1,1) NOT NULL,
       PersonID int NULL,
       VehicleID int NULL)
ALTER TABLE dbo.HasLicense  WITH CHECK ADD  CONSTRAINT FK_Person1 FOREIGN KEY(PersonID) REFERENCES dbo.Person (ID)
ALTER TABLE dbo.HasLicense CHECK CONSTRAINT FK_Person1
ALTER TABLE dbo.HasLicense  WITH CHECK ADD  CONSTRAINT FK_Vehicle1 FOREIGN KEY(VehicleID) REFERENCES dbo.Vehicle (ID)
ALTER TABLE dbo.HasLicense CHECK CONSTRAINT FK_Vehicle1


CREATE TABLE dbo.Refueling(
       ID int IDENTITY(1,1) NOT NULL,
       VehicleID int NULL,
       PersonID int NULL,
       RefuelingDate date NULL,
       Amount int NULL)
ALTER TABLE dbo.Refueling  WITH CHECK ADD  CONSTRAINT FK_Person2 FOREIGN KEY(PersonID) REFERENCES dbo.Person (ID)
ALTER TABLE dbo.Refueling CHECK CONSTRAINT FK_Person2
ALTER TABLE dbo.Refueling  WITH CHECK ADD  CONSTRAINT FK_Vehicle2 FOREIGN KEY(VehicleID) REFERENCES dbo.Vehicle (ID)
ALTER TABLE dbo.Refueling CHECK CONSTRAINT FK_Vehicle2


 