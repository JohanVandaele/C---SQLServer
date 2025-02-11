drop database ADOBank2
go

create database ADOBank2
go
use ADOBank2
go

CREATE TABLE [Klanten]
(
	[KlantId] [int] IDENTITY(1,1) NOT NULL,
	[Naam] [nvarchar](50) NOT NULL,
	
	CONSTRAINT [Klanten$PrimaryKey] PRIMARY KEY CLUSTERED ([KlantId] ASC)
		WITH (PAD_INDEX=OFF, STATISTICS_NORECOMPUTE=OFF, IGNORE_DUP_KEY=OFF, ALLOW_ROW_LOCKS=ON, ALLOW_PAGE_LOCKS=ON)	ON [PRIMARY]
)
ON [PRIMARY]
GO

SET IDENTITY_INSERT [Klanten] ON
INSERT [Klanten] ([KlantId], [Naam]) VALUES (1, N'Asterix')
INSERT [Klanten] ([KlantId], [Naam]) VALUES (2, N'Obelix')
SET IDENTITY_INSERT [Klanten] OFF

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [Rekeningen]
(
	[RekeningId] [int] IDENTITY(1,1) NOT NULL,
	[RekeningNr] [nvarchar](19) NOT NULL,
	[KlantId] [int] NOT NULL,
	[Saldo] [money] NOT NULL,
	
	CONSTRAINT [Rekeningen$PrimaryKey] PRIMARY KEY CLUSTERED ([RekeningId] ASC)
		WITH (PAD_INDEX=OFF, STATISTICS_NORECOMPUTE=OFF, IGNORE_DUP_KEY=OFF, ALLOW_ROW_LOCKS=ON, ALLOW_PAGE_LOCKS=ON) ON [PRIMARY]
)
ON [PRIMARY]
GO

SET IDENTITY_INSERT [Rekeningen] ON
INSERT [Rekeningen] ([RekeningId], [RekeningNr], [KlantId], [Saldo]) VALUES (1, N'BE68 5555 5555 1234', 1, 5000.00)
INSERT [Rekeningen] ([RekeningId], [RekeningNr], [KlantId], [Saldo]) VALUES (2, N'BE68 6666 6666 5678', 1, 6000.00)
INSERT [Rekeningen] ([RekeningId], [RekeningNr], [KlantId], [Saldo]) VALUES (3, N'BE68 7777 7777 9876', 2, 7000.00)
INSERT [Rekeningen] ([RekeningId], [RekeningNr], [KlantId], [Saldo]) VALUES (4, N'BE68 8888 9999 5432', 2, 8000.00)
SET IDENTITY_INSERT [Rekeningen] OFF

ALTER TABLE [Rekeningen] ADD CONSTRAINT IDX_RekeningNr UNIQUE (RekeningNr)
GO

ALTER TABLE [Rekeningen] ADD  DEFAULT ((0)) FOR [Saldo]
GO

ALTER TABLE [Klanten]  WITH NOCHECK ADD  CONSTRAINT [SSMA_CC$Klanten$Naam$disallow_zero_length] CHECK  ((len([Naam])>(0)))
GO

ALTER TABLE [Klanten] CHECK CONSTRAINT [SSMA_CC$Klanten$Naam$disallow_zero_length]
GO

ALTER TABLE [Rekeningen]  WITH NOCHECK ADD  CONSTRAINT [SSMA_CC$Rekeningen$RekeningNr$disallow_zero_length] CHECK  ((len([RekeningNr])>(0)))
GO

ALTER TABLE [Rekeningen] CHECK CONSTRAINT [SSMA_CC$Rekeningen$RekeningNr$disallow_zero_length]
GO

ALTER TABLE [Rekeningen]  WITH NOCHECK ADD  CONSTRAINT [Rekeningen$KlantenRekeningen] FOREIGN KEY([KlantId])
REFERENCES [Klanten] ([KlantId])
GO

ALTER TABLE [Rekeningen] CHECK CONSTRAINT [Rekeningen$KlantenRekeningen]
GO
