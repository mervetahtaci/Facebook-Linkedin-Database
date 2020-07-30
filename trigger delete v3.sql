DROP TRIGGER DilSilme
DROP TRIGGER Kullan�lanDilSilme

-----------------------------------


CREATE TRIGGER DilSilme
ON Dil
INSTEAD OF DELETE 
AS

DECLARE @dil_id int, @dil_adi varchar(15)

SELECT @dil_id=dil_id, @dil_adi=dil_adi FROM DELETED 

BEGIN 
DELETE FROM Kullan�lan_Dil WHERE dil_id=@dil_id
DELETE FROM Dil WHERE dil_id=@dil_id 
END 



CREATE TRIGGER Kullan�lanDilSilme
ON Kullan�lan_Dil
INSTEAD OF DELETE 
AS 

DECLARE @dil_id int, @kullanici_id int 
SELECT @dil_id=dil_id, @kullanici_id=kullanici_id  FROM DELETED 
BEGIN 
DELETE FROM Kullan�lan_Dil WHERE dil_id=@dil_id
END 

------------------------------------


DELETE FROM Dil
WHERE dil_id=5



-----------------------------------

SELECT * 
FROM Dil


SELECT *
FROM Kullan�lan_Dil

--------------------------------------

insert into Dil(dil_id, dil_adi) values (3, '�ngilizce')