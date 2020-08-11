from app import app
import pages
import add
import user
from flask import render_template, request, redirect, session

@app.route("/")
def index():
    osastot = pages.osastoNames()
    return render_template("index.html", osastot=osastot)

@app.route("/new")
def new():
    return render_template("new.html")
    
@app.route("/luoTunnus")
def luoTunnus():
    return render_template("luoTunnus.html")

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

@app.route("/signIn",methods=["POST"])
def signIn():
    user.newUser(request)
    return redirect("/")

@app.route("/login",methods=["POST"])
def login():
    user.login(request)
    return redirect("/")

@app.route("/logout")
def logout():
    user.logout()
    return redirect("/")