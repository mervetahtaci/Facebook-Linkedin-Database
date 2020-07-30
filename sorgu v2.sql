
   /* Selam mesajı alanlardan C# yetenği olanların adını mailini ve okulunu listele */
SELECT kl.kullanici_isim,kl.e_mail,ok.okul_adi
FROM Kullanici AS kl, Mesaj AS msj, Yetenek AS yet, Kullanici_yetenek AS kulyet, Egitim AS eg, Okul AS ok
WHERE msj.icerik = 'Selam' AND msj.kullanici_id = kl.kullanici_id AND kl.kullanici_id = kulyet.kullanici_id AND kulyet.yetenek_id =yet.yetenek_id
AND yet.yetenek_adi = 'C#' AND kl.kullanici_id = eg.kullanici_id AND eg.okul_id = ok.okul_id



/* Ali nin Ahmet isimli arkadaşının üye olduğu toplulukları göster */

SELECT topluluk_adi, aciklama
FROM Topluluk 
WHERE topluluk_id IN (
	SELECT topluluk_id
	FROM Topluluk_Uyeleri
	WHERE kullanici_id = (
		SELECT kullanici_id
		FROM Kullanici
		WHERE kullanici_isim LIKE '%Ahmet%' AND kullanici_id = (
			SELECT kullanici_id
			FROM Arkadaslar
			WHERE arkadas_id = (
				SELECT kullanici_id
				FROM Kullanici
				WHERE kullanici_isim LIKE '%Ali%'
			)
		)
	)
)


																						
																									
	/* Ozum ve Hasan ın ortak arkadaşlarından  'aktas367@hotmail.com' mail adresine sahip kişinin odtüde okuyan arkadaşlarının mail adresleri nelerdir */																						
SELECT k3.e_mail
FROm Kullanici AS k3, Arkadaslar AS a3, Okul AS o, Egitim AS e 
WHERE k3.kullanici_id = e.kullanici_id AND e.okul_id = o.okul_id AND o.okul_adi = 'ODTÜ' AND k3.kullanici_id = a3.arkadas_id AND a3.kullanici_id IN (SELECT k.kullanici_id 
FROM Kullanici AS k, Arkadaslar AS a, Kullanici AS k2, Arkadaslar AS a2
WHERE k2.kullanici_isim LIKE '%Ozum%' AND k2.kullanici_id = a2.kullanici_id AND a.arkadas_id = a2.arkadas_id AND k.e_mail = 'aktas367@hotmail.com' AND a.arkadas_id = k.kullanici_id AND a.kullanici_id IN (SELECT kullanici_id
																									FROM Kullanici
																									WHERE kullanici_isim LIKE '%Hasan%'))																							





