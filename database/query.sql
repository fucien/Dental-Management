-- 1 - Thêm medicine

CREATE PROCEDURE AddMedicine
(
  @MedicineName NVARCHAR(90),
  @Amount INT,
  @Res INT,
  @Price INT
)
AS
BEGIN
  DECLARE @MedicineID INT;

  INSERT INTO Medicines (MedicineName, Amount, Res, Price)
  VALUES (@MedicineName, @Amount, @Res, @Price);

  SELECT @MedicineID = SCOPE_IDENTITY();

  SELECT @MedicineID AS NewMedicineID;
END;

DECLARE @NewMedicineID INT;

-- Execute the AddMedicineProcedure procedure to add a new medicine
EXEC AddMedicine
  @MedicineName = 'NewMedicine',
  @Amount = 50,
  @Res = 10,
  @Price = 1000;

-- Print the newly added MedicineID
PRINT 'New Medicine ID: ' + CAST(@NewMedicineID AS NVARCHAR(10));


-- 2 Xóa medicine
CREATE PROCEDURE DeleteMedicineProcedure
(
  @MedicineID INT
)
AS
BEGIN
  DELETE FROM Medicines
  WHERE MedicineID = @MedicineID;
END;


EXEC DeleteMedicineProcedure @MedicineID = 25;

-- 3 Update Medicine
CREATE PROCEDURE UpdateMedicineProcedure
(
  @MedicineID INT,
  @MedicineName NVARCHAR(90),
  @Amount INT,
  @Res INT,
  @Price INT
)
AS
BEGIN
  UPDATE Medicines
  SET MedicineName = @MedicineName, Amount = @Amount, Res = @Res, Price = @Price
  WHERE MedicineID = @MedicineID;
END;

-- Execute the UpdateMedicineProcedure procedure to update medicine information
-- Replace the values with the desired updates and '1' with the specific MedicineID
EXEC UpdateMedicineProcedure
  @MedicineID = 1,
  @MedicineName = 'AMPHETAMINE',
  @Amount = 1000,
  @Res = 275,
  @Price = 37000;

  -- 4
  --Update thong tin benh nhan
CREATE PROCEDURE UpdatePatientInfo
(
  @PatientID INT,
  @Name NVARCHAR(90),
  @Address NVARCHAR(90),
  @Phone NVARCHAR(11),
  @Email NVARCHAR(90),
  @DoB DATE,
  @Gender NVARCHAR(10),
  @PatientStatus NVARCHAR(90)
)
AS
BEGIN
  UPDATE Patient
  SET
    Name = @Name,
    Address = @Address,
    Phone = @Phone,
    Email = @Email,
    DoB = @DoB,
    Gender = @Gender,
    PatientStatus = @PatientStatus
  WHERE PatientID = @PatientID;
END;

EXEC UpdatePatientInfo
  @PatientID = 1,
  @Name = 'NewName',
  @Address = 'NewAddress',
  @Phone = 'NewPhone',
  @Email = 'newemail@example.com',
  @DoB = '1990-01-01',
  @Gender = 'Male',
  @PatientStatus = 'NewStatus';

  -- 5 Xem kế hoạch điều trị
  CREATE PROCEDURE ViewTreatmentPlanProcedure
(
  @PlanID INT
)
AS
BEGIN
  SELECT *
  FROM TreatmentPlans
  WHERE PlanID = @PlanID;
END;

EXEC ViewTreatmentPlanProcedure @PlanID = 1;


-- 6 Thêm kế hoạch điều trị
CREATE PROCEDURE AddTreatmentPlan
(
  @DentistID INT,
  @PatientID INT,
  @ToothID INT,
  @TreatmentDate DATE,
  @TreatmentCode NVARCHAR(90)
)
AS
BEGIN
  INSERT INTO TreatmentPlans (DentistID, PatientID, ToothID, TreatmentDate, TreatmentCode)
  VALUES (@DentistID, @PatientID, @ToothID, @TreatmentDate, @TreatmentCode);
END;

EXEC AddTreatmentPlan
  @DentistID = 1,
  @PatientID = 2,
  @ToothID = 3,
  @TreatmentDate = '2023-08-31',
  @TreatmentCode = 'KHD001';

--  7 Xem danh sách thanh toán
  SELECT * FROM Payments

-- 8 Xem các cuộc hẹn theo ngày 

 CREATE PROCEDURE ViewAppointmentsByDate
(
  @Date DATE
)
AS
BEGIN
  SELECT *
  FROM Appointments
  WHERE [Date] = @Date;
END;

EXEC ViewAppointmentsByDate @Date = '2023-09-08';

-- 9 Hủy yêu cầu cuộc hẹn của bệnh nhân
	UPDATE dbo.AppointmentRequests
	SET Note = 'Đã hủy'
	WHERE PatientID = '1'

-- 10 Xem danh sách nha sĩ
    SELECT * FROM Dentist

-- 11 Xem thông tin của 1 nha sĩ
	SELECT * FROM dbo.Dentist
	WHERE DentistID = '1'

  -- 12 Thêm thông tin một nha sĩ mới
    INSERT INTO Dentist (Name, Address, Phone, Email, AccID)
	VALUES (N'Nhân từ',N'12 Nguyễn Văn Trỗi','0932422123','lmao@gmail.com','233')
	
  -- 13 Lọc các cuộc hẹn của nha sĩ từ ngày x đến ngày y
  go 
create proc GenerateAppointmentReport @DentistID int, @FromDate date, @ToDate date
as 
begin
    select *
    from Appointments a 
    where (a.[Date] BETWEEN @FromDate AND @ToDate) AND a.DentistID = @DentistID
    order by a.[Date];
end;

EXEC GenerateAppointmentReport @DentistID = 1, @FromDate = '2023-01-01', @ToDate = '2023-12-31';

-- 14 thống kê theo ngày của 1 nha sĩ
go 
create proc GetTreatmentStatsByDentistAndDate @DentistID int, @Date date
as 
begin
    select t.*
    from TreatmentPlans t
    where t.DentistID = @DentistID and t.TreatmentDate = @Date
    order by t.TreatmentDate;
end;

EXEC GetTreatmentStatsByDentistAndDate 31, '2023-8-31';

-- 15 Xem lịch trình nha sĩ
SELECT *
    FROM Schedules
    WHERE DentistID = '1'

-- 16 Thêm lịch làm việc cho nha sĩ

Insert into Schedules values (1,1,'Monday', '2023-08-27', '2023-08-27');

-- 17 Loc cuoc hen theo benh nhan
SELECT distinct a.AppointmentID
FROM Appointments a
WHERE a.PatientID = 559

-- 18 Loc cuoc hen theo phong kham
SELECT distinct a.AppointmentID
FROM Appointments a
WHERE a.RoomID = 59

-- 19 Loc cuoc hen theo nha si
SELECT distinct a.AppointmentID
FROM Appointments a
WHERE a.DentistID = 978
