use HOMv18 

/* Selam mesaj� alanlardan C# yeten�i olanlar�n ad�n� mailini ve okulunu listele */
SELECT kl.kullanici_isim,kl.e_mail,ok.okul_adi
FROM Kullanici AS kl, Mesaj AS msj, Yetenek AS yet, Kullanici_yetenek AS kulyet, Egitim AS eg, Okul AS ok
WHERE msj.icerik = 'Selam' AND msj.kullanici_id = kl.kullanici_id AND kl.kullanici_id = kulyet.kullanici_id AND kulyet.yetenek_id =yet.yetenek_id
AND yet.yetenek_adi = 'C#' AND kl.kullanici_id = eg.kullanici_id AND eg.okul_id = ok.okul_id

/* Selam mesaj� alanlardan C# yetene�i olanlar�n ad�n� mailini ve okulunu listele  kendi sorgum*/

SELECT k.kullanici_isim, k.e_mail, o.okul_adi
FROM	Kullanici as k, Okul as o, Mesaj as m, Yetenek as y, Kullanici_yetenek as ky, Egitim as e
WHERE m.icerik = 'Selam' AND m.kullanici_id=k.kullanici_id AND y.yetenek_adi='C#' AND y.yetenek_id=ky.yetenek_id AND ky.kullanici_id=k.kullanici_id 
AND e.okul_id=o.okul_id AND e.kullanici_id=k.kullanici_id 







/*  Hasan�n Merve isimli arkada��n�n �ye oldu�u topluluklar� g�ster */

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

																			
																									
	/* Ozum ve Hasan �n ortak arkada�lar�ndan  'aktas367@hotmail.com' mail adresine sahip ki�inin odt�de okuyan arkada�lar�n�n mail adresleri nelerdir */																						
SELECT k3.e_mail
FROm Kullanici AS k3, Arkadaslar AS a3, Okul AS o, Egitim AS e 
WHERE k3.kullanici_id = e.kullanici_id AND e.okul_id = o.okul_id AND o.okul_adi = 'ODT�' AND k3.kullanici_id = a3.arkadas_id AND a3.kullanici_id IN (SELECT k.kullanici_id 
FROM Kullanici AS k, Arkadaslar AS a, Kullanici AS k2, Arkadaslar AS a2
WHERE k2.kullanici_isim LIKE '%Ozum%' AND k2.kullanici_id = a2.kullanici_id AND a.arkadas_id = a2.arkadas_id AND k.e_mail = 'aktas367@hotmail.com' AND a.arkadas_id = k.kullanici_id AND a.kullanici_id IN (SELECT kullanici_id
																									FROM Kullanici
																									WHERE kullanici_isim LIKE '%Hasan%'))																							


-----------------------------------------------------

/*Merve Tahtac�n�n etiketlendi�i foto�raflar*/ 
SELECT fotograf_id
FROM Foto_tag
Where etiketlenen_kisi IN (SELECT kullanici_id
						   FROM Kullanici
						   WHERE kullanici_isim = 'Merve Tahtac�')

/*Merve Tahtac�n�n etiketlendi�i foto�raflar*/ 
SELECT k.kullanici_isim AS Foto_sahibi, f.fotograf_id
FROM Fotograf_album AS fa, Fotograf AS f, Kullanici AS k
WHERE k.kullanici_id= fa.kullanici_id AND f.fotograf_album_id = fa.fotograf_album_id AND f.fotograf_id IN (SELECT fotograf_id
						FROM Foto_tag
						Where etiketlenen_kisi IN (SELECT kullanici_id
						   FROM Kullanici
						   WHERE kullanici_isim = 'Merve Tahtac�'))





		
/*Birden fazla foto�raf alb�m� olan ki�ilerin isimlerini listele -- GROUP BY VE SELECT AYNI OLMALI ?? */						   
SELECT Kullanici.kullanici_isim AS Kullan�c�lar, COUNT(*) AS SAYI
FROM  Kullanici, Fotograf_album
WHERE Kullanici.kullanici_id=Fotograf_album.kullanici_id
GROUP BY Kullanici.kullanici_isim
HAVING COUNT(*)>=2;


/*Birden fazla foto�raf alb�m� olan ki�ilerin isimlerini listele -- HATA VER�Y�R */						   
SELECT Kullanici.kullanici_isim AS Kullan�c�lar
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


/* Profil bilgisinde ili�ki durumu evli ve hakk�nda k�sm�nda �stanbul ge�en kullan�c�lar� alfabetik listeleyin. */

SELECT kullanici_isim AS Profil, about_me AS Hakk�nda, iliski AS �li�ki 
FROM Kullanici, Profil
WHERE Kullanici.kullanici_id= Profil.kullanici_id and iliski='Evli' and about_me LIKE '%�stanbul%'
ORDER BY about_me ASC


/* Postu olan kullan�c�lar�n isimlerini listele */
	select k.kullanici_isim AS Postlu_Kullan�c�lar
	from Kullanici as k inner join Post as p on k.kullanici_id = p.kullanici_id 


