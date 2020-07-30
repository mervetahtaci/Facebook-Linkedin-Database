use HOMv18 

/* Selam mesajý alanlardan C# yetenði olanlarýn adýný mailini ve okulunu listele */
SELECT kl.kullanici_isim,kl.e_mail,ok.okul_adi
FROM Kullanici AS kl, Mesaj AS msj, Yetenek AS yet, Kullanici_yetenek AS kulyet, Egitim AS eg, Okul AS ok
WHERE msj.icerik = 'Selam' AND msj.kullanici_id = kl.kullanici_id AND kl.kullanici_id = kulyet.kullanici_id AND kulyet.yetenek_id =yet.yetenek_id
AND yet.yetenek_adi = 'C#' AND kl.kullanici_id = eg.kullanici_id AND eg.okul_id = ok.okul_id

/* Selam mesajý alanlardan C# yeteneði olanlarýn adýný mailini ve okulunu listele  kendi sorgum*/

SELECT k.kullanici_isim, k.e_mail, o.okul_adi
FROM	Kullanici as k, Okul as o, Mesaj as m, Yetenek as y, Kullanici_yetenek as ky, Egitim as e
WHERE m.icerik = 'Selam' AND m.kullanici_id=k.kullanici_id AND y.yetenek_adi='C#' AND y.yetenek_id=ky.yetenek_id AND ky.kullanici_id=k.kullanici_id 
AND e.okul_id=o.okul_id AND e.kullanici_id=k.kullanici_id 







/*  Hasanýn Merve isimli arkadaþýnýn üye olduðu topluluklarý göster */

SELECT topluluk_adi, aciklama
FROM Topluluk 
WHERE topluluk_id = (
	SELECT topluluk_id
	FROM Topluluk_Uyeleri
	WHERE kullanici_id = (
		SELECT kullanici_id
		FROM Kullanici
		WHERE kullanici_isim LIKE '%Merve%' AND kullanici_id IN (
			SELECT kullanici_id
			FROM Arkadaslar
			WHERE arkadas_id = (
				SELECT kullanici_id
				FROM Kullanici
				WHERE kullanici_isim LIKE '%Hasan%'
			)
		)
	)
)

																			
																									
	/* Ozum ve Hasan ýn ortak arkadaþlarýndan  'aktas367@hotmail.com' mail adresine sahip kiþinin odtüde okuyan arkadaþlarýnýn mail adresleri nelerdir */																						
SELECT k3.e_mail
FROm Kullanici AS k3, Arkadaslar AS a3, Okul AS o, Egitim AS e 
WHERE k3.kullanici_id = e.kullanici_id AND e.okul_id = o.okul_id AND o.okul_adi = 'ODTÜ' AND k3.kullanici_id = a3.arkadas_id AND a3.kullanici_id IN (SELECT k.kullanici_id 
FROM Kullanici AS k, Arkadaslar AS a, Kullanici AS k2, Arkadaslar AS a2
WHERE k2.kullanici_isim LIKE '%Ozum%' AND k2.kullanici_id = a2.kullanici_id AND a.arkadas_id = a2.arkadas_id AND k.e_mail = 'aktas367@hotmail.com' AND a.arkadas_id = k.kullanici_id AND a.kullanici_id IN (SELECT kullanici_id
																									FROM Kullanici
																									WHERE kullanici_isim LIKE '%Hasan%'))																							


-----------------------------------------------------

/*Merve Tahtacýnýn etiketlendiði fotoðraflar*/ 
SELECT fotograf_id
FROM Foto_tag
Where etiketlenen_kisi IN (SELECT kullanici_id
						   FROM Kullanici
						   WHERE kullanici_isim = 'Merve Tahtacý')

