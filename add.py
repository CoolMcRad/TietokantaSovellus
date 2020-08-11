from db import db
from flask import render_template, request, session

def addOsasto(request):
    nimi = request.form["nimi"]
    kuvaus = request.form["kuvaus"]
    sql = "INSERT INTO osastot (nimi, kuvaus) VALUES (:nimi, :kuvaus)"
    db.session.execute(sql, {"nimi":nimi, "kuvaus":kuvaus})
    db.session.commit()

def addTekija(request):
    nimi = request.form["nimi"]
    kuvaus = request.form["kuvaus"]
    sql = "INSERT INTO tekijat (nimi, kuvaus) VALUES (:nimi, :kuvaus)"
    db.session.execute(sql, {"nimi":nimi, "kuvaus":kuvaus})
    db.session.commit()

def addTyyppi(request):
    nimi = request.form["nimi"]
    kuvaus = request.form["kuvaus"]
    osasto_id = request.form["osasto_id"]
    sql = "INSERT INTO tyypit (nimi, kuvaus, osasto_id) VALUES (:nimi, :kuvaus, :osasto_id)"
    db.session.execute(sql, {"nimi":nimi, "kuvaus":kuvaus, "osasto_id":osasto_id})
    db.session.commit()

def addTuote(request):
    nimi = request.form["nimi"]
    kuvaus = request.form["kuvaus"]
    tyyppi_id = request.form["tyyppi_id"]
    tekija_id = request.form["tekija_id"]
    hinta = request.form["hinta"]
    varastossa = request.form["varastossa"]
    sql = "INSERT INTO tuotteet (nimi, kuvaus, tyyppi_id, tekija_id, varastossa, hinta) VALUES (:nimi, :kuvaus, :tyyppi_id, :tekija_id, :varastossa, :hinta)"
    db.session.execute(sql, {"nimi":nimi, "kuvaus":kuvaus, "tyyppi_id":tyyppi_id, "tekija_id":tekija_id, "hinta":hinta, "varastossa":varastossa})
    db.session.commit()

def addArvostelu(request, user, id):
    otsikko = request.form["otsikko"]
    teksti = request.form["teksti"]
    arvosana = request.form["arvosana"]
    kayttaja_id = str(user)
    tuote_id = str(id)
    sql = "INSERT INTO arvostelut (otsikko, teksti, arvosana, kayttaja_id, tuote_id, paivamaara) VALUES (:otsikko, :teksti, :arvosana, :kayttaja_id, :tuote_id, NOW())"
    db.session.execute(sql, {"otsikko":otsikko, "teksti":teksti, "arvosana":arvosana, "kayttaja_id":kayttaja_id, "tuote_id":tuote_id})
    db.session.commit()