/* Postu olan kullan�c�lar�n isimlerini listele-EXISTS �LE */
	select kullanici_isim AS Postlu_Kullan�c�lar
	from Kullanici as k
	where exists ( select *
						from Post as p
						where k.kullanici_id = p.kullanici_id)


/*Postu olan kullan�c�lar�n id'Si*/
	SELECT DISTINCT kullanici_id 
	FROM Post


/*Herhangi bir postu olmayan kullan�c�lar� listele*/
	SELECT kullanici_isim AS Postlu_Kullan�c�lar
	FROM Kullanici as k
	WHERE not exists ( SELECT *
					   FROM Post as p
					   WHERE k.kullanici_id = p.kullanici_id)


/*Mustafa Ege Oral'�n payla�t��� postlar� be�enen ki�ileri ve say�s�n� g�ster.*/ /*K���LER�N �S�MLER�N� G�STEREMED�M!!!!!!!!!!!!!*/

        SELECT DISTINCT post_id as PostID, begenen_kisi_id as BegenenID, Kullanici.kullanici_isim AS Be�enen_Kullan�c�
            FROM Post_begeni as P, Kullanici
            WHERE P.begenen_kisi_id=Kullanici.kullanici_id  AND P.post_id IN  ( SELECT post_id
                                                                                FROM Kullanici, Post
                                                                                WHERE Kullanici.kullanici_isim='Mustafa Ege Oral' AND Post.kullanici_id=Kullanici.kullanici_id)


/*Hasan Erfenek'e gelen mesajlarda 'Selam' kelimesini i�eren konu�malar yapt��� ki�ilerin bilgilerini listeleyiniz.*/
SELECT kullanici_id AS Kullan�c�ID, kullanici_isim AS Mesaj_G�nderen
FROM Kullanici
WHERE kullanici_id= (SELECT Mesaj.kimden_id
                     FROM Kullanici, Mesaj
			         WHERE icerik LIKE '%Selam%' AND Kullanici.kullanici_isim='Hasan Erfenek' AND Kullanici.kullanici_id= Mesaj.kullanici_id)


/*Tiyatro videosuna sahip ki�ilerin kimler oldu�unu ve kulland�klar� dili listeleyin.*/


SELECT Kullanici.kullanici_isim AS Kullan�c�lar, dil_adi AS Kulland�klar�_Dil, video_adi AS Video
FROM Kullanici, Dil, Video, Kullan�lan_Dil
WHERE  video_adi LIKE '%Tiyatro%' AND Video.kullanici_id=Kullanici.kullanici_id AND Kullan�lan_Dil.kullanici_id=Kullanici.kullanici_id AND Kullan�lan_Dil.dil_id=Dil.dil_id




/*Hasan Erfenek'in arkada�lar�n�n etkinlik bilgisini g�ster. */
select Etkinlik_bilgisi.etkinlik as Etkinlik, Kullanici.kullanici_isim AS Hasan�n_Arkada�lar�
from Etkinlik_bilgisi, Kullanici
where Kullanici.kullanici_id=Etkinlik_bilgisi.kullanici_id AND  Kullanici.kullanici_id IN (SELECT Arkadaslar.arkadas_id 
                                                                                          FROM Kullanici, Arkadaslar 
																						  WHERE Kullanici.kullanici_isim='Hasan Erfenek' AND Kullanici.kullanici_id=Arkadaslar.kullanici_id )



/*Mustafa Ege Oral'�n payla�t��� postlar� be�enen ki�ileri ve say�s�n� g�ster.*/ 

            SELECT DISTINCT post_id as PostID, begenen_kisi_id as BegenenID, Kullanici.kullanici_isim AS Be�enen_Kullan�c�
            FROM Post_begeni as P, Kullanici
            WHERE P.begenen_kisi_id=Kullanici.kullanici_id  AND P.post_id IN  ( SELECT post_id
                                                                                FROM Kullanici, Post
                                                                                WHERE Kullanici.kullanici_isim='Mustafa Ege Oral' AND Post.kullanici_id=Kullanici.kullanici_id)



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




/*Posttaki be�eni say�s� 0'a e�it b�y�k olabilir.*/																			
ALTER TABLE Post
Add Constraint p_begeni 
Check (begeni_sayisi>=0)

------------------------------------------------------------------------------------------------

/* 'Yeni i� pozisyonunu tebrik ederim!' mesaj�n� alan kullan�c�lardan Java deneyimi olanlar�n isim,mail ve okul adlar�n� yaz.*/
select kullanici_isim,e_mail,okul_adi
from Kullanici,Okul,Kullanici_yetenek,Mesaj,Yetenek,Egitim
where Kullanici_yetenek.yetenek_id = Yetenek.yetenek_id and Yetenek.yetenek_adi='Java'
and Kullanici_yetenek.kullanici_id=Kullanici.kullanici_id
and Kullanici.kullanici_id=Mesaj.kullanici_id and Mesaj.icerik='Yeni i� pozisyonunu tebrik ederim!'
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
							where Mesaj.icerik='Yeni i� pozisyonunu tebrik ederim!' and Mesaj.kullanici_id=Kullanici.kullanici_id )

