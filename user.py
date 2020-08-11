from db import db
from flask import session
from werkzeug.security import check_password_hash, generate_password_hash

def newUser(request):
    nimi = request.form["nimi"]
    salasana = request.form["salasana"]
    hash_value = generate_password_hash(salasana)
    sql = "INSERT INTO kayttajat (nimi, salasana, superkayttaja) VALUES (:nimi, :salasana, False)"
    db.session.execute(sql, {"nimi":nimi, "salasana":hash_value})
    db.session.commit()

def login(request):
    username = request.form["username"]
    password = request.form["password"]
    
    result = db.session.execute("SELECT salasana FROM kayttajat WHERE nimi ilike ANY (array['%s'])"%username)
    kayttaja = result.fetchone()
    if kayttaja[0] == None:
        print("lol")
    else:
        hash_value = kayttaja[0]
        if check_password_hash(hash_value,password):
            # TODO: correct username and password
            session["username"] = username
            
        else:
            print("lol")
    
def logout():
    del session["username"]