/*Merve Tahtacýnýn etiketlendiði fotoðraflar*/ 
SELECT k.kullanici_isim AS Foto_sahibi, f.fotograf_id
FROM Fotograf_album AS fa, Fotograf AS f, Kullanici AS k
WHERE k.kullanici_id= fa.kullanici_id AND f.fotograf_album_id = fa.fotograf_album_id AND f.fotograf_id IN (SELECT fotograf_id
						FROM Foto_tag
						Where etiketlenen_kisi IN (SELECT kullanici_id
						   FROM Kullanici
						   WHERE kullanici_isim = 'Merve Tahtacý'))





		
/*Birden fazla fotoðraf albümü olan kiþilerin isimlerini listele -- GROUP BY VE SELECT AYNI OLMALI ?? */						   
SELECT Kullanici.kullanici_isim AS Kullanýcýlar, COUNT(*) AS SAYI
FROM  Kullanici, Fotograf_album
WHERE Kullanici.kullanici_id=Fotograf_album.kullanici_id
GROUP BY Kullanici.kullanici_isim
HAVING COUNT(*)>=2;


/*Birden fazla fotoðraf albümü olan kiþilerin isimlerini listele -- HATA VERÝYÜR */						   
SELECT Kullanici.kullanici_isim AS Kullanýcýlar
FROM Kullanici, Fotograf_album
WHERE Kullanici.kullanici_id=Fotograf_album.kullanici_id
GROUP BY Kullanici.kullanici_isim
HAVING COUNT(Fotograf_album.kullanici_id)>=2



SELECT Kullanici.kullanici_isim, COUNT(*) AS SAYI
FROM  Kullanici, Fotograf_album
WHERE Kullanici.kullanici_id=Fotograf_album.kullanici_id
GROUP BY Kullanici.kullanici_isim 
HAVING COUNT(*) >= 2 
ORDER BY Kullanici.kullanici_isim DESC


/* Profil bilgisinde iliþki durumu evli ve hakkýnda kýsmýnda Ýstanbul geçen kullanýcýlarý alfabetik listeleyin. */

SELECT kullanici_isim AS Profil, about_me AS Hakkýnda, iliski AS Ýliþki 
FROM Kullanici, Profil
WHERE Kullanici.kullanici_id= Profil.kullanici_id and iliski='Evli' and about_me LIKE '%Ýstanbul%'
ORDER BY about_me ASC


/* Postu olan kullanýcýlarýn isimlerini listele */
	select k.kullanici_isim AS Postlu_Kullanýcýlar
	from Kullanici as k inner join Post as p on k.kullanici_id = p.kullanici_id 


/* Postu olan kullanýcýlarýn isimlerini listele-EXISTS ÝLE */
	select kullanici_isim AS Postlu_Kullanýcýlar
	from Kullanici as k
	where exists ( select *
						from Post as p
						where k.kullanici_id = p.kullanici_id)


/*Postu olan kullanýcýlarýn id'Si*/
	SELECT DISTINCT kullanici_id 
	FROM Post


/*Herhangi bir postu olmayan kullanýcýlarý listele*/
	SELECT kullanici_isim AS Postlu_Kullanýcýlar
	FROM Kullanici as k
	WHERE not exists ( SELECT *
					   FROM Post as p
					   WHERE k.kullanici_id = p.kullanici_id)


/*Mustafa Ege Oral'ýn paylaþtýðý postlarý beðenen kiþileri ve sayýsýný göster.*/ /*KÝÞÝLERÝN ÝSÝMLERÝNÝ GÖSTEREMEDÝM!!!!!!!!!!!!!*/

        SELECT DISTINCT post_id as PostID, begenen_kisi_id as BegenenID, Kullanici.kullanici_isim AS Beðenen_Kullanýcý
            FROM Post_begeni as P, Kullanici
            WHERE P.begenen_kisi_id=Kullanici.kullanici_id  AND P.post_id IN  ( SELECT post_id
                                                                                FROM Kullanici, Post
                                                                                WHERE Kullanici.kullanici_isim='Mustafa Ege Oral' AND Post.kullanici_id=Kullanici.kullanici_id)


