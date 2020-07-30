create database HOMv18
use HOMv18

create table Kullanici (
kullanici_id int not null,
kullanici_isim varchar(20) not null,
sifre varchar(16) not null,
e_mail varchar(40) not null,
primary key (kullanici_id)
)

create table Profil (
profil_id int not null,
kullanici_id int not null,
about_me varchar(60),
iliski varchar(10),
primary key (profil_id),
foreign key(kullanici_id) references Kullanici(kullanici_id)
)

create table Bildirim (
bildirim_id int not null,
kullanici_id int not null,
bildirim_icerik varchar(60),
primary key (bildirim_id),
foreign key(kullanici_id) references Kullanici(kullanici_id)
)

create table Arkadaslar (
kullanici_id int not null,
arkadas_id int not null,
primary key (kullanici_id,arkadas_id),
foreign key(kullanici_id) references Kullanici(kullanici_id),
foreign key(arkadas_id) references Kullanici(kullanici_id)
)

create table Gizlilik (
kullanici_id int not null,
yasakli_kisi_id int not null,
primary key (kullanici_id,yasakli_kisi_id),
foreign key(kullanici_id) references Kullanici(kullanici_id),
foreign key(yasakli_kisi_id) references Kullanici(kullanici_id)
)


create table Mesaj (
mesaj_id int not null,
kullanici_id int not null,
kimden_id int not null,
icerik varchar(40),
primary key (mesaj_id),
foreign key(kullanici_id) references Kullanici(kullanici_id),
foreign key(kimden_id) references Kullanici(kullanici_id)
)


create table Dil(
dil_id int not null,
dil_adi varchar(15),
primary key(dil_id)
)

create table Kullanilan_Dil (
dil_id int not null,
kullanici_id int not null,
primary key (dil_id,kullanici_id),
foreign key(kullanici_id) references Kullanici(kullanici_id),
foreign key(dil_id) references Dil(dil_id)
)

create table Adres (
adres_id int not null,
profil_id int not null,
adres varchar(60),
primary key (adres_id),
foreign key(profil_id) references Profil(profil_id)
)


create table Begenilen_fan_sayfa (
fan_sayfa_id int not null,
kullanici_id int not null,
primary key (fan_sayfa_id,kullanici_id),
foreign key(kullanici_id) references Kullanici(kullanici_id)
)

create table Fan_sayfa (
fan_sayfa_id int not null,
web_adres varchar(60),
primary key (fan_sayfa_id)
)


create table Fotograf_album (
fotograf_album_id int not null,
kullanici_id int not null,
album_isim varchar(50),
primary key (fotograf_album_id),
foreign key(kullanici_id) references Kullanici(kullanici_id)
)

create table Fotograf (
fotograf_id int not null,
fotograf_album_id int not null,
primary key (fotograf_id),
foreign key(fotograf_album_id) references Fotograf_album(fotograf_album_id)
)

create table Foto_tag (
fotograf_id int not null,
etiketlenen_kisi int not null,
primary key (fotograf_id,etiketlenen_kisi),
foreign key (etiketlenen_kisi) references Kullanici (kullanici_id)
)

create table Video (
video_id int not null,
kullanici_id int not null,
video_adi varchar(50),
primary key (video_id),
foreign key(kullanici_id) references Kullanici(kullanici_id)
)

create table Company(
company_id int not null,
company_name varchar(30),
aciklama varchar(300),
lokasyon varchar(40),
takipci_sayisi int,
primary key (company_id)
)

create table Okul(
okul_id int not null,
okul_adi varchar(40),
aciklama varchar(300),
lokasyon varchar(40),
takipci_sayisi int,
primary key (okul_id)
)

create table Ilgi_Alani(
ilgialani_id int not null,
kullanici_id int not null,
okul_id int,
company_id int,
primary key (ilgialani_id),
foreign key (kullanici_id) references Kullanici(kullanici_id),
foreign key (okul_id) references Okul(okul_id),
foreign key (company_id) references Company(company_id)
)

create table Yetenek(
yetenek_id int not null,
yetenek_adi varchar(30),
primary key (yetenek_id)
)

create table Kullanici_yetenek(
kullanici_id int not null,
yetenek_id int not null,
primary key (kullanici_id,yetenek_id),
foreign key (kullanici_id) references Kullanici(kullanici_id),
foreign key (yetenek_id) references Yetenek(yetenek_id)
)

create table Yetenek_Onayi(
yetenek_sahibi_id int not null,
onaylayan_kisi_id int not null,
yetenek_id int not null,
primary key (yetenek_sahibi_id,onaylayan_kisi_id,yetenek_id),
foreign key (yetenek_sahibi_id) references Kullanici(kullanici_id),
foreign key (onaylayan_kisi_id) references Kullanici (kullanici_id),
foreign key (yetenek_id) references Yetenek (yetenek_id)
)
create table Deneyim(
deneyim_id int not null,
kullanici_id int not null,
company_id int,
pozisyon varchar(30),
start_date DATE,
end_date DATE,
primary key(deneyim_id),
foreign key(kullanici_id) references Kullanici(kullanici_id),
foreign key(company_id) references Company(company_id)
)

create table Egitim(
egitim_id int not null,
kullanici_id int not null,
okul_id int,
start_date DATE,
end_date DATE,
primary key(egitim_id),
foreign key(kullanici_id) references Kullanici(kullanici_id),
foreign key(okul_id) references Okul(okul_id)
)

create table Post (
post_id int not null,
kullanici_id int not null,
post_icerik varchar(60),
album_id int,
video_id int,
begeni_sayisi int,
primary key (post_id),
foreign key(kullanici_id) references Kullanici(kullanici_id),
foreign key(album_id) references Fotograf_album(fotograf_album_id),
foreign key(video_id) references Video(video_id)
)

create table Post_begeni (
begeni_id int not null,
begenen_kisi_id int not null,
post_id int not null,
primary key (begeni_id),
foreign key(begenen_kisi_id) references Kullanici(kullanici_id),
foreign key(post_id) references Post(post_id)
)

create table Post_Yorum (
yorum_id int not null,
post_id int not null,
yorum_yapan_kisi_id int not null,
yorum varchar(100),
primary key (yorum_id),
foreign key(post_id) references Post(post_id),
foreign key(yorum_yapan_kisi_id) references Kullanici(kullanici_id)
)


create table Topluluk_Uyeleri (
topluluk_id int not null,
kullanici_id int not null,
primary key (topluluk_id,kullanici_id),
foreign key(kullanici_id) references Kullanici(kullanici_id),
)

create table Topluluk (
topluluk_id int not null,
topluluk_adi varchar(60),
aciklama varchar(300),
primary key (topluluk_id),
)

create table Is_Ilani(
ilan_id int not null,
company_id int not null,
baslik varchar(40),
aciklama varchar(400),
primary key(ilan_id),
foreign key(company_id) references Company(company_id)
)

create table Is_Ilani_Basvuru(
ilan_id int not null,
kullanici_id int not null,
primary key(ilan_id,kullanici_id),
foreign key(ilan_id) references Is_Ilani(ilan_id),
foreign key(kullanici_id) references Kullanici(kullanici_id)
)

create table Is_Ilani_Yetenek(
ilan_id int not null,
yetenek_id int not null,
primary key(ilan_id,yetenek_id),
foreign key(ilan_id) references Is_Ilani(ilan_id),
foreign key(yetenek_id) references Yetenek(yetenek_id)
)

/*Constraints*/ 
Alter Table Company
Add Constraint C_Company
Check (takipci_sayisi >=0)

Alter Table Okul
Add Constraint C_Okul
Check (takipci_sayisi >=0)