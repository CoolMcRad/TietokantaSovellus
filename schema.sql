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
    nimi TEXT UNIQUE, 
    salasana TEXT,
    superkayttaja BOOLEAN
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