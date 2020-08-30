DROP TABLE IF EXISTS ostoskorit;
DROP TABLE IF EXISTS arvostelut;
DROP TABLE IF EXISTS kayttajat;
DROP TABLE IF EXISTS tuotteet;
DROP TABLE IF EXISTS tyypit;
DROP TABLE IF EXISTS osastot;
DROP TABLE IF EXISTS tekijat;

CREATE TABLE osastot (
    id SERIAL PRIMARY KEY, 
    nimi TEXT, 
    kuvaus TEXT
);

CREATE TABLE tyypit (
    id SERIAL PRIMARY KEY, 
    nimi TEXT, 
    kuvaus TEXT,
    osasto_id INTEGER REFERENCES osastot
);

CREATE TABLE tekijat (
    id SERIAL PRIMARY KEY, 
    nimi TEXT, 
    kuvaus TEXT
);

CREATE TABLE tuotteet (
    id SERIAL PRIMARY KEY, 
    nimi TEXT, 
    kuvaus TEXT, 
    varastossa INTEGER, 
    hinta INTEGER, 
    tekija_id INTEGER REFERENCES tekijat,
    tyyppi_id INTEGER REFERENCES tyypit
);

CREATE TABLE kayttajat (
    id SERIAL PRIMARY KEY, 
    nimi TEXT UNIQUE NOT NULL, 
    salasana TEXT NOT NULL,
    superkayttaja BOOLEAN,
    mod BOOLEAN
);

CREATE TABLE arvostelut (
    id SERIAL PRIMARY KEY, 
    otsikko TEXT, 
    teksti TEXT,
    arvosana INTEGER,
    kayttaja_id INTEGER REFERENCES kayttajat,
    tuote_id INTEGER REFERENCES tuotteet,
    paivamaara TIMESTAMP
);

CREATE TABLE ostoskorit (
    id SERIAL PRIMARY KEY, 
    summa INTEGER,
    tuotteet INTEGER[],
    kayttaja_id INTEGER REFERENCES kayttajat
);

