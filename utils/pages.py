from db import db

def osastoNames():
    result = db.session.execute("SELECT nimi,id FROM osastot")
    osastot = result.fetchall()
    return osastot

def osastoName(id):
    result = db.session.execute("SELECT nimi, kuvaus FROM osastot WHERE id = %d" %id)
    osastot = result.fetchall()
    return osastot

def tyypitByOsasto(id):
    result = db.session.execute("SELECT nimi, id FROM tyypit WHERE osasto_id = %d" %id)
    tyypit = result.fetchall()
    return tyypit

def tyyppiInfo(id):
    result = db.session.execute("SELECT nimi, kuvaus FROM tyypit WHERE id = %d" %id)
    tyypit = result.fetchall()
    return tyypit

def tuoteNames(id):
    result = db.session.execute("SELECT nimi, id FROM tuotteet WHERE tyyppi_id = %d" %id)
    tuotteet = result.fetchall()
    return tuotteet

def tuoteByTyyppi(id):
    result = db.session.execute("SELECT nimi, kuvaus, varastossa, hinta FROM tuotteet WHERE id = %d" %id)
    tiedot = result.fetchall()
    return tiedot

def tekijaNameByTuote(id):
    result = db.session.execute("SELECT tekija_id FROM tuotteet WHERE id = %d" %id)
    t_id = result.fetchone()
    result = db.session.execute("SELECT nimi FROM tekijat WHERE id = %d" %t_id[0])
    tekija = result.fetchone()
    return tekija

def kayttajaByName(nimi):
    result = db.session.execute("SELECT id FROM kayttajat WHERE nimi ilike ANY (array['%s'])" %nimi)
    kayttaja = result.fetchone()
    return kayttaja

def arvosteluByTuote(id):
    result = db.session.execute("SELECT kayttajat.nimi, otsikko, teksti, arvosana, paivamaara FROM arvostelut LEFT JOIN kayttajat ON kayttajat.id = arvostelut.kayttaja_id WHERE tuote_id = %d" %id)
    arvostelut = result.fetchall()
    return arvostelut

def getSumma(nimi):
    id = kayttajaByName(nimi)[0]
    result = db.session.execute("SELECT summa FROM ostoskorit WHERE kayttaja_id = %d" %id)
    summa = result.fetchall()[0]
    return summa

def koriSize(nimi):
    id = kayttajaByName(nimi)[0]
    result = db.session.execute("SELECT array_length(tuotteet,1) FROM ostoskorit WHERE kayttaja_id = %d" %id)
    koko = result.fetchall()[0]
    return koko

def koriTuotteet(nimi):
    id = kayttajaByName(nimi)[0]
    koko = koriSize(nimi)[0]
    if koko == None:
        return None
    else:
        result = db.session.execute("SELECT tuotteet[0:%d] FROM ostoskorit WHERE kayttaja_id = %d"%(koko, id))
        tuotteet = result.fetchall()[0]
        return tuotteet

def tuotteetById(idt):
    tuotteet = []
    if idt == None:
        return tuotteet
    else:
        for integer in idt[0]:
            result = db.session.execute("SELECT nimi, kuvaus, hinta, id FROM tuotteet WHERE id = %d"%integer)
            t = result.fetchall()[0]
            tuotteet.append(t)
        return tuotteet

def tuotteetPaitsi1(idt, ei_id):
    tuotteet = []
    if idt == None:
        return tuotteet
    else:
        for integer in idt[0]:
            if integer != ei_id:
                tuotteet.append(integer)
        return tuotteet