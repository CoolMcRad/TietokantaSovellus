from db import db
from flask import session
from werkzeug.security import check_password_hash, generate_password_hash

def newUser(request):
    nimi = request.form["nimi"]
    salasana = request.form["salasana"]
    hash_value = generate_password_hash(salasana)
    if nimi == "admin":
        sql = "INSERT INTO kayttajat (nimi, salasana, mod, superkayttaja) VALUES (:nimi, :salasana, True, True)"
        db.session.execute(sql, {"nimi":nimi, "salasana":hash_value})
        db.session.commit()
        return nimi
    else:
        sql = "INSERT INTO kayttajat (nimi, salasana, mod, superkayttaja) VALUES (:nimi, :salasana, False, False)"
        db.session.execute(sql, {"nimi":nimi, "salasana":hash_value})
        db.session.commit()
        return nimi

def login(request):
    username = request.form["username"]
    password = request.form["password"]
    
    result = db.session.execute("SELECT salasana FROM kayttajat WHERE nimi ilike ANY (array['%s'])"%username)
    kayttaja = result.fetchone()
    if kayttaja == None:
        print("lol")
    else:
        hash_value = kayttaja[0]
        if check_password_hash(hash_value,password):
            session["username"] = username
            
            result = db.session.execute("SELECT mod FROM kayttajat WHERE nimi ilike ANY (array['%s'])"%username)
            mod = result.fetchone()
            session["mod"] = mod[0]
            result = db.session.execute("SELECT superkayttaja FROM kayttajat WHERE nimi ilike ANY (array['%s'])"%username)
            superK = result.fetchone()
            session["super"] = superK[0]
            
        else:
            print("lol")
    
def logout():
    del session["username"]