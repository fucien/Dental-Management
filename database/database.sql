USE [master]
GO
/****** Object:  Database [DentalClinic]    Script Date: 27/08/2023 4:41:34 pm ******/
CREATE DATABASE [DentalClinic]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'DentalClinic', FILENAME = N'D:\Program Files\MSSQL16.SQLEXPRESS01\MSSQL\DATA\DentalClinic.mdf' , SIZE = 139264KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'DentalClinic_log', FILENAME = N'D:\Program Files\MSSQL16.SQLEXPRESS01\MSSQL\DATA\DentalClinic_log.ldf' , SIZE = 73728KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [DentalClinic] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [DentalClinic].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [DentalClinic] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [DentalClinic] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [DentalClinic] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [DentalClinic] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [DentalClinic] SET ARITHABORT OFF 
GO
ALTER DATABASE [DentalClinic] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [DentalClinic] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [DentalClinic] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [DentalClinic] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [DentalClinic] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [DentalClinic] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [DentalClinic] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [DentalClinic] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [DentalClinic] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [DentalClinic] SET  DISABLE_BROKER 
GO
ALTER DATABASE [DentalClinic] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [DentalClinic] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [DentalClinic] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [DentalClinic] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [DentalClinic] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [DentalClinic] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [DentalClinic] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [DentalClinic] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [DentalClinic] SET  MULTI_USER 
GO
ALTER DATABASE [DentalClinic] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [DentalClinic] SET DB_CHAINING OFF 
GO
ALTER DATABASE [DentalClinic] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [DentalClinic] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [DentalClinic] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [DentalClinic] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [DentalClinic] SET QUERY_STORE = ON
GO
ALTER DATABASE [DentalClinic] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [DentalClinic]
GO
/****** Object:  Table [dbo].[Account]    Script Date: 27/08/2023 4:41:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Account](
	[AccID] [int] IDENTITY(1,1) NOT NULL,
	[AccName] [varchar](90) NOT NULL,
	[Password] [varchar](90) NOT NULL,
	[Role] [varchar](90) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[AccID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AppointmentRequests]    Script Date: 27/08/2023 4:41:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AppointmentRequests](
	[RequestID] [int] IDENTITY(1,1) NOT NULL,
	[PatientID] [int] NOT NULL,
	[DentistID] [INT] NOT NULL,
	[StaffID] [int] NOT NULL,
	[RequestDate] [datetime] NULL,
	[Note] [varchar](255) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[RequestID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Appointments]    Script Date: 27/08/2023 4:41:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Appointments](
	[AppointmentID] [int] IDENTITY(1,1) NOT NULL,
	[RequestID] [int] NOT NULL,
	[DentistID] [int] NOT NULL,
	[PatientID] [int] NOT NULL,
	[Date] [date] NOT NULL,
	[RequestOrder] [int] NOT NULL,
	[Room] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[AppointmentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Dentist]    Script Date: 27/08/2023 4:41:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Dentist](
	[DentistID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](90) NOT NULL,
	[Address] [varchar](90) NOT NULL,
	[Phone] [varchar](11) NOT NULL,
	[Email] [varchar](90) NOT NULL,
	[AccID] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[DentistID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Medicines]    Script Date: 27/08/2023 4:41:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Medicines](
	[MedicineID] [int] IDENTITY(1,1) NOT NULL,
	[MedicineName] [varchar](90) NOT NULL,
	[Amount] [int] NOT NULL,
	[Res] [int] NOT NULL,
	[Price] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[MedicineID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Patient]    Script Date: 27/08/2023 4:41:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Patient](
	[PatientID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](90) NOT NULL,
	[Address] [varchar](90) NOT NULL,
	[Phone] [varchar](90) NOT NULL,
	[Email] [varchar](90) NOT NULL,
	[DoB] [date] NOT NULL,
	[Gender] [varchar](5) NOT NULL,
	[PatientStatus] [varchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[PatientID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Payments]    Script Date: 27/08/2023 4:41:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Payments](
	[PaymentID] [int] IDENTITY(1,1) NOT NULL,
	[PrescriptionID] [int] NOT NULL,
	[PatientID] [int] NOT NULL,
	[PaymentDate] [date] NOT NULL,
	[Total] [int] NOT NULL,
	[AmountPaid] [int] NOT NULL,
	[TypeOfPayment] [varchar](90) NOT NULL,
	[Note] [varchar](90) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[PaymentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Prescriptions]    Script Date: 27/08/2023 4:41:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Prescriptions](
	[PrescriptionID] [int] IDENTITY(1,1) NOT NULL,
	[PlanID] [int] NOT NULL,
	[MedicineID] [int] NOT NULL,
	[PreDate] [date] NOT NULL,
	[Note] [varchar](255) NOT NULL,
	[DentistID] [int] NOT NULL,
	[Amount] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[PrescriptionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Schedules]    Script Date: 27/08/2023 4:41:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Schedules](
	[ScheduleID] [int] IDENTITY(1,1) NOT NULL,
	[StaffID] [int] NOT NULL,
	[DentistID] [int] NOT NULL,
	[RequestID] [int] NOT NULL,
	[SchDate] [varchar](100) NULL,
	[SchStart] [date] NOT NULL,
	[SchEnd] [date] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ScheduleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Staff]    Script Date: 27/08/2023 4:41:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Staff](
	[StaffID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](90) NOT NULL,
	[Address] [varchar](90) NOT NULL,
	[Phone] [varchar](11) NOT NULL,
	[Email] [varchar](90) NOT NULL,
	[AccID] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[StaffID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ToothTreatment]    Script Date: 27/08/2023 4:41:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ToothTreatment](
	[ToothID] [int] IDENTITY(1,1) NOT NULL,
	[ToothNumber] [int] NOT NULL,
	[ToothFace] [varchar](11) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ToothID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TreatmentPlans]    Script Date: 27/08/2023 4:41:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TreatmentPlans](
	[PlanID] [int] IDENTITY(1,1) NOT NULL,
	[DentistID] [int] NOT NULL,
	[ExDentistID] [int] NULL,
	[PatientID] [int] NOT NULL,
	[ToothID] [int] NOT NULL,
	[TreatmentDate] [date] NOT NULL,
	[TreatmentCode] [varchar](10) NULL,
 CONSTRAINT [PK__Treatmen__755C22D7E7D6B74E] PRIMARY KEY CLUSTERED 
(
	[PlanID] ASC,
	[DentistID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[AppointmentRequests]  WITH CHECK ADD  CONSTRAINT [FK_AppointmentRequests_PatientID] FOREIGN KEY([PatientID])
REFERENCES [dbo].[Patient] ([PatientID])
GO
ALTER TABLE [dbo].[AppointmentRequests] CHECK CONSTRAINT [FK_AppointmentRequests_PatientID]
GO
ALTER TABLE [dbo].[AppointmentRequests]  WITH CHECK ADD  CONSTRAINT [FK_AppointmentRequests_DentistID] FOREIGN KEY([DentistID])
REFERENCES [dbo].[Dentist] ([DentistID])
GO
ALTER TABLE [dbo].[AppointmentRequests] CHECK CONSTRAINT [FK_AppointmentRequests_PatientID]
GO
ALTER TABLE [dbo].[AppointmentRequests]  WITH CHECK ADD  CONSTRAINT [FK_AppointmentRequests_StaffID] FOREIGN KEY([StaffID])
REFERENCES [dbo].[Staff] ([StaffID])
GO
ALTER TABLE [dbo].[AppointmentRequests] CHECK CONSTRAINT [FK_AppointmentRequests_StaffID]
GO
ALTER TABLE [dbo].[Appointments]  WITH CHECK ADD  CONSTRAINT [FK_Appointments_DentistID] FOREIGN KEY([DentistID])
REFERENCES [dbo].[Dentist] ([DentistID])
GO
ALTER TABLE [dbo].[Appointments] CHECK CONSTRAINT [FK_Appointments_DentistID]
GO
ALTER TABLE [dbo].[Appointments]  WITH CHECK ADD  CONSTRAINT [FK_Appointments_PatientID] FOREIGN KEY([PatientID])
REFERENCES [dbo].[Patient] ([PatientID])
GO
ALTER TABLE [dbo].[Appointments] CHECK CONSTRAINT [FK_Appointments_PatientID]
GO
ALTER TABLE [dbo].[Appointments]  WITH CHECK ADD  CONSTRAINT [FK_Appointments_RequestID] FOREIGN KEY([RequestID])
REFERENCES [dbo].[AppointmentRequests] ([RequestID])
GO
ALTER TABLE [dbo].[Appointments] CHECK CONSTRAINT [FK_Appointments_RequestID]
GO
ALTER TABLE [dbo].[Dentist]  WITH CHECK ADD  CONSTRAINT [FK_Dentist_AccID] FOREIGN KEY([AccID])
REFERENCES [dbo].[Account] ([AccID])
GO
ALTER TABLE [dbo].[Dentist] CHECK CONSTRAINT [FK_Dentist_AccID]
GO
ALTER TABLE [dbo].[Payments]  WITH CHECK ADD  CONSTRAINT [FK_Payments_PatientID] FOREIGN KEY([PatientID])
REFERENCES [dbo].[Patient] ([PatientID])
GO
ALTER TABLE [dbo].[Payments] CHECK CONSTRAINT [FK_Payments_PatientID]
GO
ALTER TABLE [dbo].[Payments]  WITH CHECK ADD  CONSTRAINT [FK_Payments_ToothID] FOREIGN KEY([PrescriptionID])
REFERENCES [dbo].[Prescriptions] ([PrescriptionID])
GO
ALTER TABLE [dbo].[Payments] CHECK CONSTRAINT [FK_Payments_ToothID]
GO
ALTER TABLE [dbo].[Prescriptions]  WITH CHECK ADD  CONSTRAINT [FK_Prescriptions_MedicineID] FOREIGN KEY([MedicineID])
REFERENCES [dbo].[Medicines] ([MedicineID])
GO
ALTER TABLE [dbo].[Prescriptions] CHECK CONSTRAINT [FK_Prescriptions_MedicineID]
GO
ALTER TABLE [dbo].[Prescriptions]  WITH CHECK ADD  CONSTRAINT [FK_Prescriptions_TreatmentPlans] FOREIGN KEY([PlanID], [DentistID])
REFERENCES [dbo].[TreatmentPlans] ([PlanID], [DentistID])
GO
ALTER TABLE [dbo].[Prescriptions] CHECK CONSTRAINT [FK_Prescriptions_TreatmentPlans]
GO
ALTER TABLE [dbo].[Schedules]  WITH CHECK ADD  CONSTRAINT [FK_Schedules_DentistID] FOREIGN KEY([DentistID])
REFERENCES [dbo].[Dentist] ([DentistID])
GO
ALTER TABLE [dbo].[Schedules] CHECK CONSTRAINT [FK_Schedules_DentistID]
GO
ALTER TABLE [dbo].[Schedules]  WITH CHECK ADD  CONSTRAINT [FK_Schedules_RequestID] FOREIGN KEY([RequestID])
REFERENCES [dbo].[AppointmentRequests] ([RequestID])
GO
ALTER TABLE [dbo].[Schedules] CHECK CONSTRAINT [FK_Schedules_RequestID]
GO
ALTER TABLE [dbo].[Schedules]  WITH CHECK ADD  CONSTRAINT [FK_Schedules_StaffID] FOREIGN KEY([StaffID])
REFERENCES [dbo].[Staff] ([StaffID])
GO
ALTER TABLE [dbo].[Schedules] CHECK CONSTRAINT [FK_Schedules_StaffID]
GO
ALTER TABLE [dbo].[Staff]  WITH CHECK ADD  CONSTRAINT [FK_Staff_AccID] FOREIGN KEY([AccID])
REFERENCES [dbo].[Account] ([AccID])
GO
ALTER TABLE [dbo].[Staff] CHECK CONSTRAINT [FK_Staff_AccID]
GO
ALTER TABLE [dbo].[TreatmentPlans]  WITH CHECK ADD  CONSTRAINT [FK_TreatmentPlans_Dentist] FOREIGN KEY([ExDentistID])
REFERENCES [dbo].[Dentist] ([DentistID])
GO
ALTER TABLE [dbo].[TreatmentPlans] CHECK CONSTRAINT [FK_TreatmentPlans_Dentist]
GO
ALTER TABLE [dbo].[TreatmentPlans]  WITH CHECK ADD  CONSTRAINT [FK_TreatmentPlans_DentistID] FOREIGN KEY([DentistID])
REFERENCES [dbo].[Dentist] ([DentistID])
GO
ALTER TABLE [dbo].[TreatmentPlans] CHECK CONSTRAINT [FK_TreatmentPlans_DentistID]
GO
ALTER TABLE [dbo].[TreatmentPlans]  WITH CHECK ADD  CONSTRAINT [FK_TreatmentPlans_PatientID] FOREIGN KEY([PatientID])
REFERENCES [dbo].[Patient] ([PatientID])
GO
ALTER TABLE [dbo].[TreatmentPlans] CHECK CONSTRAINT [FK_TreatmentPlans_PatientID]
GO
ALTER TABLE [dbo].[TreatmentPlans]  WITH CHECK ADD  CONSTRAINT [FK_TreatmentPlans_ToothID] FOREIGN KEY([ToothID])
REFERENCES [dbo].[ToothTreatment] ([ToothID])
GO
ALTER TABLE [dbo].[TreatmentPlans] CHECK CONSTRAINT [FK_TreatmentPlans_ToothID]
GO
USE [master]
GO
ALTER DATABASE [DentalClinic] SET  READ_WRITE 
GO