/* IEEE �yesi olan Bursa lokasyonundaki bir �irkette �al��m�� insanlar�n isimleri ve ilgi alanlar�n� g�ster */
select Kullanici.kullanici_isim,Okul.okul_adi,Company.company_name
from Kullanici,Okul,Company,Topluluk,Topluluk_Uyeleri,Deneyim,Ilgi_Alani
where Kullanici.kullanici_id= Topluluk_Uyeleri.kullanici_id and Topluluk_Uyeleri.topluluk_id=Topluluk.topluluk_id and Topluluk.topluluk_adi='IEEE'
and Kullanici.kullanici_id=Deneyim.kullanici_id and Deneyim.company_id=Company.company_id and Company.lokasyon='Bursa'
and Kullanici.kullanici_id=Ilgi_Alani.kullanici_id  and Ilgi_Alani.okul_id =Okul.okul_id

/* IEEE �yesi olan Bursa lokasyonundaki bir �irkette �al��m�� insanlar�n isimleri ve ilgi alanlar�n� g�ster */
SELECT Kullanici.kullanici_isim, Ilgi_Alani.ilgialani_id
FROM Kullanici,Ilgi_Alani, Topluluk as T, Topluluk_Uyeleri as T1, Deneyim, Company
WHERE T.topluluk_id=T1.topluluk_id AND T.topluluk_adi='IEEE' AND T1.kullanici_id=Kullanici.kullanici_id 
AND Kullanici.kullanici_id=Deneyim.kullanici_id AND Company.lokasyon='Bursa' AND 
Deneyim.company_id=Company.company_id  AND Kullanici.kullanici_id=Ilgi_Alani.kullanici_id

/* Postunda 'm�hendisler g�n�n�z kutlu olsun!' yazan birinin payla�t��� foto�raflar� g�ster.*/
select Fotograf.fotograf_id
from Fotograf,Fotograf_album,Post,Kullanici
where Kullanici.kullanici_id=Post.kullanici_id and Post.post_icerik='m�hendisler g�n�n�z kutlu olsun!'
and Kullanici.kullanici_id=Fotograf_album.kullanici_id and Fotograf_album.fotograf_album_id=Fotograf.fotograf_album_id

/* Botart �irketinin verdi�i i� ilanlar�n� listele.*/
select baslik
from Is_Ilani,Company
where Is_Ilani.company_id=Company.company_id and Company.company_name='Botart'

/*Herhangi bir toplulu�a �ye olmayan ki�ilerin isimlerini listele.*/
select kullanici_isim
from Kullanici
where not exists (select * from Topluluk_Uyeleri  where Topluluk_Uyeleri.kullanici_id=Kullanici.kullanici_id)

/* Takip�i sayisi 100den fazla olan �irketleri lokasyonuna g�re grupla.*/ 
select lokasyon
from Company
where takipci_sayisi>100
group by lokasyon


/*Okul tablosundaki kay�tlar� takip�i say�s�na g�re artan s�rada s�rala.*/
select *
from Okul
order by takipci_sayisi asc

/* Profilinde hakk�nda k�sm�nda a harfi bulunanlar� listele.*/
select kullanici_isim,about_me
from Profil,Kullanici
where Kullanici.kullanici_id=Profil.kullanici_id 
and Profil.about_me like '%a%'

/* �� ilanlar�nda istenen yetenek say�lar�n� �oktan aza listele.*/
select count(Yetenek.yetenek_id)
from Yetenek,Is_Ilani,Is_Ilani_Yetenek
where  Is_Ilani.ilan_id=Is_Ilani_Yetenek.ilan_id and Is_Ilani_Yetenek.yetenek_id=Yetenek.yetenek_id 
order by count(Yetenek.yetenek_id) desc

/* Mervenin Hasan isimli arkada��n�n �ye oldu�u topluluklar� listele.*/
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
/* Mervenin Hasan isimli arkada��n�n �ye oldu�u topluluklar� listele.*/

select topluluk_adi,aciklama
from Topluluk as t ,Topluluk_Uyeleri as t1,Kullanici as k, Kullanici as k1,Connections as c
where k.kullanici_isim LIKE '%Merve%'AND k.kullanici_id=c.kullanici_id
 AND c.arkadas_id=k1.kullanici_id AND k1.kullanici_isim LIKE '%Hasan%'
 AND k.kullanici_id=t1.kullanici_id and t.topluluk_id=t1.topluluk_id
 


/* 'Merve Tahtaci'nin �ye oldu�u topluluklar�n ad�n� listele.*/
select topluluk_adi
from Topluluk 
where topluluk_id in ( select topluluk_id
					   from Topluluk_Uyeleri,Kullanici
					   where Topluluk_Uyeleri.kullanici_id=Kullanici.kullanici_id and Kullanici.kullanici_isim='Merve Tahtaci' )

/* Takip�i say�s� en fazla olan okulun lokasyonunu ve ad�n� yazd�r.*/
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
