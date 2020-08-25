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

INSERT INTO osastot (nimi, kuvaus) VALUES ('Vaatteet', 'Vaatteita, puetaan päälle.');
INSERT INTO osastot (nimi, kuvaus) VALUES ('Musiikki', 'Musiikki soi korvissa brr');
INSERT INTO osastot (nimi, kuvaus) VALUES ('Pelit', 'Pelejä pelaamiseen jee');
INSERT INTO osastot (nimi, kuvaus) VALUES ('Kirjat', 'Kirjoja voi lukea silmämunilla.');
INSERT INTO tyypit (nimi, kuvaus, osasto_id) VALUES ('Hattuja', 'Vaatteita päälle', 1);
INSERT INTO tyypit (nimi, kuvaus, osasto_id) VALUES ('Rummut', 'Niitä lyödään lujaa', 2);
INSERT INTO tyypit (nimi, kuvaus, osasto_id) VALUES ('Konsolit', 'Osta PC tyhmä', 3);
INSERT INTO tekijat (nimi, kuvaus) VALUES ('HattujaOy', 'TEHÄÄN HATTUJA');
INSERT INTO tekijat (nimi, kuvaus) VALUES ('Yamaha', 'lalalalalala');
INSERT INTO tekijat (nimi, kuvaus) VALUES ('Sony', 'lol');
INSERT INTO tuotteet (nimi, kuvaus, varastossa, hinta, tekija_id, tyyppi_id) VALUES ('Fedora', 'Hassu hattu haha', 282, 131, 1, 1);
INSERT INTO tuotteet (nimi, kuvaus, varastossa, hinta, tekija_id, tyyppi_id) VALUES ('Yamaha Rydeen Drum Set', 'Pampam very nais ääni', 1638, 725, 2, 2);
INSERT INTO tuotteet (nimi, kuvaus, varastossa, hinta, tekija_id, tyyppi_id) VALUES ('Playstation 2', 'Oli aika tykki', 90, 243, 3, 3);
INSERT INTO ostoskorit (summa, tuotteet, kayttaja_id) VALUES (0, '{}', 1);
