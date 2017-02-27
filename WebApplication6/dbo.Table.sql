CREATE TABLE [dbo].[Table] (
    [Id]              INT        DEFAULT (NEXT VALUE FOR [dbo].[Table_Id_Sequence]) NOT NULL,
    [TimeNDate]       TEXT NULL,
	[Full_Name]       NCHAR (50) NOT NULL,
    [Email_Address]   NCHAR (50) NOT NULL,
    [Institution]     NCHAR (50) NOT NULL,
    [ZipFileLocation] TEXT       NOT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);

