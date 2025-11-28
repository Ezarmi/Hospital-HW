
-- --------------------------------------------------
-- Entity Designer DDL Script for SQL Server 2005, 2008, 2012 and Azure
-- --------------------------------------------------
-- Date Created: 11/28/2025 04:24:30
-- Generated from EDMX file: C:\Users\Ezarm\Videos\HW\مشاهده شده\50-1 hospital\hospital\Models\Model1.edmx
-- --------------------------------------------------

SET QUOTED_IDENTIFIER OFF;
GO
USE [Mazrouie8834_hospital];
GO
IF SCHEMA_ID(N'dbo') IS NULL EXECUTE(N'CREATE SCHEMA [dbo]');
GO

-- --------------------------------------------------
-- Dropping existing FOREIGN KEY constraints
-- --------------------------------------------------

IF OBJECT_ID(N'[dbo].[FK_tbl_comm_tbl_Language]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[tbl_comm] DROP CONSTRAINT [FK_tbl_comm_tbl_Language];
GO
IF OBJECT_ID(N'[dbo].[FK_tbl_Doctors_tbl_Skills]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[tbl_Doctors] DROP CONSTRAINT [FK_tbl_Doctors_tbl_Skills];
GO
IF OBJECT_ID(N'[dbo].[FK_tbl_Transfer_tbl_Patient]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[tbl_Transfer] DROP CONSTRAINT [FK_tbl_Transfer_tbl_Patient];
GO
IF OBJECT_ID(N'[dbo].[FK_tbl_Transfer_tbl_Visit]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[tbl_Transfer] DROP CONSTRAINT [FK_tbl_Transfer_tbl_Visit];
GO
IF OBJECT_ID(N'[dbo].[FK_tbl_Visit_tbl_Doctors]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[tbl_Visit] DROP CONSTRAINT [FK_tbl_Visit_tbl_Doctors];
GO
IF OBJECT_ID(N'[dbo].[FK_tbl_Visit_tbl_Patient]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[tbl_Visit] DROP CONSTRAINT [FK_tbl_Visit_tbl_Patient];
GO
IF OBJECT_ID(N'[dbo].[FK_tbl_Visit_tbl_Patient1]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[tbl_Visit] DROP CONSTRAINT [FK_tbl_Visit_tbl_Patient1];
GO
IF OBJECT_ID(N'[dbo].[FK_tbl_Visit_tbl_VisitStatus]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[tbl_Visit] DROP CONSTRAINT [FK_tbl_Visit_tbl_VisitStatus];
GO
IF OBJECT_ID(N'[dbo].[FK_tbl_Visit_tbl_VisitType]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[tbl_Visit] DROP CONSTRAINT [FK_tbl_Visit_tbl_VisitType];
GO
IF OBJECT_ID(N'[dbo].[FK_tbl_VisitPerDoctors_tbl_Doctors]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[tbl_VisitPerDoctors] DROP CONSTRAINT [FK_tbl_VisitPerDoctors_tbl_Doctors];
GO
IF OBJECT_ID(N'[dbo].[FK_tbl_VisitPerDoctors_tbl_VisitType]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[tbl_VisitPerDoctors] DROP CONSTRAINT [FK_tbl_VisitPerDoctors_tbl_VisitType];
GO

-- --------------------------------------------------
-- Dropping existing tables
-- --------------------------------------------------

IF OBJECT_ID(N'[dbo].[tbl_Awards]', 'U') IS NOT NULL
    DROP TABLE [dbo].[tbl_Awards];
GO
IF OBJECT_ID(N'[dbo].[tbl_comm]', 'U') IS NOT NULL
    DROP TABLE [dbo].[tbl_comm];
GO
IF OBJECT_ID(N'[dbo].[tbl_Doctors]', 'U') IS NOT NULL
    DROP TABLE [dbo].[tbl_Doctors];
GO
IF OBJECT_ID(N'[dbo].[tbl_Language]', 'U') IS NOT NULL
    DROP TABLE [dbo].[tbl_Language];
GO
IF OBJECT_ID(N'[dbo].[tbl_Patient]', 'U') IS NOT NULL
    DROP TABLE [dbo].[tbl_Patient];
GO
IF OBJECT_ID(N'[dbo].[tbl_Research]', 'U') IS NOT NULL
    DROP TABLE [dbo].[tbl_Research];
GO
IF OBJECT_ID(N'[dbo].[tbl_Skills]', 'U') IS NOT NULL
    DROP TABLE [dbo].[tbl_Skills];
GO
IF OBJECT_ID(N'[dbo].[tbl_Transfer]', 'U') IS NOT NULL
    DROP TABLE [dbo].[tbl_Transfer];
GO
IF OBJECT_ID(N'[dbo].[tbl_Visit]', 'U') IS NOT NULL
    DROP TABLE [dbo].[tbl_Visit];
GO
IF OBJECT_ID(N'[dbo].[tbl_VisitPerDoctors]', 'U') IS NOT NULL
    DROP TABLE [dbo].[tbl_VisitPerDoctors];
GO
IF OBJECT_ID(N'[dbo].[tbl_VisitStatus]', 'U') IS NOT NULL
    DROP TABLE [dbo].[tbl_VisitStatus];
GO
IF OBJECT_ID(N'[dbo].[tbl_VisitType]', 'U') IS NOT NULL
    DROP TABLE [dbo].[tbl_VisitType];
GO
IF OBJECT_ID(N'[dbo].[View_Visit]', 'U') IS NOT NULL
    DROP TABLE [dbo].[View_Visit];
GO
IF OBJECT_ID(N'[dbo].[View_VisitPerDoctors]', 'U') IS NOT NULL
    DROP TABLE [dbo].[View_VisitPerDoctors];
GO
IF OBJECT_ID(N'[Mazrouie8834_hospitalModelStoreContainer].[View_Comm]', 'U') IS NOT NULL
    DROP TABLE [Mazrouie8834_hospitalModelStoreContainer].[View_Comm];
GO

-- --------------------------------------------------
-- Creating all tables
-- --------------------------------------------------

-- Creating table 'tbl_Awards'
CREATE TABLE [dbo].[tbl_Awards] (
    [pkID] int IDENTITY(1,1) NOT NULL,
    [Name] nvarchar(100)  NOT NULL
);
GO

-- Creating table 'tbl_comm'
CREATE TABLE [dbo].[tbl_comm] (
    [pkID] int IDENTITY(1,1) NOT NULL,
    [Name] nvarchar(50)  NOT NULL,
    [valuee] nvarchar(max)  NOT NULL,
    [dis] nvarchar(100)  NOT NULL,
    [typee] int  NOT NULL,
    [fkLangID] int  NOT NULL
);
GO

-- Creating table 'tbl_Doctors'
CREATE TABLE [dbo].[tbl_Doctors] (
    [pkID] int IDENTITY(1,1) NOT NULL,
    [Name] nvarchar(50)  NOT NULL,
    [Family] nvarchar(50)  NOT NULL,
    [fkSkill] int  NOT NULL,
    [PersonalNum] int  NULL,
    [Password] nvarchar(50)  NULL
);
GO

-- Creating table 'tbl_Language'
CREATE TABLE [dbo].[tbl_Language] (
    [pkID] int IDENTITY(1,1) NOT NULL,
    [Language] nvarchar(50)  NOT NULL,
    [LangName] nvarchar(50)  NOT NULL
);
GO

-- Creating table 'tbl_Patient'
CREATE TABLE [dbo].[tbl_Patient] (
    [pkID] int IDENTITY(1,1) NOT NULL,
    [Name] nvarchar(20)  NOT NULL,
    [Family] nvarchar(20)  NOT NULL,
    [Mobile] char(11)  NOT NULL,
    [NationalCode] char(10)  NULL
);
GO

-- Creating table 'tbl_Research'
CREATE TABLE [dbo].[tbl_Research] (
    [pkID] int IDENTITY(1,1) NOT NULL,
    [Name] nvarchar(50)  NOT NULL
);
GO

-- Creating table 'tbl_Skills'
CREATE TABLE [dbo].[tbl_Skills] (
    [pkID] int IDENTITY(1,1) NOT NULL,
    [Skill] nvarchar(50)  NOT NULL
);
GO

-- Creating table 'tbl_Transfer'
CREATE TABLE [dbo].[tbl_Transfer] (
    [pkID] int IDENTITY(1,1) NOT NULL,
    [fkPID] int  NOT NULL,
    [fkVisitID] int  NOT NULL,
    [amount] int  NOT NULL,
    [tracking] varchar(50)  NOT NULL,
    [transid] varchar(50)  NOT NULL,
    [CardNumber] varchar(50)  NOT NULL
);
GO

-- Creating table 'tbl_Visit'
CREATE TABLE [dbo].[tbl_Visit] (
    [pkID] int IDENTITY(1,1) NOT NULL,
    [fkDocID] int  NOT NULL,
    [SDate] datetime  NOT NULL,
    [EDate] datetime  NULL,
    [fkPID] int  NULL,
    [fkVTID] int  NULL,
    [fkVisitStatus] int  NULL,
    [hashid] nvarchar(100)  NULL,
    [pb] datetime  NULL,
    [fkReserverID] int  NULL
);
GO

-- Creating table 'tbl_VisitPerDoctors'
CREATE TABLE [dbo].[tbl_VisitPerDoctors] (
    [pkID] int IDENTITY(1,1) NOT NULL,
    [fkDocID] int  NOT NULL,
    [fkVisitID] int  NOT NULL,
    [Duration] bigint  NOT NULL,
    [amount] int  NOT NULL
);
GO

-- Creating table 'tbl_VisitStatus'
CREATE TABLE [dbo].[tbl_VisitStatus] (
    [pkID] int IDENTITY(1,1) NOT NULL,
    [VisitStatus] nvarchar(50)  NOT NULL
);
GO

-- Creating table 'tbl_VisitType'
CREATE TABLE [dbo].[tbl_VisitType] (
    [pkID] int IDENTITY(1,1) NOT NULL,
    [Type] nvarchar(30)  NOT NULL
);
GO

-- Creating table 'View_Visit'
CREATE TABLE [dbo].[View_Visit] (
    [pkID] int  NOT NULL,
    [fkDocID] int  NOT NULL,
    [SDate] datetime  NOT NULL,
    [EDate] datetime  NULL,
    [fkVTID] int  NULL,
    [fkPID] int  NULL,
    [Name] nvarchar(50)  NOT NULL,
    [Family] nvarchar(50)  NOT NULL,
    [PDate] nvarchar(10)  NULL,
    [PTime] varchar(8)  NULL,
    [pName] nvarchar(20)  NULL,
    [pFamily] nvarchar(20)  NULL,
    [pMobile] char(11)  NULL,
    [Type] nvarchar(30)  NOT NULL,
    [fkVisitStatus] int  NULL,
    [VisitStatus] nvarchar(50)  NOT NULL,
    [hashid] nvarchar(100)  NULL,
    [PNC] char(10)  NULL
);
GO

-- Creating table 'View_VisitPerDoctors'
CREATE TABLE [dbo].[View_VisitPerDoctors] (
    [pkID] int  NOT NULL,
    [fkDocID] int  NOT NULL,
    [fkVisitID] int  NOT NULL,
    [Type] nvarchar(30)  NOT NULL,
    [Duration] bigint  NOT NULL,
    [visit_type_ID] int  NOT NULL
);
GO

-- Creating table 'View_Comm'
CREATE TABLE [dbo].[View_Comm] (
    [Name] nvarchar(50)  NOT NULL,
    [pkID] int  NOT NULL,
    [valuee] nvarchar(max)  NOT NULL,
    [dis] nvarchar(100)  NOT NULL,
    [typee] int  NOT NULL,
    [fkLangID] int  NOT NULL,
    [Language] nvarchar(50)  NOT NULL,
    [LangName] nvarchar(50)  NOT NULL
);
GO

-- --------------------------------------------------
-- Creating all PRIMARY KEY constraints
-- --------------------------------------------------

-- Creating primary key on [pkID] in table 'tbl_Awards'
ALTER TABLE [dbo].[tbl_Awards]
ADD CONSTRAINT [PK_tbl_Awards]
    PRIMARY KEY CLUSTERED ([pkID] ASC);
GO

-- Creating primary key on [pkID] in table 'tbl_comm'
ALTER TABLE [dbo].[tbl_comm]
ADD CONSTRAINT [PK_tbl_comm]
    PRIMARY KEY CLUSTERED ([pkID] ASC);
GO

-- Creating primary key on [pkID] in table 'tbl_Doctors'
ALTER TABLE [dbo].[tbl_Doctors]
ADD CONSTRAINT [PK_tbl_Doctors]
    PRIMARY KEY CLUSTERED ([pkID] ASC);
GO

-- Creating primary key on [pkID] in table 'tbl_Language'
ALTER TABLE [dbo].[tbl_Language]
ADD CONSTRAINT [PK_tbl_Language]
    PRIMARY KEY CLUSTERED ([pkID] ASC);
GO

-- Creating primary key on [pkID] in table 'tbl_Patient'
ALTER TABLE [dbo].[tbl_Patient]
ADD CONSTRAINT [PK_tbl_Patient]
    PRIMARY KEY CLUSTERED ([pkID] ASC);
GO

-- Creating primary key on [pkID] in table 'tbl_Research'
ALTER TABLE [dbo].[tbl_Research]
ADD CONSTRAINT [PK_tbl_Research]
    PRIMARY KEY CLUSTERED ([pkID] ASC);
GO

-- Creating primary key on [pkID] in table 'tbl_Skills'
ALTER TABLE [dbo].[tbl_Skills]
ADD CONSTRAINT [PK_tbl_Skills]
    PRIMARY KEY CLUSTERED ([pkID] ASC);
GO

-- Creating primary key on [pkID] in table 'tbl_Transfer'
ALTER TABLE [dbo].[tbl_Transfer]
ADD CONSTRAINT [PK_tbl_Transfer]
    PRIMARY KEY CLUSTERED ([pkID] ASC);
GO

-- Creating primary key on [pkID] in table 'tbl_Visit'
ALTER TABLE [dbo].[tbl_Visit]
ADD CONSTRAINT [PK_tbl_Visit]
    PRIMARY KEY CLUSTERED ([pkID] ASC);
GO

-- Creating primary key on [pkID] in table 'tbl_VisitPerDoctors'
ALTER TABLE [dbo].[tbl_VisitPerDoctors]
ADD CONSTRAINT [PK_tbl_VisitPerDoctors]
    PRIMARY KEY CLUSTERED ([pkID] ASC);
GO

-- Creating primary key on [pkID] in table 'tbl_VisitStatus'
ALTER TABLE [dbo].[tbl_VisitStatus]
ADD CONSTRAINT [PK_tbl_VisitStatus]
    PRIMARY KEY CLUSTERED ([pkID] ASC);
GO

-- Creating primary key on [pkID] in table 'tbl_VisitType'
ALTER TABLE [dbo].[tbl_VisitType]
ADD CONSTRAINT [PK_tbl_VisitType]
    PRIMARY KEY CLUSTERED ([pkID] ASC);
GO

-- Creating primary key on [pkID], [fkDocID], [SDate], [Name], [Family], [Type], [VisitStatus] in table 'View_Visit'
ALTER TABLE [dbo].[View_Visit]
ADD CONSTRAINT [PK_View_Visit]
    PRIMARY KEY CLUSTERED ([pkID], [fkDocID], [SDate], [Name], [Family], [Type], [VisitStatus] ASC);
GO

-- Creating primary key on [pkID], [fkDocID], [fkVisitID], [Type], [Duration], [visit_type_ID] in table 'View_VisitPerDoctors'
ALTER TABLE [dbo].[View_VisitPerDoctors]
ADD CONSTRAINT [PK_View_VisitPerDoctors]
    PRIMARY KEY CLUSTERED ([pkID], [fkDocID], [fkVisitID], [Type], [Duration], [visit_type_ID] ASC);
GO

-- Creating primary key on [Name], [pkID], [valuee], [dis], [typee], [fkLangID], [Language], [LangName] in table 'View_Comm'
ALTER TABLE [dbo].[View_Comm]
ADD CONSTRAINT [PK_View_Comm]
    PRIMARY KEY CLUSTERED ([Name], [pkID], [valuee], [dis], [typee], [fkLangID], [Language], [LangName] ASC);
GO

-- --------------------------------------------------
-- Creating all FOREIGN KEY constraints
-- --------------------------------------------------

-- Creating foreign key on [fkLangID] in table 'tbl_comm'
ALTER TABLE [dbo].[tbl_comm]
ADD CONSTRAINT [FK_tbl_comm_tbl_Language]
    FOREIGN KEY ([fkLangID])
    REFERENCES [dbo].[tbl_Language]
        ([pkID])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_tbl_comm_tbl_Language'
CREATE INDEX [IX_FK_tbl_comm_tbl_Language]
ON [dbo].[tbl_comm]
    ([fkLangID]);
GO

-- Creating foreign key on [fkSkill] in table 'tbl_Doctors'
ALTER TABLE [dbo].[tbl_Doctors]
ADD CONSTRAINT [FK_tbl_Doctors_tbl_Skills]
    FOREIGN KEY ([fkSkill])
    REFERENCES [dbo].[tbl_Skills]
        ([pkID])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_tbl_Doctors_tbl_Skills'
CREATE INDEX [IX_FK_tbl_Doctors_tbl_Skills]
ON [dbo].[tbl_Doctors]
    ([fkSkill]);
GO

-- Creating foreign key on [fkDocID] in table 'tbl_Visit'
ALTER TABLE [dbo].[tbl_Visit]
ADD CONSTRAINT [FK_tbl_Visit_tbl_Doctors]
    FOREIGN KEY ([fkDocID])
    REFERENCES [dbo].[tbl_Doctors]
        ([pkID])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_tbl_Visit_tbl_Doctors'
CREATE INDEX [IX_FK_tbl_Visit_tbl_Doctors]
ON [dbo].[tbl_Visit]
    ([fkDocID]);
GO

-- Creating foreign key on [fkDocID] in table 'tbl_VisitPerDoctors'
ALTER TABLE [dbo].[tbl_VisitPerDoctors]
ADD CONSTRAINT [FK_tbl_VisitPerDoctors_tbl_Doctors]
    FOREIGN KEY ([fkDocID])
    REFERENCES [dbo].[tbl_Doctors]
        ([pkID])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_tbl_VisitPerDoctors_tbl_Doctors'
CREATE INDEX [IX_FK_tbl_VisitPerDoctors_tbl_Doctors]
ON [dbo].[tbl_VisitPerDoctors]
    ([fkDocID]);
GO

-- Creating foreign key on [fkPID] in table 'tbl_Transfer'
ALTER TABLE [dbo].[tbl_Transfer]
ADD CONSTRAINT [FK_tbl_Transfer_tbl_Patient]
    FOREIGN KEY ([fkPID])
    REFERENCES [dbo].[tbl_Patient]
        ([pkID])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_tbl_Transfer_tbl_Patient'
CREATE INDEX [IX_FK_tbl_Transfer_tbl_Patient]
ON [dbo].[tbl_Transfer]
    ([fkPID]);
GO

-- Creating foreign key on [fkPID] in table 'tbl_Visit'
ALTER TABLE [dbo].[tbl_Visit]
ADD CONSTRAINT [FK_tbl_Visit_tbl_Patient]
    FOREIGN KEY ([fkPID])
    REFERENCES [dbo].[tbl_Patient]
        ([pkID])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_tbl_Visit_tbl_Patient'
CREATE INDEX [IX_FK_tbl_Visit_tbl_Patient]
ON [dbo].[tbl_Visit]
    ([fkPID]);
GO

-- Creating foreign key on [fkReserverID] in table 'tbl_Visit'
ALTER TABLE [dbo].[tbl_Visit]
ADD CONSTRAINT [FK_tbl_Visit_tbl_Patient1]
    FOREIGN KEY ([fkReserverID])
    REFERENCES [dbo].[tbl_Patient]
        ([pkID])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_tbl_Visit_tbl_Patient1'
CREATE INDEX [IX_FK_tbl_Visit_tbl_Patient1]
ON [dbo].[tbl_Visit]
    ([fkReserverID]);
GO

-- Creating foreign key on [fkVisitID] in table 'tbl_Transfer'
ALTER TABLE [dbo].[tbl_Transfer]
ADD CONSTRAINT [FK_tbl_Transfer_tbl_Visit]
    FOREIGN KEY ([fkVisitID])
    REFERENCES [dbo].[tbl_Visit]
        ([pkID])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_tbl_Transfer_tbl_Visit'
CREATE INDEX [IX_FK_tbl_Transfer_tbl_Visit]
ON [dbo].[tbl_Transfer]
    ([fkVisitID]);
GO

-- Creating foreign key on [fkVisitStatus] in table 'tbl_Visit'
ALTER TABLE [dbo].[tbl_Visit]
ADD CONSTRAINT [FK_tbl_Visit_tbl_VisitStatus]
    FOREIGN KEY ([fkVisitStatus])
    REFERENCES [dbo].[tbl_VisitStatus]
        ([pkID])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_tbl_Visit_tbl_VisitStatus'
CREATE INDEX [IX_FK_tbl_Visit_tbl_VisitStatus]
ON [dbo].[tbl_Visit]
    ([fkVisitStatus]);
GO

-- Creating foreign key on [fkVTID] in table 'tbl_Visit'
ALTER TABLE [dbo].[tbl_Visit]
ADD CONSTRAINT [FK_tbl_Visit_tbl_VisitType]
    FOREIGN KEY ([fkVTID])
    REFERENCES [dbo].[tbl_VisitType]
        ([pkID])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_tbl_Visit_tbl_VisitType'
CREATE INDEX [IX_FK_tbl_Visit_tbl_VisitType]
ON [dbo].[tbl_Visit]
    ([fkVTID]);
GO

-- Creating foreign key on [fkVisitID] in table 'tbl_VisitPerDoctors'
ALTER TABLE [dbo].[tbl_VisitPerDoctors]
ADD CONSTRAINT [FK_tbl_VisitPerDoctors_tbl_VisitType]
    FOREIGN KEY ([fkVisitID])
    REFERENCES [dbo].[tbl_VisitType]
        ([pkID])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_tbl_VisitPerDoctors_tbl_VisitType'
CREATE INDEX [IX_FK_tbl_VisitPerDoctors_tbl_VisitType]
ON [dbo].[tbl_VisitPerDoctors]
    ([fkVisitID]);
GO

-- --------------------------------------------------
-- Script has ended
-- --------------------------------------------------