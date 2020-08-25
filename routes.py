from app import app
from utils import pages, add, user
import os
from flask import render_template, request, redirect, session, send_from_directory
app.add_url_rule('/favicon.ico','/favicon.ico')

@app.route('/favicon.ico')
def favicon():
    return send_from_directory(os.path.join(app.root_path, 'static'),'favicon.ico',mimetype='image/vnd.microsoft.icon')

@app.route("/")
def index():
    osastot = pages.osastoNames()
    return render_template("index.html", osastot=osastot)

@app.route("/new")
def new():
    return render_template("new.html")

@app.route("/ostoskori")
def ostoskori():
    summa = pages.getSumma(session["username"])[0]
    tuotteet = pages.tuotteetById(pages.koriTuotteet(session["username"]))

    return render_template("ostoskori.html", summa=summa, tuotteet=tuotteet)
    
@app.route("/luoTunnus/<string:error>")
def luoTunnus(error):
    return render_template("luoTunnus.html", error=error)

@app.route("/osasto/<int:id>")
def osasto(id):
    osastot = pages.osastoName(id)
    tyypit = pages.tyypitByOsasto(id)
    return render_template("osasto.html", tyypit=tyypit, osastot=osastot)

@app.route("/tyyppi/<int:id>")
def tyyppi(id):
    tyypit = pages.tyyppiInfo(id)
    tuotteet = pages.tuoteNames(id)
    return render_template("tyyppi.html", tuotteet=tuotteet, tyypit=tyypit)

@app.route("/tuote/<int:id>")
def tuote(id):
    tiedot = pages.tuoteByTyyppi(id)
    tekija = pages.tekijaNameByTuote(id)
    arvostelut = pages.arvosteluByTuote(id)
    t_id = id
    return render_template("tuote.html", tiedot=tiedot, tekija=tekija, arvostelut=arvostelut, t_id=t_id)

@app.route("/send-Ar/<int:id>", methods=["POST"])
def send_Ar(id):
    kay = pages.kayttajaByName(session["username"])[0]
    add.addArvostelu(request, kay, id)
    return redirect("/tuote/"+(str(id)))

@app.route("/send-O", methods=["POST"])
def send_O():
    add.addOsasto(request)
    return redirect("/new")

@app.route("/send-Te", methods=["POST"])
def send_Te():
    add.addTekija(request)
    return redirect("/new")

@app.route("/send-Ty", methods=["POST"])
def send_Ty():
    add.addTyyppi(request)
    return redirect("/new")

@app.route("/send-Tu", methods=["POST"])
def send_Tu():
    add.addTuote(request)
    return redirect("/new")

@app.route("/send-Ostos/<int:id>", methods=["POST"])
def send_Ostos(id):
    k_id = pages.kayttajaByName(session["username"])[0]
    koko = pages.koriSize(session["username"])[0]
    summa = pages.getSumma(session["username"])[0]
    add.lisaaKoriin(k_id, id, koko, summa)
    return redirect("/ostoskori")

@app.route("/clearKori", methods=["POST"])
def clearKori():
    id = pages.kayttajaByName(session["username"])[0]
    add.tyhjennaKori(id)
    return redirect("/ostoskori")

@app.route("/yksiPoisto/<int:id>", methods=["POST"])
def yksiPoisto(id):
    mhm_id = pages.kayttajaByName(session["username"])[0]
    tuotteet = pages.tuotteetPaitsi1(pages.koriTuotteet(session["username"]), id)
    add.tyhjennaKori(mhm_id)
    for integer in tuotteet:
        koko = pages.koriSize(session["username"])[0]
        summa = pages.getSumma(session["username"])[0]
        add.lisaaKoriin(mhm_id,integer,koko,summa)
    return redirect("/ostoskori")

@app.route("/signIn",methods=["POST"])
def signIn():
    if len(request.form["nimi"]) > 20:
        return redirect("/luoTunnus/Nimi on liian pitkä")
    if len(request.form["salasana"]) > 20:
        return redirect("/luoTunnus/Salasana on liian pitkä")
    if pages.kayttajaByName(request.form["nimi"]):
        return redirect("/luoTunnus/Käyttäjänimi on jo käytössä")
    nimi = user.newUser(request)
    add.lisaaKori(pages.kayttajaByName(nimi))
    return redirect("/")

@app.route("/log")
def log():
    return render_template("login.html")

@app.route("/login",methods=["POST"])
def login():
    user.login(request)
    return redirect("/")

@app.route("/logout")
def logout():
    user.logout()
    return redirect("/")