/*Hasan Erfenek'e gelen mesajlarda 'Selam' kelimesini içeren konuþmalar yaptýðý kiþilerin bilgilerini listeleyiniz.*/
SELECT kullanici_id AS KullanýcýID, kullanici_isim AS Mesaj_Gönderen
FROM Kullanici
WHERE kullanici_id= (SELECT Mesaj.kimden_id
                     FROM Kullanici, Mesaj
			         WHERE icerik LIKE '%Selam%' AND Kullanici.kullanici_isim='Hasan Erfenek' AND Kullanici.kullanici_id= Mesaj.kullanici_id)


/*Tiyatro videosuna sahip kiþilerin kimler olduðunu ve kullandýklarý dili listeleyin.*/


SELECT Kullanici.kullanici_isim AS Kullanýcýlar, dil_adi AS Kullandýklarý_Dil, video_adi AS Video
FROM Kullanici, Dil, Video, Kullanýlan_Dil
WHERE  video_adi LIKE '%Tiyatro%' AND Video.kullanici_id=Kullanici.kullanici_id AND Kullanýlan_Dil.kullanici_id=Kullanici.kullanici_id AND Kullanýlan_Dil.dil_id=Dil.dil_id




/*Hasan Erfenek'in arkadaþlarýnýn etkinlik bilgisini göster. */
select Etkinlik_bilgisi.etkinlik as Etkinlik, Kullanici.kullanici_isim AS Hasanýn_Arkadaþlarý
from Etkinlik_bilgisi, Kullanici
where Kullanici.kullanici_id=Etkinlik_bilgisi.kullanici_id AND  Kullanici.kullanici_id IN (SELECT Arkadaslar.arkadas_id 
                                                                                          FROM Kullanici, Arkadaslar 
																						  WHERE Kullanici.kullanici_isim='Hasan Erfenek' AND Kullanici.kullanici_id=Arkadaslar.kullanici_id )



/*Mustafa Ege Oral'ýn paylaþtýðý postlarý beðenen kiþileri ve sayýsýný göster.*/ 

            SELECT DISTINCT post_id as PostID, begenen_kisi_id as BegenenID, Kullanici.kullanici_isim AS Beðenen_Kullanýcý
            FROM Post_begeni as P, Kullanici
            WHERE P.begenen_kisi_id=Kullanici.kullanici_id  AND P.post_id IN  ( SELECT post_id
                                                                                FROM Kullanici, Post
                                                                                WHERE Kullanici.kullanici_isim='Mustafa Ege Oral' AND Post.kullanici_id=Kullanici.kullanici_id)



DROP TRIGGER DilSilme
DROP TRIGGER KullanýlanDilSilme

-----------------------------------


CREATE TRIGGER DilSilme
ON Dil
INSTEAD OF DELETE 
AS

DECLARE @dil_id int, @dil_adi varchar(15)

SELECT @dil_id=dil_id, @dil_adi=dil_adi FROM DELETED 

BEGIN 
DELETE FROM Kullanýlan_Dil WHERE dil_id=@dil_id
DELETE FROM Dil WHERE dil_id=@dil_id 
END 



CREATE TRIGGER KullanýlanDilSilme
ON Kullanýlan_Dil
INSTEAD OF DELETE 
AS 

DECLARE @dil_id int, @kullanici_id int 
SELECT @dil_id=dil_id, @kullanici_id=kullanici_id  FROM DELETED 
BEGIN 
DELETE FROM Kullanýlan_Dil WHERE dil_id=@dil_id
END 

------------------------------------


DELETE FROM Dil
WHERE dil_id=5



-----------------------------------

SELECT * 
FROM Dil


SELECT *
FROM Kullanýlan_Dil

--------------------------------------

insert into Dil(dil_id, dil_adi) values (3, 'Ýngilizce')




