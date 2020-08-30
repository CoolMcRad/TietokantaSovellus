# TietokantaSovellus

## The NettiStore

Tein nettikaupan jossa on erilaisia osastoja, ei mitään kummoista.
taulut näkee siitä schema.sql tiedostosta. Sovellus on herokussa, pitää van tehdä käyttis sinne, tai käyttistä jonka annan.

## Käyttäjä

Käyttäjän voi luoda kuka vain. Paina luo tunnus, anna tunnus ja salasana sitten luo.
Voi myös käyttää; 
Tunnus: testi 
Salasana: 123

## Sivu

Sivustoon pääsee vain tunnuksilla. Pääsivulla valitaan osasto, niitä on 4, voisi olla enemmän.
Painamalla yhtä pääsee valitsemaan ala tyypin. Sen jälkeen voi valita jonkin tuotteen.
Sivun yläosassa on napit uloskirjautumiselle ja ostoskorille. 

Lisäksi oikeassa yläkulmassa on haku.
Haku etsii osastot, tyypit, tuotteet ja tekijät joilla on nimessä samoja kirjaimia kuin haussa.
Haku ei välitä isoista tai pienistä kirjaimista.
Jos haku on tyhjä se palauttaa kaiken.

Sivun alaosassa on linkki projektin githubiin.

## Käyttäjän ominaisuudet

### ostoskori

Käyttäjät voivat lisätä koriin mitä vain tuotteita, kunhan sitä on varastossa.
Tuotteet voi poistaa korista yksitellen tai kaikki kerralla.
Tuotteet voi tilata, joka vähentää tuotteiden varasto määrää.

### arvostelut

Käyttäjä voi jättää arvosteluja mihin vain tuotteeseen. Kirjaimilla on maksimimäärä molempiin syötekohtiin ja arvosana on 0 - 10.

## admin käyttäjä

Admin käyttäjää ei voi luoda toista.
Tunnus: admin
Salasana: 1234

### Lisäys

admin voi lisätä tuotteita/osastoja/tyyppejä...jne uudella napilla sivun yläosassa. Lisäyksiä on vähän kinkkistä tehdä, koska pitää katsoa että tulee oikeat id:t. Ne näkee tekijöiden ym. omilla sivuilla sivuosoitteessa. Kuvia ei voi myöskään lisätä, ne pitää lisätä paikallisesti, paitsi jos ne on jo lisätty etukäteen.

Testaus: 
Lisää uusi tyyppi, pistä nimeksi Housut (Täsmälleen tai esiladattu kuva ei toimi, iso alkukirjain). osasto_id on 1. Kuvaus voi olla mitä vain. Nyt osastossa vaatteet pitäisi olla tyyppi Housut.

Luo tekijä. Nimellä tai kuvauksella ei ole väliä.
Tee haku ja etsi lisätty tekijä. Muista sen id (Sen pitäisi olla 11).

Katso uuden Housut tyypin id (pitäisi olla 9)

Luo tuote ja laita tyypin ja tekijän id:et.
Nimi on Kiltti (Täsmälleen tai esiladattu kuva ei toimi, iso alkukirjain).

Loput voi olla mitä vain.
Tuotteen pitäisi nyt löytyä.

### Tuotteen lisäys varastoon

Admin voi lisätä tuotteen määrää varastossa tuotteen sivulla.

## Loppusana

Sivustossa on vielä ongelmia. Kirjautumisessa ei ole virheilmoituksia, mutta se ei onneksi anna erroriakaan.
Käyttäjän mod booleani jäi käyttämättä, sen piti olla alempi arvoinen admin vaikka työntekijälle.
Halusin lisätä lisää tuotteita ynnä muuta mutta siinä meni vähän tylsäksi ja niitä on kyllä tarpeeksi.
Muuten tuntuu, että aika hyvä tuli.

## Linkki sinne sivuun: https://thenettistore.herokuapp.com/