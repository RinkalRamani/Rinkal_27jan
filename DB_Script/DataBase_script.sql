USE [master]
GO
/****** Object:  Database [practical]    Script Date: 1/27/2021 5:45:55 PM ******/
IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = N'practical')
BEGIN
CREATE DATABASE [practical]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'practical', FILENAME = N'F:\mvc\practical.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'practical_log', FILENAME = N'F:\mvc\practical_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
END
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [practical].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [practical] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [practical] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [practical] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [practical] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [practical] SET ARITHABORT OFF 
GO
ALTER DATABASE [practical] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [practical] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [practical] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [practical] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [practical] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [practical] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [practical] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [practical] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [practical] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [practical] SET  DISABLE_BROKER 
GO
ALTER DATABASE [practical] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [practical] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [practical] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [practical] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [practical] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [practical] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [practical] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [practical] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [practical] SET  MULTI_USER 
GO
ALTER DATABASE [practical] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [practical] SET DB_CHAINING OFF 
GO
ALTER DATABASE [practical] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [practical] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [practical] SET DELAYED_DURABILITY = DISABLED 
GO
USE [practical]
GO
/****** Object:  Table [dbo].[Employee]    Script Date: 1/27/2021 5:45:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Employee]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Employee](
	[Id] [int] NOT NULL,
	[Name] [nchar](50) NULL,
	[Department] [nvarchar](50) NULL,
	[DOB] [datetime] NULL
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[EmployeeSalary]    Script Date: 1/27/2021 5:45:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[EmployeeSalary]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[EmployeeSalary](
	[Id] [int] NOT NULL,
	[EmpId] [int] NULL,
	[Salary] [int] NULL,
 CONSTRAINT [PK_EmployeeSalary] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
INSERT [dbo].[Employee] ([Id], [Name], [Department], [DOB]) VALUES (4, N'tara                                              ', N'TECH SUPPORT', CAST(N'1991-12-18T00:00:00.000' AS DateTime))
INSERT [dbo].[Employee] ([Id], [Name], [Department], [DOB]) VALUES (5, N'ram                                               ', N'IT', CAST(N'1990-02-09T00:00:00.000' AS DateTime))
INSERT [dbo].[Employee] ([Id], [Name], [Department], [DOB]) VALUES (7, N'suraj                                             ', N'IT', CAST(N'1981-11-18T00:00:00.000' AS DateTime))
INSERT [dbo].[Employee] ([Id], [Name], [Department], [DOB]) VALUES (8, N'sandhya                                           ', N'MOBILE APP', CAST(N'1981-02-26T00:00:00.000' AS DateTime))
INSERT [dbo].[Employee] ([Id], [Name], [Department], [DOB]) VALUES (6, N'shiv                                              ', N'BD', CAST(N'2000-11-30T00:00:00.000' AS DateTime))
GO
INSERT [dbo].[EmployeeSalary] ([Id], [EmpId], [Salary]) VALUES (1, 4, 2000)
INSERT [dbo].[EmployeeSalary] ([Id], [EmpId], [Salary]) VALUES (2, 4, 500)
INSERT [dbo].[EmployeeSalary] ([Id], [EmpId], [Salary]) VALUES (3, 5, 600)
INSERT [dbo].[EmployeeSalary] ([Id], [EmpId], [Salary]) VALUES (4, 4, 800)
INSERT [dbo].[EmployeeSalary] ([Id], [EmpId], [Salary]) VALUES (5, 6, 900)
INSERT [dbo].[EmployeeSalary] ([Id], [EmpId], [Salary]) VALUES (6, 4, 1200)
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_EmployeeSalary_EmployeeSalary]') AND parent_object_id = OBJECT_ID(N'[dbo].[EmployeeSalary]'))
ALTER TABLE [dbo].[EmployeeSalary]  WITH CHECK ADD  CONSTRAINT [FK_EmployeeSalary_EmployeeSalary] FOREIGN KEY([Id])
REFERENCES [dbo].[EmployeeSalary] ([Id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_EmployeeSalary_EmployeeSalary]') AND parent_object_id = OBJECT_ID(N'[dbo].[EmployeeSalary]'))
ALTER TABLE [dbo].[EmployeeSalary] CHECK CONSTRAINT [FK_EmployeeSalary_EmployeeSalary]
GO
/****** Object:  StoredProcedure [dbo].[Emp_Delete]    Script Date: 1/27/2021 5:45:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Emp_Delete]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[Emp_Delete] AS' 
END
GO

 ALTER PROCEDURE [dbo].[Emp_Delete]
(
	@ID INT
)
AS
BEGIN
	DECLARE
	
	@SQLString VARCHAR(200),
	@SQLString1 VARCHAR(200)
		
		set  @SQLString = 'DELETE FROM EmployeeSalary WHERE empId ='+ CONVERT(VARCHAR, @ID)
		set  @SQLString1 = 'DELETE FROM Employee WHERE Id ='+ CONVERT(VARCHAR, @ID)
		exec(@SQLString)
		exec(@SQLString1)
	
END

GO
/****** Object:  StoredProcedure [dbo].[Emp_Get]    Script Date: 1/27/2021 5:45:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Emp_Get]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[Emp_Get] AS' 
END
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[Emp_Get]


	
AS
BEGIN
declare
 
  @sql nvarchar(500)
	set @sql = 'SELECT NAME FROM Employee '
	exec(@sql)
	
END

GO
/****** Object:  StoredProcedure [dbo].[Emp_insert]    Script Date: 1/27/2021 5:45:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Emp_insert]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[Emp_insert] AS' 
END
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[Emp_insert]

	@Name varchar(120),
	@Department varchar(120),
	@DOB varchar(20)
	
AS
BEGIN
declare
 
  @sql nvarchar(500)
	set @sql = 'insert into Employee select ISNULL(MAX(ID),0)+1,'''+@Name+''', '''+ @Department +''', CONVERT(datetime,'''+ @DOB +''') from Employee'
	exec(@sql)
	
END
GO
/****** Object:  StoredProcedure [dbo].[Emp_salary_insert]    Script Date: 1/27/2021 5:45:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Emp_salary_insert]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[Emp_salary_insert] AS' 
END
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[Emp_salary_insert]

	@ID int,
	@salary int
	
AS
BEGIN
declare
 
  @sql nvarchar(500),
  @iCount int

	--set @sql = 'select @iCount = COUNT(EMPID) FROM EMPLOYEESALARY WHERE EmpId=' +CONVERT(VARCHAR, @ID)
	--EXECUTE sp_executesql @sql, N' @iCount   int OUTPUT', @iCount  OUTPUT
	--if(@iCount > 0)
	--BEGIN
	--	set @sql = 'update EmployeeSalary set salary =' + CONVERT(VARCHAR, @salary ) + ' from EmployeeSalary where EmpId=' +CONVERT(VARCHAR, @ID)
	--END
	--ELSE
	--begin
		set @sql = 'insert into EmployeeSalary select ISNULL(MAX(ID),0)+1,' + CONVERT(VARCHAR, @ID) + ',' + CONVERT(VARCHAR, @salary ) + 'from EmployeeSalary'
	--END
	exec(@sql)
	
END
GO
/****** Object:  StoredProcedure [dbo].[Emp_Search]    Script Date: 1/27/2021 5:45:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Emp_Search]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[Emp_Search] AS' 
END
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[Emp_Search]

	@FromDate varchar(20),
	@Todate varchar(20),
	@EmployeeName varchar(100)
	
AS
BEGIN
declare
 
  @sql nvarchar(500)
	set @sql = 'SELECT EMP.ID AS ID,EMP.name AS name, emp.department AS DEPARTMENT, CONVERT(varchar,emp.dob,106) AS DOB, avg(Esal.salary) AS SALARY FROM Employee EMP
				LEFT JOIN EmployeeSalary Esal ON emp.id = Esal.empid
				where EMP.name like ''%' + @EmployeeName + '%'' or (emp.dob >= CAST(''' +@FromDate +'''AS DATETIME) and emp.dob <= CAST('''+@Todate+''' AS DATETIME))
				GROUP BY EMP.name, emp.department, emp.dob ,EMP.ID'
	EXEC(@sql)
	
END


GO
/****** Object:  StoredProcedure [dbo].[Emp_Update]    Script Date: 1/27/2021 5:45:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Emp_Update]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[Emp_Update] AS' 
END
GO


-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[Emp_Update]
	@Id int,
	@Name varchar(120),
	@Department varchar(120),
	@DOB	varchar(30)
	
AS
BEGIN
declare
 
  @sql nvarchar(500)
	set @sql = 'update Employee set 
	name= '''+@Name+''',
	department = ''' +@Department + ''',
	DOB = convert(datetime,'''+@DOB +''')
	where ID =' + CONVERT(VARCHAR, @ID )


	exec(@sql)

	
END
GO
/****** Object:  StoredProcedure [dbo].[GetEmp]    Script Date: 1/27/2021 5:45:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetEmp]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[GetEmp] AS' 
END
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[GetEmp]

	
	
AS
BEGIN
declare
 
  @sql nvarchar(500)
	set @sql = 'select Id, Name , Department, DOB, substring(CONVERT(CHAR,dob,106),3,11)  as Age from Employee '
	exec(@sql)
	
END

GO
USE [master]
GO
ALTER DATABASE [practical] SET  READ_WRITE 
GO
