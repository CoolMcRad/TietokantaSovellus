from flask import Flask
from flask import redirect, render_template, request, session
from flask_sqlalchemy import SQLAlchemy
from os import getenv

app = Flask(__name__)
app.config["SQLALCHEMY_DATABASE_URI"] = getenv("DATABASE_URL")
app.config["SQLALCHEMY_TRACK_MODIFICATIONS"] = False
app.secret_key = getenv("SECRET_KEY")
db = SQLAlchemy(app)

@app.route("/")
def index():
    result = db.session.execute("SELECT nimi FROM osastot")
    osastot = result.fetchall()
    result = db.session.execute("SELECT id FROM osastot")
    os_id = result.fetchall()
    return render_template("index.html", os_id=os_id, osastot=osastot)

@app.route("/new")
def new():
    return render_template("new.html")

@app.route("/osasto/[(<int:id>,)]")
def osasto(id):
    result = db.session.execute("SELECT nimi FROM tyypit WHERE osasto_id = 1")
    tyypit = result.fetchall()
    result = db.session.execute("SELECT id FROM tyypit WHERE osasto_id = 1")
    ty_id = result.fetchall()
    return render_template("osasto.html", ty_id=ty_id, tyypit=tyypit)

@app.route("/tyyppi/[(<int:id>,)]")
def tyyppi(id):
    result = db.session.execute("SELECT nimi FROM tuotteet WHERE tyyppi_id = 1")
    tuotteet = result.fetchall()
    result = db.session.execute("SELECT id FROM tuotteet WHERE tyyppi_id = 1")
    tu_id = result.fetchall()
    return render_template("tyyppi.html", tu_id=tu_id, tuotteet=tuotteet)

@app.route("/tuote/[(<int:id>,)]")
def tuote(id):
    result = db.session.execute("SELECT nimi FROM tuotteet WHERE id = 1")
    nimi = result.fetchone()
    result = db.session.execute("SELECT kuvaus FROM tuotteet WHERE id = 1")
    kuvaus = result.fetchone()
    result = db.session.execute("SELECT varastossa FROM tuotteet WHERE id = 1")
    varastossa = result.fetchone()
    result = db.session.execute("SELECT hinta FROM tuotteet WHERE id = 1")
    hinta = result.fetchone()
    result = db.session.execute("SELECT nimi FROM tekijat WHERE id = 1")
    tekija = result.fetchone()
    return render_template("tuote.html", nimi=nimi, kuvaus=kuvaus, varastossa=varastossa, hinta=hinta, tekija=tekija)

@app.route("/send", methods=["POST"])
def send():
    content = request.form["content"]
    sql = "INSERT INTO messages (content) VALUES (:content)"
    db.session.execute(sql, {"content":content})
    db.session.commit()
    return redirect("/")

@app.route("/login",methods=["POST"])
def login():
    username = request.form["username"]
    password = request.form["password"]
    # TODO: check username and password
    session["username"] = username
    return redirect("/")

@app.route("/logout")
def logout():
    del session["username"]
    return redirect("/")