/*Posttaki beðeni sayýsý 0'a eþit büyük olabilir.*/																			
ALTER TABLE Post
Add Constraint p_begeni 
Check (begeni_sayisi>=0)

------------------------------------------------------------------------------------------------

/* 'Yeni iþ pozisyonunu tebrik ederim!' mesajýný alan kullanýcýlardan Java deneyimi olanlarýn isim,mail ve okul adlarýný yaz.*/
select kullanici_isim,e_mail,okul_adi
from Kullanici,Okul,Kullanici_yetenek,Mesaj,Yetenek,Egitim
where Kullanici_yetenek.yetenek_id = Yetenek.yetenek_id and Yetenek.yetenek_adi='Java'
and Kullanici_yetenek.kullanici_id=Kullanici.kullanici_id
and Kullanici.kullanici_id=Mesaj.kullanici_id and Mesaj.icerik='Yeni iþ pozisyonunu tebrik ederim!'
and Egitim.kullanici_id = Kullanici.kullanici_id
and Egitim.egitim_id=Okul.okul_id

select kullanici_isim,e_mail,okul_adi
from Kullanici,Okul,Yetenek,Kullanici_yetenek,Egitim
where Kullanici.kullanici_id=Kullanici_yetenek.kullanici_id 
and Kullanici_yetenek.kullanici_id=Yetenek.kullanici_id 
and Yetenek.yetenek_adi ='Java' 
and Kullanici.kullanici_id=Egitim.kullanici_id and Egitim.okul_id=Okul.okul_id and Kullanici.kullanici_id in(

							select Kullanici.kullanici_id
							from Kullanici,Mesaj
							where Mesaj.icerik='Yeni iþ pozisyonunu tebrik ederim!' and Mesaj.kullanici_id=Kullanici.kullanici_id )

/* IEEE üyesi olan Bursa lokasyonundaki bir þirkette çalýþmýþ insanlarýn isimleri ve ilgi alanlarýný göster */
select Kullanici.kullanici_isim,Okul.okul_adi,Company.company_name
from Kullanici,Okul,Company,Topluluk,Topluluk_Uyeleri,Deneyim,Ilgi_Alani
where Kullanici.kullanici_id= Topluluk_Uyeleri.kullanici_id and Topluluk_Uyeleri.topluluk_id=Topluluk.topluluk_id and Topluluk.topluluk_adi='IEEE'
and Kullanici.kullanici_id=Deneyim.kullanici_id and Deneyim.company_id=Company.company_id and Company.lokasyon='Bursa'
and Kullanici.kullanici_id=Ilgi_Alani.kullanici_id  and Ilgi_Alani.okul_id =Okul.okul_id

/* IEEE üyesi olan Bursa lokasyonundaki bir þirkette çalýþmýþ insanlarýn isimleri ve ilgi alanlarýný göster */
SELECT Kullanici.kullanici_isim, Ilgi_Alani.ilgialani_id
FROM Kullanici,Ilgi_Alani, Topluluk as T, Topluluk_Uyeleri as T1, Deneyim, Company
WHERE T.topluluk_id=T1.topluluk_id AND T.topluluk_adi='IEEE' AND T1.kullanici_id=Kullanici.kullanici_id 
AND Kullanici.kullanici_id=Deneyim.kullanici_id AND Company.lokasyon='Bursa' AND 
Deneyim.company_id=Company.company_id  AND Kullanici.kullanici_id=Ilgi_Alani.kullanici_id

/* Postunda 'mühendisler gününüz kutlu olsun!' yazan birinin paylaþtýðý fotoðraflarý göster.*/
select Fotograf.fotograf_id
from Fotograf,Fotograf_album,Post,Kullanici
where Kullanici.kullanici_id=Post.kullanici_id and Post.post_icerik='mühendisler gününüz kutlu olsun!'
and Kullanici.kullanici_id=Fotograf_album.kullanici_id and Fotograf_album.fotograf_album_id=Fotograf.fotograf_album_id