INSERT INTO osastot (nimi, kuvaus) VALUES ('Vaatteet', 'Vaate on yksittäinen vaatekappale, päälle puettavien vaatteiden eli vaatetuksen osa. Vaatteiden tavallisimmat valmistusmateriaalit ovat nahka, kasvi- ja eläinkuidut sekä erilaiset tekokuidut. Tavallisimmat ylävartaloon puettavat vaatteet ovat paita, liivi ja takki. Vastaavasti alavartalossa eli jaloissa käytetään housuja tai hameita. Jalkaterien peittona pidetään sukkia ja jalkineita. Koko vartaloa peittäviä vaatteita tai vaatekokonaisuuksia ovat muun muassa puku, mekko ja kaapu. Käsissä pidettävien vaatekappaleiden yleisnimitys on käsine ja päässä pidettävien päähine. (https://fi.wikipedia.org/wiki/Vaate)');
INSERT INTO osastot (nimi, kuvaus) VALUES ('Musiikki', 'Musiikki (m.kreik. μουσική, mūsikē) eli säveltaide on ihmisen kulttuurille ominainen ääneen perustuva taiteen ja viestinnän muoto. Mūsikē tekhnē tarkoitti antiikin Kreikassa muusain taidetta eli säveltaiteen ohella myös runoutta ja tanssia.

Musiikissa on useita ulottuvuuksia, kuten ääni (sävel tai rytmimusiikissa myös hälyääni), rytmi, dynamiikka ja rakenne. Musiikissa voi olla peräkkäin vaihtuvista sävelkorkeuksista muodostuva melodia. Musiikki voi olla pelkin soittimin tuotettua (ilman laulajaa) jolloin sitä kutsutaan instrumentaaliseksi musiikiksi. Musiikki voi olla myös soittimetonta eli ihmisen pelkällä kehollaan tuottamaa, kuten kuorolaulua, a cappella -laulua tai vihellystä. Musiikki etenee aina ajassa ja sillä on tempo eli etenemisnopeus, mutta musiikissa ei välttämättä ole eksplisiittistä rytmisoittimin tai säestyksellä tuotettua rytmiä. Musiikille ei ole olemassa yksiselitteistä määritelmää. Mikä tahansa ääni voi olla musiikkia jos äänen tuottaja on sen sellaiseksi tarkoittanut tai kuulija sen sellaiseksi mieltää. Myös hiljaisuus voidaan tulkita tai tarkoittaa musiikiksi. Populaarimusiikissa on tavallisesti eksplisittinen rummuin tai säestyksellä tuotettu rytmi. (https://fi.wikipedia.org/wiki/Musiikki)');
INSERT INTO osastot (nimi, kuvaus) VALUES ('Pelit', 'Videopeli on elektroninen peli, jonka pelaamiseen tarvitaan käyttöliittymä ja näyttölaite. Käyttöliittymän kanssa vuorovaikuttaminen tuottaa välittömän visuaalisen palautteen näyttölaitteen ruudulle. Alkujaan termi ”video” viittasi bittikarttagrafiikalla toteutettuihin tietokonepeleihin (erotuksena vektorigrafiikalla toteutetuista peleistä), mutta nykyään sillä tarkoitetaan pelejä, joiden pelaamiseen tarvitaan näyttölaitetta. Termi ”tietokonepeli” on tarkempi ilmaisu, sillä useimmat pelit vaativat toimiakseen mikroprosessoria, eivätkä kaikki pelit vaadi näyttölaitetta. Käytössä termillä viitataan yleensä henkilökohtaiselle tietokoneelle julkaistuihin videopeleihin. Suomalaisessa pelitutkimuksessa videopelit katsotaan kuuluviksi digitaalisiin peleihin.

Videopelin pelaamiseen tarvitaan alusta, joka voi olla esimerkiksi henkilökohtainen tietokone, pelikonsoli, käsikonsoli tai matkapuhelin. Myös kolikkopelit lasketaan videopeleiksi. Videopelejä kontrolloidaan peliohjaimella, jonka ominaisuudet vaihtelevat alustan mukaan. Pelikonsoleilla ohjaimet ovat varta vasten pelaamista varten suunniteltuja, mutta tietokonepelejä pelataan yleisimmin näppäimistön ja hiiren kanssa. Peleihin on myös erikoistuneita ohjaimia kuten valopistooleja, ratti- ja lento-ohjaimia.

Videopeliteollisuus on kasvanut nopeasti. Newzoo-tutkimusyritys arvioi huhtikuussa 2016 videopelien tuottavan vuoden loppuun mennessä 99,6 miljardin dollarin voitot ja vuonna 2019 jo 118,6 miljardin dollarin voitot. Arvion perustella mobiilipelien myynti nousisi PC- ja konsolipelien myynnin ohi ja jatkavan tämän jälkeen selvää kasvuaan. Videopelit ovat akateemisen pelitutkimuksen merkittävimpiä tutkimuskohteita. (https://fi.wikipedia.org/wiki/Videopeli)');
INSERT INTO osastot (nimi, kuvaus) VALUES ('Kirjat', 'Kirja on nidos paperiarkkeja, joissa on painettua tekstiä tai kuvia, tai sen muotoisena ilmestynyt kirjallinen tuote. Kirjoja voidaan julkaista myös sähköisessä muodossa ja äänikirjoina. (https://fi.wikipedia.org/wiki/Kirja)');
INSERT INTO tyypit (nimi, kuvaus, osasto_id) VALUES ('Hattuja', 'Hattu on tavallisesti jäykästä materiaalista valmistettu päähine, jossa on kupu ja usein lieri. Hattua voidaan käyttää esimerkiksi pään suojaamiseen ja lämpöenergian säilyttämiseen, koristeena, itseilmaisuna tai kantajansa aseman merkkinä. (https://fi.wikipedia.org/wiki/Hattu)', 1);
INSERT INTO tyypit (nimi, kuvaus, osasto_id) VALUES ('Rummut', 'Rumpu on puusta, metallista tai lasikuidusta valmistettu akustinen lyömäsoitin. Yleensä se on lieriömäinen puu- tai metallikehys, jonka päähän on pingotettu nahkakalvo. Rumpu on soittimista ehkä kaikkein levinnein, sillä niitä on valmistettu lähes jokaisessa kulttuurissa. Luonnonkulttuureissa tavallisia ovat suppilon muotoiset, yksikalvoiset rummut. Rummun sointikorkeutta voidaan muuttaa rumpukalvon kireyttä säätämällä. (https://fi.wikipedia.org/wiki/Rumpu)', 2);
INSERT INTO tyypit (nimi, kuvaus, osasto_id) VALUES ('Konsolit', 'Pelikonsoli on viihde-elektroniikan laite, joka on valmistettu videopelien pelaamista varten. Käytännössä se on pelkkään viihdekäyttöön suunniteltu henkilökohtainen tietokone, jonka arkkitehtuuri (laitteisto sekä ohjelmisto) on täysin suljettu ja suojattu ulkopuolisilta. Yleensä laitteen tuottamaa kuvaa katsellaan televisiosta ja toimintoja ohjataan peliohjaimella. (https://fi.wikipedia.org/wiki/Pelikonsoli)', 3);
INSERT INTO tekijat (nimi, kuvaus) VALUES ('HattujaOy', 'TEHÄÄN HATTUJA');
INSERT INTO tekijat (nimi, kuvaus) VALUES ('Yamaha', 'Yamaha Corporation on suuri japanilainen valmistavan teollisuuden yritys. Yamaha Corporationilla on kolme päätoimialaa, jotka ovat soittimet (pianot, digitaaliset soittimet, puhaltimet, jousisoittimet, lyömäsoittimet ja muut musiikkituotteet), äänentoistolaitteet (myös tietoliikennelaitteet) ja muut tuotteet (elektroniset laitteet, ajoneuvojen sisäosien puuosat, teollisuusautomaatio, golftuotteet, vapaa-ajan tuotteet ja jotkin muut liiketoiminta-alueet). Yamaha Corporation on tunnettu esimerkiksi maailman suurimpana soitinvalmistajana. Yhtiö ylläpitää musiikkikouluja, englannin kielikouluja, lomakiinteistöjä ja golfklubia. (https://fi.wikipedia.org/wiki/Yamaha)');
INSERT INTO tekijat (nimi, kuvaus) VALUES ('Sony', 'Sony Corporation (jap. ソニー株式会社, Sonī Kabushiki Gaisha) on japanilainen viihde-elektroniikkavalmistaja. Sen perustivat 7. toukokuuta 1946 Masaru Ibuka (井深大 1908–1997) ja Akio Morita (盛田昭夫 1921–1999). (https://fi.wikipedia.org/wiki/Sony)');
INSERT INTO tuotteet (nimi, kuvaus, varastossa, hinta, tekija_id, tyyppi_id) VALUES ('Fedora', 'Fedora-hattu eli fedora on pehmeästä huovasta tehty lierihattu. Fedorahatut saavuttivat suuren suosion länsimaissa 1900-luvun alkupuolella ja näyttäytyivät säännöllisesti mm. 1950-luvun Hollywood-elokuvissa. Fedora yhdistetään usein myös Indiana Jonesiin. Fedoralla onkin melko vanhanaikaisen päähineen maine ja se on nykyisin harvinaistunut käytössä. Ortodoksijuutalaiset, etenkin haredit, kuitenkin käyttävät fedoraa edelleen hyvin yleisesti.

Fedora-hattu sai nimensä Victorien Sardoun näytelmän Fédora (1882) sankarittaren hatusta. (https://fi.wikipedia.org/wiki/Fedora-hattu)', 282, 131, 1, 1);
INSERT INTO tuotteet (nimi, kuvaus, varastossa, hinta, tekija_id, tyyppi_id) VALUES ('Yamaha Rydeen Drum Set', 'Rumpusetti yamahalta', 1638, 725, 2, 2);
INSERT INTO tuotteet (nimi, kuvaus, varastossa, hinta, tekija_id, tyyppi_id) VALUES ('Playstation 2', 'PlayStation 2 (jap. プレイステーション2, virallinen lyhenne PS2) on Sonyn valmistama kuudennen sukupolven pelikonsoli. Konsolin edeltäjä on PlayStation ja sen seuraaja PlayStation 3. PlayStation 2:n kehittäminen julkistettiin huhtikuussa 1999, ja se julkaistiin ensin Japanissa 4. maaliskuuta 2000. Sen pääkilpailijat olivat Segan Sega Dreamcast, Microsoftin Xbox ja Nintendon Nintendo GameCube.

PS2 on maailman myydyin pelikonsoli: vuoden 2010 marraskuuhun mennessä sitä oli myyty yli 147 miljoonaa kappaletta.

Alun perin konsolin eliniän piti olla 10 vuotta, mutta Sonyn mukaan se tulee kestämään niin kauan kuin kehittäjät tekevät sille uusia pelejä ja sekä konsoli että sen pelit myyvät. PlayStation 2:n valmistus lopetettiin 4. tammikuuta 2013. (https://fi.wikipedia.org/wiki/PlayStation_2)', 90, 243, 3, 3);

