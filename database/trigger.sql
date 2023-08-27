--Trigger để tự động thêm payment mỗi khi thêm prescriptions cho bệnh nhân
CREATE TRIGGER trgPrescriptionUpdateMedicine
ON dbo.Prescriptions
AFTER INSERT
AS
BEGIN
    DECLARE @PrescriptionID INT, @MedicineID INT, @Amount INT, @Price INT, @Patient INT;

	SELECT @Patient = t.PatientID
	FROM dbo.TreatmentPlans t, inserted i
	WHERE t.PlanID = i.PlanID

    SELECT @PrescriptionID = i.PrescriptionID,
           @MedicineID = i.MedicineID,
           @Amount = i.Amount,
           @Price = m.Price
    FROM inserted i
    INNER JOIN Medicines m ON i.MedicineID = m.MedicineID;

    -- Tính số thuốc còn lại
    UPDATE Medicines
    SET Res = Res - @Amount
    WHERE MedicineID = @MedicineID;

    -- Thêm một payment
    INSERT INTO Payments (PrescriptionID, PatientID, PaymentDate, Total, AmountPaid, TypeOfPayment, Note)
    VALUES (@PrescriptionID, @Patient, GETDATE(), @Price * @Amount, 0, 'Chưa trả', 'Payment pending');

    -- Commit the transaction
    COMMIT;
END;
GO

--Trigger để tự động thêm account mỗi khi thêm nha sĩ

CREATE TRIGGER trgAddAccount
ON Dentist
AFTER INSERT   
AS
BEGIN
    Declare @DentistID INT, @DentistName VARCHAR(90), @DentistEmail VARCHAR(90), @DentistPhone VARCHAR(11), @DentistAddress VARCHAR(90), @DentistAccID INT;
    SELECT @DentistID = DentistID, @DentistName = Name, @DentistEmail = Email, @DentistPhone = Phone, @DentistAddress = Address FROM inserted;
    INSERT INTO Account (AccName, Password, Role) VALUES (@DentistName, '123456', 'Dentist');
    SELECT @DentistAccID = AccID FROM Account WHERE AccName = @DentistName;
    UPDATE Dentist SET AccID = @DentistAccID WHERE DentistID = @DentistID;
END;
GO
--Trigger khi xóa một yêu cầu hẹn phải kiểm tra cuộc hẹn đó có được chấp nhận chưa trước
CREATE TRIGGER trgDeleteAppointmentRequest
ON AppointmentRequests
for DELETE
AS
BEGIN
    DECLARE @RequestID INT, @DentistID INT, @PatientID INT, @RequestDate DATE, @Note VARCHAR(255);
    SELECT @RequestID = RequestID, @DentistID = DentistID, @PatientID = PatientID, @RequestDate = RequestDate, @Note = Note FROM deleted;
    IF EXISTS (SELECT * FROM Appointments WHERE RequestID = @RequestID)
    BEGIN
        RAISERROR('Không thể xóa yêu cầu hẹn này vì đã có cuộc hẹn được tạo từ yêu cầu này', 16, 1);
        ROLLBACK;
    END;
END;

GO
-- Trigger để tự động thêm account mỗi khi thêm nhân viên với mật khẩu mặc định là 123456
CREATE TRIGGER trgAddAccountStaff
ON dbo.Staff
AFTER INSERT
AS
BEGIN
    Declare @StaffID INT, @StaffName VARCHAR(90), @StaffEmail VARCHAR(90), @StaffPhone VARCHAR(11), @StaffAddress VARCHAR(90), @StaffAccID INT;
    SELECT @StaffID = StaffID, @StaffName = Name, @StaffEmail = Email, @StaffPhone = Phone, @StaffAddress = Address FROM inserted;
    INSERT INTO Account (AccName, Password, Role) VALUES (@StaffName, '123456', 'Staff');
    SELECT @StaffAccID = AccID FROM Account WHERE AccName = @StaffName;
    UPDATE Staff SET AccID = @StaffAccID WHERE StaffID = @StaffID;
END;
GO

--Trigger để kiểm tra phòng có trống không khi thêm appointment
CREATE TRIGGER trgCheckRoom
ON dbo.Appointments
AFTER INSERT
AS
BEGIN
    DECLARE @Room INT, @Date DATE;
    SELECT @Room = RoomID, @Date = Date FROM inserted;
    IF EXISTS (SELECT * FROM Appointments WHERE RoomID = @Room AND Date = @Date)
    BEGIN
        RAISERROR('Phòng này đã được đặt ', 16, 1);
        ROLLBACK;
    END;
END;
go
-- Trigger để kiểm tra nha sĩ có bị trùng lịch khi thêm appointment
CREATE TRIGGER trgCheckDentistWork
ON dbo.Appointments
AFTER INSERT
AS
BEGIN
    DECLARE @DentistID INT, @Date DATE;
    SELECT @DentistID = DentistID, @Date = Date FROM inserted;
    IF EXISTS (SELECT * FROM Appointments WHERE DentistID = @DentistID AND Date = @Date)
    BEGIN
        RAISERROR('Nha sĩ này đã có lịch làm việc trong ngày này', 16, 1);
        ROLLBACK;
    END;
END;
GO

-- Trigger để tự động sửa treatment code thành "đã hoàn thành" sau khi thêm prescription
CREATE TRIGGER trgUpdateTreatmentCode
ON dbo.Prescriptions
AFTER INSERT
AS
BEGIN
    DECLARE @PlanID INT, @DentistID INT,  @TreatmentCode VARCHAR(10);
    SELECT @PlanID = PlanID, @DentistID = DentistID FROM inserted;
    SELECT @TreatmentCode = TreatmentCode FROM TreatmentPlans WHERE PlanID = @PlanID AND DentistID = @DentistID;
    IF @TreatmentCode = 'Kế hoạch'
    BEGIN
        UPDATE TreatmentPlans SET TreatmentCode = 'Đã hoàn thành' WHERE PlanID = @PlanID AND DentistID = @DentistID;
    END;
END;

