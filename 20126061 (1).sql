--Q58
SELECT DISTINCT g.HOTEN
FROM GIAOVIEN g, THAMGIADT t
WHERE g.MAGV = t.MAGV
GROUP BY g.HOTEN
HAVING COUNT(distinct t.MADT) = (SELECT COUNT(distinct MADT)
								 FROM DETAI)
--Q59
SELECT DISTINCT t.MADT
FROM GIAOVIEN g, THAMGIADT t
WHERE g.MAGV = t.MAGV and g.MABM = 'HTTT'
GROUP BY t.MADT
HAVING COUNT(distinct t.MAGV) = (SELECT COUNT(distinct g.MAGV)
						FROM GIAOVIEN g
						WHERE g.MABM = 'HTTT')
--Q60
SELECT DISTINCT t.MADT
FROM GIAOVIEN g, THAMGIADT t, BOMON b
WHERE g.MAGV = t.MAGV and g.MABM = b.MABM and b.TENBM = N'H? th?ng th�ng tin'
GROUP BY t.MADT
HAVING COUNT(distinct t.MAGV) = (SELECT COUNT(distinct g.MAGV)
						FROM GIAOVIEN g, BOMON b
						WHERE g.MABM = b.MABM and b.TENBM = N'H? th?ng th�ng tin')
--Q61
SELECT DISTINCT g.HOTEN
FROM GIAOVIEN g, THAMGIADT t, DETAI d
WHERE g.MAGV = t.MAGV and t.MADT = d.MADT and d.MACD = 'QLGD'
GROUP BY g.HOTEN
HAVING COUNT(distinct d.MADT) = (SELECT COUNT(distinct MADT)
								 FROM DETAI
								 WHERE MACD = 'QLGD')
--Q62
SELECT DISTINCT g1.HOTEN
FROM GIAOVIEN g1, THAMGIADT t1, GIAOVIEN g2, THAMGIADT t2
WHERE g1.MAGV = t1.MAGV and g1.MAGV != g2.MAGV and g2.HOTEN = N'Tr?n Tr� Huong' and g2.MAGV = t2.MAGV and t1.MADT = t2.MADT
GROUP BY g1.HOTEN
HAVING COUNT(distinct t1.MADT) = (SELECT COUNT(distinct t.MADT)
								  FROM GIAOVIEN g, THAMGIADT t
								  WHERE  g.HOTEN = N'Tr?n Tr� Huong' and g.MAGV = t.MAGV)
--Q63
SELECT DISTINCT d.TENDT
FROM GIAOVIEN g, THAMGIADT t, BOMON b, DETAI d
WHERE g.MAGV = t.MAGV and g.MABM = b.MABM and b.TENBM = N'H�a h?u co' and t.MADT = d.MADT
GROUP BY d.TENDT
HAVING COUNT(distinct t.MAGV) = (SELECT COUNT(distinct g.MAGV)
						FROM GIAOVIEN g, BOMON b
						WHERE g.MABM = b.MABM and b.TENBM = N'H�a h?u co')
--Q64
SELECT DISTINCT g.HOTEN
FROM GIAOVIEN g, THAMGIADT t, CONGVIEC c
WHERE g.MAGV = t.MAGV and t.MADT = c.MADT and t.STT = c.SOTT and c.MADT = '006'
GROUP BY g.HOTEN
HAVING COUNT(c.SOTT) = (SELECT COUNT(SOTT)
						FROM CONGVIEC
						WHERE MADT = '006')
--Q65
SELECT DISTINCT g.HOTEN
FROM GIAOVIEN g, THAMGIADT t, DETAI d, CHUDE c
WHERE g.MAGV = t.MAGV and t.MADT = d.MADT and d.MACD = c.MACD and c.TENCD = N'?ng d?ng c�ng ngh?'
GROUP BY g.HOTEN
HAVING COUNT(distinct d.MADT) = (SELECT COUNT(distinct MADT)
								 FROM DETAI d, CHUDE c
								 WHERE d.MACD = c.MACD and c.TENCD = N'?ng d?ng c�ng ngh?')
--Q66
SELECT DISTINCT g1.HOTEN
FROM GIAOVIEN g1, THAMGIADT t, GIAOVIEN g2, DETAI d
WHERE g1.MAGV = t.MAGV and g2.HOTEN = N'Tr?n Tr� Huong' and t.MADT = d.MADT and d.GVCNDT = g2.MAGV
GROUP BY g1.HOTEN
HAVING COUNT(distinct t.MADT) = (SELECT COUNT(distinct d.MADT)
								 FROM GIAOVIEN g, DETAI d
								 WHERE  g.HOTEN = N'Tr?n Tr� Huong' and g.MAGV = d.GVCNDT)
--Q67
SELECT DISTINCT d.TENDT
FROM GIAOVIEN g, THAMGIADT t, BOMON b, DETAI d
WHERE g.MAGV = t.MAGV and g.MABM = b.MABM and b.MAKHOA = 'CNTT' and t.MADT = d.MADT
GROUP BY d.TENDT
HAVING COUNT(distinct t.MAGV) = (SELECT COUNT(distinct g.MAGV)
						FROM GIAOVIEN g, BOMON b
						WHERE g.MABM = b.MABM and b.MAKHOA = 'CNTT')
