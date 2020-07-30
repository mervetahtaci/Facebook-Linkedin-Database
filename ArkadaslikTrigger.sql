use HOMv17

DROP TRIGGER KarsilikliArkadaslik

CREATE TRIGGER KarsilikliArkadaslik
ON Arkadaslar
AFTER INSERT
AS

DECLARE @k_id INT, @ar_id INT

SELECT @k_id = kullanici_id, @ar_id = arkadas_id FROM INSERTED


BEGIN
insert into Arkadaslar(kullanici_id, arkadas_id) values (@ar_id,@k_id)
END

-----------------------------------

insert into Arkadaslar(kullanici_id, arkadas_id) values (6,7)