/* Botart þirketinin verdiði iþ ilanlarýný listele.*/
select baslik
from Is_Ilani,Company
where Is_Ilani.company_id=Company.company_id and Company.company_name='Botart'

/*Herhangi bir topluluða üye olmayan kiþilerin isimlerini listele.*/
select kullanici_isim
from Kullanici
where not exists (select * from Topluluk_Uyeleri  where Topluluk_Uyeleri.kullanici_id=Kullanici.kullanici_id)

/* Takipçi sayisi 100den fazla olan þirketleri lokasyonuna göre grupla.*/ 
select lokasyon
from Company
where takipci_sayisi>100
group by lokasyon


/*Okul tablosundaki kayýtlarý takipçi sayýsýna göre artan sýrada sýrala.*/
select *
from Okul
order by takipci_sayisi asc

/* Profilinde hakkýnda kýsmýnda a harfi bulunanlarý listele.*/
select kullanici_isim,about_me
from Profil,Kullanici
where Kullanici.kullanici_id=Profil.kullanici_id 
and Profil.about_me like '%a%'

/* Ýþ ilanlarýnda istenen yetenek sayýlarýný çoktan aza listele.*/
select count(Yetenek.yetenek_id)
from Yetenek,Is_Ilani,Is_Ilani_Yetenek
where  Is_Ilani.ilan_id=Is_Ilani_Yetenek.ilan_id and Is_Ilani_Yetenek.yetenek_id=Yetenek.yetenek_id 
order by count(Yetenek.yetenek_id) desc

/* Mervenin Hasan isimli arkadaþýnýn üye olduðu topluluklarý listele.*/
select topluluk_adi, aciklama
from Topluluk 
where topluluk_id in (
	select topluluk_id
	from Topluluk_Uyeleri
	where kullanici_id = (
		select kullanici_id
		from Kullanici
		where kullanici_isim like '%Merve%' and kullanici_id = (
			select kullanici_id
			from Connections
			where arkadas_id = (
				select kullanici_id
				from Kullanici
				where kullanici_isim like '%Hasan%'
			)
		)
	)
)
/* Mervenin Hasan isimli arkadaþýnýn üye olduðu topluluklarý listele.*/

select topluluk_adi,aciklama
from Topluluk as t ,Topluluk_Uyeleri as t1,Kullanici as k, Kullanici as k1,Connections as c
where k.kullanici_isim LIKE '%Merve%'AND k.kullanici_id=c.kullanici_id
 AND c.arkadas_id=k1.kullanici_id AND k1.kullanici_isim LIKE '%Hasan%'
 AND k.kullanici_id=t1.kullanici_id and t.topluluk_id=t1.topluluk_id
 


/* 'Merve Tahtaci'nin üye olduðu topluluklarýn adýný listele.*/
select topluluk_adi
from Topluluk 
where topluluk_id in ( select topluluk_id
					   from Topluluk_Uyeleri,Kullanici
					   where Topluluk_Uyeleri.kullanici_id=Kullanici.kullanici_id and Kullanici.kullanici_isim='Merve Tahtaci' )

/* Takipçi sayýsý en fazla olan okulun lokasyonunu ve adýný yazdýr.*/
select lokasyon,okul_adi
from Okul
where takipci_sayisi in (select max(takipci_sayisi) from Okul)



/*Linkedin trigger*/
CREATE TRIGGER KullaniciSilme
ON Kullanici
AFTER DELETE
AS
DECLARE @kul_id INT, @isim varchar(20), @email varchar(40), @sifre varchar(16)
SELECT @kul_id = kullanici_id , @isim = kullanici_isim , @email = e_mail , @sifre = sifre FROM DELETED
BEGIN
DELETE FROM Profil WHERE kullanici_id = @kul_id
END