--Q45
SELECT DISTINCT g.*
FROM GIAOVIEN g
WHERE NOT EXISTS(SELECT *
				 FROM THAMGIADT t
				 WHERE g.MAGV = t.MAGV)
--Q46
SELECT DISTINCT g.*
FROM GIAOVIEN g
WHERE g.LUONG > (SELECT LUONG
				 FROM GIAOVIEN
				 WHERE HOTEN = N'Nguy?n Ho�i An')
--Q47
SELECT DISTINCT g.*
FROM GIAOVIEN g, BOMON b
WHERE b.TRUONGBM = g.MAGV
	AND EXISTS(SELECT *
			   FROM THAMGIADT t
			   WHERE g.MAGV = t.MAGV)
--Q48
SELECT DISTINCT g1.HOTEN
FROM GIAOVIEN g1, GIAOVIEN g2
WHERE g1.HOTEN = g2.HOTEN AND g1.PHAI = g2.PHAI AND g1.MABM = g2.MABM AND g1.MAGV != g2.MAGV

--Q49
SELECT DISTINCT g.HOTEN
FROM GIAOVIEN g
WHERE EXISTS(SELECT *
			 FROM GIAOVIEN g1, BOMON b
			 WHERE g1.MABM = b.MABM AND b.TENBM = N'C�ng ngh? ph?n m?m' AND g.LUONG > g1.LUONG)
--Q50
SELECT DISTINCT g.HOTEN
FROM GIAOVIEN g
WHERE g.LUONG > ALL(SELECT MAX(g1.LUONG)
					 FROM GIAOVIEN g1, BOMON b
					 WHERE g1.MABM = b.MABM AND b.TENBM = N'H? th?ng th�ng tin')
--Q51
SELECT k.TENKHOA
FROM GIAOVIEN g, KHOA k, BOMON b
WHERE g.MABM = b.MABM AND b.MAKHOA = k.MAKHOA
GROUP BY k.MAKHOA, k.TENKHOA
HAVING COUNT(g.MAGV) >= ALL(SELECT COUNT(g.MAGV)
							FROM GIAOVIEN g, KHOA k, BOMON b
							WHERE g.MABM = b.MABM AND b.MAKHOA = k.MAKHOA
							GROUP BY k.MAKHOA) 
--Q52
SELECT g.HOTEN
FROM GIAOVIEN g, DETAI d
WHERE g.MAGV = d.GVCNDT
GROUP BY g.MAGV, g.HOTEN
HAVING COUNT(*) >= ALL(SELECT COUNT(*)
					   FROM GIAOVIEN g, DETAI d
					   WHERE g.MAGV = d.GVCNDT
					   GROUP BY g.MAGV)
--Q53
SELECT MABM
FROM GIAOVIEN
GROUP BY MABM
HAVING COUNT(*) >= ALL(SELECT COUNT(*)
					   FROM GIAOVIEN
					   GROUP BY MABM)
--Q54
SELECT g.HOTEN, b.TENBM
FROM GIAOVIEN g, THAMGIADT t, BOMON b
WHERE g.MAGV = t.MAGV AND g.MABM = b.MABM
GROUP BY g.HOTEN, b.TENBM
HAVING COUNT(*) >= ALL(SELECT COUNT(*)
					   FROM GIAOVIEN g, THAMGIADT t
					   WHERE g.MAGV = t.MAGV
                       GROUP BY g.HOTEN)
--Q55
SELECT g.HOTEN
FROM GIAOVIEN g, THAMGIADT t
WHERE g.MAGV = t.MAGV AND g.MABM = 'HTTT'
GROUP BY g.HOTEN
HAVING COUNT(*) >= ALL(SELECT COUNT(*)
					   FROM GIAOVIEN g, THAMGIADT t
					   WHERE g.MAGV = t.MAGV AND g.MABM = 'HTTT'
                       GROUP BY g.HOTEN)
--Q56
SELECT g.HOTEN
FROM GIAOVIEN g, NGUOITHAN n, BOMON b
WHERE g.MAGV = n.MAGV AND g.MABM = b.MABM
GROUP BY g.HOTEN
HAVING COUNT(*) >= ALL(SELECT COUNT(*)
					   FROM GIAOVIEN g, NGUOITHAN n, BOMON b
					   WHERE g.MAGV = n.MAGV AND g.MABM = b.MABM
                       GROUP BY g.HOTEN)
--Q57
SELECT g.HOTEN
FROM GIAOVIEN g, DETAI d, BOMON b
WHERE g.MAGV = b.TRUONGBM AND g.MAGV = d.GVCNDT
GROUP BY g.HOTEN
HAVING COUNT(*) >= ALL(SELECT COUNT(*)
					   FROM GIAOVIEN g, DETAI d, BOMON b
					   WHERE g.MAGV = b.TRUONGBM AND g.MAGV = d.GVCNDT
					   GROUP BY g.HOTEN)