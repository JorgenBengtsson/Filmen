USE [Filmen]
GO
/****** Object:  Table [dbo].[booking]    Script Date: 2019-09-20 15:20:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[booking](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[userid] [int] NOT NULL,
	[viewingid] [int] NOT NULL,
	[payed] [bit] NOT NULL,
	[created] [date] NOT NULL,
 CONSTRAINT [PK_booking] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[cinema]    Script Date: 2019-09-20 15:20:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cinema](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](50) NULL,
	[city] [varchar](50) NULL,
	[created] [date] NULL,
 CONSTRAINT [PK_cinema] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[lounge]    Script Date: 2019-09-20 15:20:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[lounge](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[cinemaid] [int] NOT NULL,
	[name] [varchar](50) NOT NULL,
	[created] [date] NOT NULL,
 CONSTRAINT [PK_lounge] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[seat]    Script Date: 2019-09-20 15:20:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[seat](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[loungeid] [int] NOT NULL,
	[seatnr] [int] NOT NULL,
	[row] [int] NOT NULL,
	[created] [date] NOT NULL,
 CONSTRAINT [PK_seat] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ticket]    Script Date: 2019-09-20 15:20:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ticket](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[bookingid] [int] NOT NULL,
	[seatid] [int] NOT NULL,
	[created] [date] NOT NULL,
 CONSTRAINT [PK_ticket] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[users]    Script Date: 2019-09-20 15:20:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[users](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[username] [varchar](50) NULL,
	[email] [varchar](150) NULL,
	[created] [date] NOT NULL,
 CONSTRAINT [PK_users] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[viewing]    Script Date: 2019-09-20 15:20:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[viewing](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[loungeid] [int] NOT NULL,
	[date] [date] NOT NULL,
	[moviedbid] [varchar](50) NOT NULL,
	[bookable] [bit] NOT NULL,
	[created] [date] NOT NULL,
 CONSTRAINT [PK_viewing] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[booking] ADD  CONSTRAINT [DF_booking_created]  DEFAULT (getdate()) FOR [created]
GO
ALTER TABLE [dbo].[cinema] ADD  CONSTRAINT [DF_cinema_created]  DEFAULT (getdate()) FOR [created]
GO
ALTER TABLE [dbo].[lounge] ADD  CONSTRAINT [DF_lounge_created]  DEFAULT (getdate()) FOR [created]
GO
ALTER TABLE [dbo].[seat] ADD  CONSTRAINT [DF_seat_created]  DEFAULT (getdate()) FOR [created]
GO
ALTER TABLE [dbo].[ticket] ADD  CONSTRAINT [DF_ticket_created]  DEFAULT (getdate()) FOR [created]
GO
ALTER TABLE [dbo].[users] ADD  CONSTRAINT [DF_users_created]  DEFAULT (getdate()) FOR [created]
GO
ALTER TABLE [dbo].[viewing] ADD  CONSTRAINT [DF_viewing_bookable]  DEFAULT ((1)) FOR [bookable]
GO
ALTER TABLE [dbo].[viewing] ADD  CONSTRAINT [DF_viewing_created]  DEFAULT (getdate()) FOR [created]
GO
ALTER TABLE [dbo].[booking]  WITH CHECK ADD  CONSTRAINT [FK_booking_users] FOREIGN KEY([userid])
REFERENCES [dbo].[users] ([id])
GO
ALTER TABLE [dbo].[booking] CHECK CONSTRAINT [FK_booking_users]
GO
ALTER TABLE [dbo].[booking]  WITH CHECK ADD  CONSTRAINT [FK_booking_viewing] FOREIGN KEY([viewingid])
REFERENCES [dbo].[viewing] ([id])
GO
ALTER TABLE [dbo].[booking] CHECK CONSTRAINT [FK_booking_viewing]
GO
ALTER TABLE [dbo].[lounge]  WITH CHECK ADD  CONSTRAINT [FK_lounge_cinema] FOREIGN KEY([cinemaid])
REFERENCES [dbo].[cinema] ([id])
GO
ALTER TABLE [dbo].[lounge] CHECK CONSTRAINT [FK_lounge_cinema]
GO
ALTER TABLE [dbo].[seat]  WITH CHECK ADD  CONSTRAINT [FK_seat_lounge] FOREIGN KEY([loungeid])
REFERENCES [dbo].[lounge] ([id])
GO
ALTER TABLE [dbo].[seat] CHECK CONSTRAINT [FK_seat_lounge]
GO
ALTER TABLE [dbo].[ticket]  WITH CHECK ADD  CONSTRAINT [FK_ticket_booking] FOREIGN KEY([bookingid])
REFERENCES [dbo].[booking] ([id])
GO
ALTER TABLE [dbo].[ticket] CHECK CONSTRAINT [FK_ticket_booking]
GO
ALTER TABLE [dbo].[ticket]  WITH CHECK ADD  CONSTRAINT [FK_ticket_seat] FOREIGN KEY([seatid])
REFERENCES [dbo].[seat] ([id])
GO
ALTER TABLE [dbo].[ticket] CHECK CONSTRAINT [FK_ticket_seat]
GO
ALTER TABLE [dbo].[viewing]  WITH CHECK ADD  CONSTRAINT [FK_viewing_lounge] FOREIGN KEY([loungeid])
REFERENCES [dbo].[lounge] ([id])
GO
ALTER TABLE [dbo].[viewing] CHECK CONSTRAINT [FK_viewing_lounge]
GO
