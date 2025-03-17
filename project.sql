DROP TABLE clienti CASCADE CONSTRAINTS;
DROP TABLE filme CASCADE CONSTRAINTS;
DROP TABLE sali CASCADE CONSTRAINTS;
DROP TABLE proiectii CASCADE CONSTRAINTS;
DROP TABLE rezervari CASCADE CONSTRAINTS;
DROP TABLE plati CASCADE CONSTRAINTS;
DROP TABLE angajati CASCADE CONSTRAINTS;


CREATE TABLE clienti (
 id_client NUMBER(7) PRIMARY KEY,
 nume_client VARCHAR2(25),
 prenume_client VARCHAR2(25),
 email_client VARCHAR(50),
 telefon_client VARCHAR2(15)
);

CREATE TABLE filme (
 id_film NUMBER(7) PRIMARY KEY,
 titlu VARCHAR2(100) NOT NULL,
 gen VARCHAR2(100),
 durata NUMBER(3) NOT NULL,
 descriere VARCHAR2(500) DEFAULT 'Descriere indisponibilă',
 data_lansare DATE
);

CREATE TABLE sali (
 id_sala NUMBER(7) PRIMARY KEY,
 nume_sala VARCHAR2(50) NOT NULL,
 capacitate NUMBER(3)
);

CREATE TABLE proiectii (
 id_proiectie NUMBER(7) PRIMARY KEY,
 id_film NUMBER(7) NOT NULL,
 id_sala NUMBER(7) NOT NULL,
 inceput TIMESTAMP NOT NULL,
 pret_bilet NUMBER,
 CONSTRAINT fk_proiectii_filme FOREIGN KEY (id_film) REFERENCES filme(id_film) ON 
DELETE CASCADE,
 CONSTRAINT fk_proiectii_sali FOREIGN KEY (id_sala) REFERENCES sali(id_sala) ON 
DELETE CASCADE
);

CREATE TABLE rezervari (
 id_rezervare NUMBER(7) PRIMARY KEY,
 id_proiectie NUMBER(7) NOT NULL,
 id_client NUMBER(7) NOT NULL,
 locuri VARCHAR2(4) NOT NULL,
 data_rezervare TIMESTAMP NOT NULL,
 locuri_rezervate NUMBER(3) DEFAULT 1,
 CONSTRAINT fk_rezervari_proiectii FOREIGN KEY (id_proiectie) REFERENCES 
proiectii(id_proiectie) ON DELETE CASCADE,
 CONSTRAINT fk_rezervari_clienti FOREIGN KEY (id_client) REFERENCES clienti(id_client) 
ON DELETE CASCADE
);

CREATE TABLE plati (
 id_plata NUMBER(7) PRIMARY KEY,
 id_rezervare NUMBER(7) NOT NULL,
 metoda_plata VARCHAR2(50) NOT NULL,
 suma_platita NUMBER(10, 2) NOT NULL,
 data_platii TIMESTAMP NOT NULL,
 status_plata VARCHAR2(20) DEFAULT 'Efectuata',
 CONSTRAINT fk_plati_rezervari FOREIGN KEY (id_rezervare) REFERENCES 
rezervari(id_rezervare)
);

/*7. Să se adauge o coloană rating în tabelul filme pentru a permite evaluarea filmelor, 
având valori între 0 și 10.*/
ALTER TABLE filme
ADD rating NUMBER(2, 1) DEFAULT 0 CHECK (rating BETWEEN 0 AND 10);

/*8. Să se șteargă coloana data_lansare din tabelul filme.*/
ALTER TABLE filme 
DROP COLUMN data_lansare;

/*9. Să se adauge o restricție în tabelul proiectii pentru a asigura că prețul biletului este 
întotdeauna pozitiv.*/
ALTER TABLE proiectii
ADD CONSTRAINT check_pret CHECK (pret_bilet > 0);

/*10. Să se șteargă restricția creata anterior.*/
ALTER TABLE proiectii
DROP CONSTRAINT check_pret;

/*11. Să se modifice lungimea coloanei telefon_client din tabelul clienti pentru a permite 
numere mai lungi, de până la 20 caractere.*/
ALTER TABLE clienti
MODIFY telefon_client NUMBER(20);

/*12. Să se adauge o restricție în tabelul sali pentru a asigura ca valoarea capacitatii este
întotdeauna pozitiva.*/
ALTER TABLE sali 
ADD CONSTRAINT check_capacitate CHECK (capacitate > 0);

/*13. Să se șteargă si apoi să se recupereze tabela de plati.*/
DROP TABLE plati;
FLASHBACK TABLE plati TO 
BEFORE DROP;

/*14. Să se redenumească coloana inceput din tabela proiectii in timp_incepere pentru a fi 
mai sugestiv.*/
ALTER TABLE proiectii
RENAME COLUMN inceput TO timp_incepere;

/*15. Să se adauge o coloana Status in tabela rezervari. Toate rezervarile au statusul 
„Confirmata”.*/
ALTER TABLE rezervari
ADD status VARCHAR2(20);
UPDATE rezervari
SET status = 'Confirmata';

/*16. 8. Să se șteargă coloana data_lansare din tabelul filme.*/
ALTER TABLE rezervari
DROP COLUMN locuri;

/*2. Să se insereze date în tabela clienti, astfel încât să fie adăugate informații despre 21 de 
clienți diferiți*/

INSERT INTO clienti (id_client, nume_client, prenume_client, email_client, telefon_client)
VALUES (700, 'Ghiță', 'Ana-Maria-Elena', 'ana.ghita@gmail.com', '0767569304');
INSERT INTO clienti (id_client, nume_client, prenume_client, email_client, telefon_client)
VALUES (701, 'Stroe', 'Mara', 'marastroe@gmail.com', '0762114347');
INSERT INTO clienti (id_client, nume_client, prenume_client, email_client, telefon_client)
VALUES (702, 'Bucse', 'Iuliana', 'iuliana.bucse@gmail.com', '0725163772');
INSERT INTO clienti (id_client, nume_client, prenume_client, email_client, telefon_client)
VALUES (703, 'Popescu', 'Alexandru', 'alex.popescu@gmail.com', '0733313849');
INSERT INTO clienti (id_client, nume_client, prenume_client, email_client, telefon_client)
VALUES (704, 'Decu', 'Mihaela', 'decu.mela@gmail.com', '0763789573');
INSERT INTO clienti (id_client, nume_client, prenume_client, email_client, telefon_client)
VALUES (705, 'Popescu', 'Marian', 'marian.popescu@gmail.com', '0723133472');
INSERT INTO clienti (id_client, nume_client, prenume_client, email_client, telefon_client)
VALUES (706, 'Rotaru', 'Anastasia', 'anastasiarot@gmail.com', '0735123442');
INSERT INTO clienti (id_client, nume_client, prenume_client, email_client, telefon_client)
VALUES (707, 'Ene', 'Mihai', 'mihai.ene@gmail.com', '0723974654');
INSERT INTO clienti (id_client, nume_client, prenume_client, email_client, telefon_client)
VALUES (708, 'Ion', 'Marcel', 'ion.marcel@gmail.com', '0739465738');
INSERT INTO clienti (id_client, nume_client, prenume_client, email_client, telefon_client)
VALUES (709, 'Selaru', 'Ruxandra', 'ruxandra.sel@gmail.com', '0725657488');
INSERT INTO clienti (id_client, nume_client, prenume_client, email_client, telefon_client)
VALUES (710, 'Nita', 'Bogdan', 'bogdan.nita@gmail.com', '0729987883');
INSERT INTO clienti (id_client, nume_client, prenume_client, email_client, telefon_client)
VALUES (711, 'Popa', 'Vlad', 'popavlad@gmail.com', '0723114347');
INSERT INTO clienti (id_client, nume_client, prenume_client, email_client, telefon_client)
VALUES (712, 'Baciu', 'Matei', 'baciu.ion@gmail.com', '0739883557');
INSERT INTO clienti (id_client, nume_client, prenume_client, email_client, telefon_client)
VALUES (713, 'Anghel', 'Alexia', 'alexia.anghel@gmail.com', '0721116768');
INSERT INTO clienti (id_client, nume_client, prenume_client, email_client, telefon_client)
VALUES (714, 'Dan', 'Adrian', 'dan.adi@gmail.com', '0721229964');
INSERT INTO clienti (id_client, nume_client, prenume_client, email_client, telefon_client)
VALUES (715, 'Eugen', 'Florin', 'florin.eug@gmail.com', '0768884213');
INSERT INTO clienti (id_client, nume_client, prenume_client, email_client, telefon_client)
VALUES (716, 'Fritu', 'Eduard', 'eduard.fritu@gmail.com', '0729904771');
INSERT INTO clienti (id_client, nume_client, prenume_client, email_client, telefon_client)
VALUES (717, 'Enache', 'Cristina', 'cristina.enache@gmail.com', '0782247885');
INSERT INTO clienti (id_client, nume_client, prenume_client, email_client, telefon_client)
VALUES (718, 'Iancu', 'Elena', 'elenaiancu@gmail.com', '0768889264');
INSERT INTO clienti (id_client, nume_client, prenume_client, email_client, telefon_client)
VALUES (719, 'Dragomir', 'Traian', 'traian.dragomir@gmail.com', '0737779375');
INSERT INTO clienti (id_client, nume_client, prenume_client, email_client, telefon_client)
VALUES (720, 'Neagu', 'Violeta', 'neagu.vio@gmail.com', '0768999545');

/*3. Să se insereze date în tabela filme, adăugând informații despre 20 de filme.*/
INSERT INTO filme (id_film, titlu, gen, durata, descriere, rating)
VALUES (1, 'Pride and Prejudice', 'Romance', 129, 'O adaptare a romanului clasic al lui Jane Austen, despre 
dragostea dintre Elizabeth Bennet și domnul Darcy.', 9.8);
INSERT INTO filme (id_film, titlu, gen, durata, descriere, rating)
VALUES (2, 'The Godfather', 'Crime', 175, 'O poveste epică despre familie și crimă organizată.', 7.2);
INSERT INTO filme (id_film, titlu, gen, durata, descriere, rating)
VALUES (3, 'The Dark Knight', 'Action', 152, 'Batman înfruntă provocările unui Gotham corupt.', 9.0);
INSERT INTO filme (id_film, titlu, gen, durata, descriere, rating)
VALUES (4, 'Guardians of the Galaxy', 'Action', 121, 'Un grup de personaje neobișnuite, incluzând un hoț 
intergalactic și un rac vorbitor, se unesc pentru a salva galaxia.', 8.0);
INSERT INTO filme (id_film, titlu, gen, durata, descriere, rating)
VALUES (5, 'Harry Potter and the Philosopher''s Stone', 'Fantasy', 152, 'Primul film din seria Harry Potter, 
unde un băiat descoperă că este un vrăjitor și începe aventura vieții la Hogwarts.', 7.6);
INSERT INTO filme (id_film, titlu, gen, durata, descriere, rating)
VALUES (6, 'Little Women', 'Drama', 135, 'O adaptare a romanului clasic despre viața a patru surori în 
America secolului XIX, explorând teme precum dragostea, ambiția și familie.', 8.3);
INSERT INTO filme (id_film, titlu, gen, durata, descriere, rating)
VALUES (7, 'The Lord of the Rings: The Return of the King', 'Adventure', 201, 'Bătălia finală pentru 
salvarea Pământului de Mijloc.', 8.9);
INSERT INTO filme (id_film, titlu, gen, durata, descriere, rating)
VALUES (8, 'The Breakfast Club', 'Drama', 97, 'Cinci liceeni petrec o zi împreună în detenție, 
descoperindu-se unii pe alții.', 7.8);
INSERT INTO filme (id_film, titlu, gen, durata, descriere, rating)
VALUES (9, 'Inception', 'Sci-Fi', 148, 'Un film despre vise și realitate.', 8.8);
INSERT INTO filme (id_film, titlu, gen, durata, descriere, rating)
VALUES (10, 'Doctor Strange', 'Action', 115, 'Un neurochirurg se transformă într-un magician puternic 
după un accident care îi distruge mâinile, învățând magia pentru a salva lumea.', 7.5);
INSERT INTO filme (id_film, titlu, gen, durata, descriere, rating)
VALUES (11, 'The Matrix', 'Sci-Fi', 136, 'O poveste despre realitate virtuală și revoluție.', 8.7);
INSERT INTO filme (id_film, titlu, gen, durata, descriere, rating)
VALUES (12, 'Sherlock Holmes', 'Mystery', 128, 'Un film plin de acțiune și mister, în care detectivul 
Sherlock Holmes și Dr. Watson investighează o conspirație periculoasă în Londra victoriană.', 7.6);
INSERT INTO filme (id_film, titlu, gen, durata, descriere, rating)
VALUES (13, 'The Great Gatsby', 'Drama', 143, 'O explorare a visului american și a tragediilor personale 
din anii 1920.', 7.2);
INSERT INTO filme (id_film, titlu, gen, durata, descriere, rating)
VALUES (14, 'Interstellar', 'Sci-Fi', 169, 'Un film despre explorarea spațiului și relațiile umane.', 9.5);
INSERT INTO filme (id_film, titlu, gen, durata, descriere, rating)
VALUES (15, 'The Avengers', 'Action', 143, 'Un grup de supereroi luptă împotriva unei amenințări globale.', 
8.0);
INSERT INTO filme (id_film, titlu, gen, durata, descriere, rating)
VALUES (16, 'Star Wars: Episode IV - A New Hope', 'Sci-Fi', 121, 'Primul episod din saga epică Star 
Wars.', 8.6);
INSERT INTO filme (id_film, titlu, gen, durata, descriere, rating)
VALUES (17, 'The Lion King', 'Animation', 88, 'O poveste despre familie și responsabilitate.', 8.5);
INSERT INTO filme (id_film, titlu, gen, durata, descriere, rating)
VALUES (18, 'Back to the Future', 'Sci-Fi', 116, 'Un tânăr călătorește în timp și schimbă istoria.', 8.5);
INSERT INTO filme (id_film, titlu, gen, durata, descriere, rating)
VALUES (19, 'The Wizard of Oz', 'Fantasy', 102, 'O fetiță ajunge într-o lume magică și încearcă să găsească 
drumul spre casă.', 8.1);
INSERT INTO filme (id_film, titlu, gen, durata, descriere, rating)
VALUES (20, 'Titanic', 'Drama', 195, 'O poveste de dragoste tragică pe celebrul vas.', 7.9);

/*4. Să se insereze date în tabela sali, adăugând informații despre 15 săli de cinema.*/
INSERT INTO sali (id_sala, nume_sala, capacitate)
VALUES (1, 'Sala 1', 150);
INSERT INTO sali (id_sala, nume_sala, capacitate)
VALUES (2, 'Sala 2', 200);
INSERT INTO sali (id_sala, nume_sala, capacitate)
VALUES (3, 'Sala 3', 120);
INSERT INTO sali (id_sala, nume_sala, capacitate)
VALUES (4, 'Sala 4', 180);
INSERT INTO sali (id_sala, nume_sala, capacitate)
VALUES (5, 'Sala 5', 220);
INSERT INTO sali (id_sala, nume_sala, capacitate)
VALUES (6, 'Sala 6', 100);
INSERT INTO sali (id_sala, nume_sala, capacitate)
VALUES (7, 'Sala 7', 250);
INSERT INTO sali (id_sala, nume_sala, capacitate)
VALUES (8, 'Sala 8', 170);
INSERT INTO sali (id_sala, nume_sala, capacitate)
VALUES (9, 'Sala 9', 190);
INSERT INTO sali (id_sala, nume_sala, capacitate)
VALUES (10, 'Sala 10', 160);
INSERT INTO sali (id_sala, nume_sala, capacitate)
VALUES (11, 'Sala 11', 220);
INSERT INTO sali (id_sala, nume_sala, capacitate)
VALUES (12, 'Sala 12', 140);
INSERT INTO sali (id_sala, nume_sala, capacitate)
VALUES (13, 'Sala 13', 230);
INSERT INTO sali (id_sala, nume_sala, capacitate)
VALUES (14, 'Sala 14', 250);
INSERT INTO sali (id_sala, nume_sala, capacitate)
VALUES (15, 'Sala 15', 180);

/*5. Să se insereze date în tabela proiectii, adăugând informații despre 17 proiectii.*/
INSERT INTO proiectii (id_proiectie, id_film, id_sala, timp_incepere, pret_bilet)
VALUES (1, 1, 1, TO_TIMESTAMP('05-01-2025 12:00', 'DD-MM-YYYY HH24:MI'), 30.0);
INSERT INTO proiectii (id_proiectie, id_film, id_sala, timp_incepere, pret_bilet)
VALUES (2, 2, 2, TO_TIMESTAMP('05-01-2025 14:30', 'DD-MM-YYYY HH24:MI'), 22.0);
INSERT INTO proiectii (id_proiectie, id_film, id_sala, timp_incepere, pret_bilet)
VALUES (3, 3, 3, TO_TIMESTAMP('05-01-2025 17:00', 'DD-MM-YYYY HH24:MI'), 20.0);
INSERT INTO proiectii (id_proiectie, id_film, id_sala, timp_incepere, pret_bilet)
VALUES (4, 4, 4, TO_TIMESTAMP('07-01-2025 15:30', 'DD-MM-YYYY HH24:MI'), 20.0);
INSERT INTO proiectii (id_proiectie, id_film, id_sala, timp_incepere, pret_bilet)
VALUES (5, 6, 5, TO_TIMESTAMP('06-01-2025 16:00', 'DD-MM-YYYY HH24:MI'), 25.0);
INSERT INTO proiectii (id_proiectie, id_film, id_sala, timp_incepere, pret_bilet)
VALUES (6, 7, 6, TO_TIMESTAMP('05-01-2025 19:00', 'DD-MM-YYYY HH24:MI'), 22.0);
INSERT INTO proiectii (id_proiectie, id_film, id_sala, timp_incepere, pret_bilet)
VALUES (7, 8, 7, TO_TIMESTAMP('08-01-2025 11:00', 'DD-MM-YYYY HH24:MI'), 18.0);
INSERT INTO proiectii (id_proiectie, id_film, id_sala, timp_incepere, pret_bilet)
VALUES (8, 9, 8, TO_TIMESTAMP('07-01-2025 13:30', 'DD-MM-YYYY HH24:MI'), 22.0);
INSERT INTO proiectii (id_proiectie, id_film, id_sala, timp_incepere, pret_bilet)
VALUES (9, 10, 9, TO_TIMESTAMP('05-01-2025 20:00', 'DD-MM-YYYY HH24:MI'), 24.0);
INSERT INTO proiectii (id_proiectie, id_film, id_sala, timp_incepere, pret_bilet)
VALUES (10, 11, 10, TO_TIMESTAMP('06-01-2025 18:30', 'DD-MM-YYYY HH24:MI'), 20.0);
INSERT INTO proiectii (id_proiectie, id_film, id_sala, timp_incepere, pret_bilet)
VALUES (11, 12, 11, TO_TIMESTAMP('08-01-2025 12:30', 'DD-MM-YYYY HH24:MI'), 21.0);
INSERT INTO proiectii (id_proiectie, id_film, id_sala, timp_incepere, pret_bilet)
VALUES (12, 13, 12, TO_TIMESTAMP('09-01-2025 14:00', 'DD-MM-YYYY HH24:MI'), 22.0);
INSERT INTO proiectii (id_proiectie, id_film, id_sala, timp_incepere, pret_bilet)
VALUES (13, 14, 13, TO_TIMESTAMP('05-01-2025 15:00', 'DD-MM-YYYY HH24:MI'), 26.0);
INSERT INTO proiectii (id_proiectie, id_film, id_sala, timp_incepere, pret_bilet)
VALUES (14, 16, 14, TO_TIMESTAMP('09-01-2025 13:00', 'DD-MM-YYYY HH24:MI'), 20.0);
INSERT INTO proiectii (id_proiectie, id_film, id_sala, timp_incepere, pret_bilet)
VALUES (15, 17, 15, TO_TIMESTAMP('06-01-2025 16:30', 'DD-MM-YYYY HH24:MI'), 18.0);
INSERT INTO proiectii (id_proiectie, id_film, id_sala, timp_incepere, pret_bilet)
VALUES (16, 18, 1, TO_TIMESTAMP('07-01-2025 17: 30', 'DD-MM-YYYY HH24:MI'), 20.0);
INSERT INTO proiectii (id_proiectie, id_film, id_sala, timp_incepere, pret_bilet)
VALUES (17, 19, 2, TO_TIMESTAMP('06-01-2025 14:30', 'DD-MM-YYYY HH24:MI'), 19.0);

/*6. Să se insereze date în tabela rezervari, adăugând informații despre 14 rezervări.*/
INSERT INTO rezervari (id_rezervare, id_proiectie, id_client, data_rezervare, locuri_rezervate)
VALUES (1000, 1, 700, TO_TIMESTAMP('05-01-2025 10:00:00', 'DD-MM-YYYY HH24:MI:SS'), 2);
INSERT INTO rezervari (id_rezervare, id_proiectie, id_client, data_rezervare, locuri_rezervate)
VALUES (1001, 5, 702, TO_TIMESTAMP('02-12-2024 11:30:00', 'DD-MM-YYYY HH24:MI:SS'), 1);
INSERT INTO rezervari (id_rezervare, id_proiectie, id_client, data_rezervare, locuri_rezervate)
VALUES (1002, 10, 703, TO_TIMESTAMP('01-01-2025 13:00:00', 'DD-MM-YYYY HH24:MI:SS'), 3);
INSERT INTO rezervari (id_rezervare, id_proiectie, id_client, data_rezervare, locuri_rezervate)
VALUES (1003, 14, 704, TO_TIMESTAMP('05-12-2024 15:00:00', 'DD-MM-YYYY HH24:MI:SS'), 2);
INSERT INTO rezervari (id_rezervare, id_proiectie, id_client, data_rezervare, locuri_rezervate)
VALUES (1004, 15, 705, TO_TIMESTAMP('02-01-2025 17:30:00', 'DD-MM-YYYY HH24:MI:SS'), 4);
INSERT INTO rezervari (id_rezervare, id_proiectie, id_client, data_rezervare, locuri_rezervate)
VALUES (1005, 1, 701, TO_TIMESTAMP('05-01-2025 10:00:00', 'DD-MM-YYYY HH24:MI:SS'), 2);
INSERT INTO rezervari (id_rezervare, id_proiectie, id_client, data_rezervare, locuri_rezervate)
VALUES (1006, 5, 702, TO_TIMESTAMP('05-01-2025 11:30:00', 'DD-MM-YYYY HH24:MI:SS'), 1);
INSERT INTO rezervari (id_rezervare, id_proiectie, id_client, data_rezervare, locuri_rezervate)
VALUES (1007, 10, 703, TO_TIMESTAMP('23-12-2024 13:00:00', 'DD-MM-YYYY HH24:MI:SS'), 3);
INSERT INTO rezervari (id_rezervare, id_proiectie, id_client, data_rezervare, locuri_rezervate)
VALUES (1008, 14, 704, TO_TIMESTAMP('04-01-2025 15:00:00', 'DD-MM-YYYY HH24:MI:SS'), 2);
INSERT INTO rezervari (id_rezervare, id_proiectie, id_client, data_rezervare, locuri_rezervate)
VALUES (1009, 12, 705, TO_TIMESTAMP('02-01-2025 17:30:00', 'DD-MM-YYYY HH24:MI:SS'), 4);
INSERT INTO rezervari (id_rezervare, id_proiectie, id_client, data_rezervare, locuri_rezervate)
VALUES (1010, 1, 701, TO_TIMESTAMP('04-01-2025 10:00:00', 'DD-MM-YYYY HH24:MI:SS'), 2);
INSERT INTO rezervari (id_rezervare, id_proiectie, id_client, data_rezervare, locuri_rezervate)
VALUES (1011, 5, 702, TO_TIMESTAMP('01-01-2025 11:30:00', 'DD-MM-YYYY HH24:MI:SS'), 1);
INSERT INTO rezervari (id_rezervare, id_proiectie, id_client, data_rezervare, locuri_rezervate)
VALUES (1012, 10, 703, TO_TIMESTAMP('02-01-2025 13:00:00', 'DD-MM-YYYY HH24:MI:SS'), 3);
INSERT INTO rezervari (id_rezervare, id_proiectie, id_client, data_rezervare, locuri_rezervate)
VALUES (1013, 14, 704, TO_TIMESTAMP('05-01-2025 15:00:00', 'DD-MM-YYYY HH24:MI:SS'), 2);
INSERT INTO rezervari (id_rezervare, id_proiectie, id_client, data_rezervare, locuri_rezervate)
VALUES (1014, 6, 705, TO_TIMESTAMP('05-01-2025 17:30:00', 'DD-MM-YYYY HH24:MI:SS'), 4);

/*7. Să se insereze date în tabela plati, adăugând informații despre plățile aferente 
rezervărilor efectuate.*/
INSERT INTO plati (id_plata, id_rezervare, metoda_plata, suma_platita, data_platii, status_plata)
SELECT 
 10000,
 r.id_rezervare,
 'card',
 r.locuri_rezervate * pr.pret_bilet AS suma_platita,
 r.data_rezervare,
 'efectuata'
FROM
 rezervari r, proiectii pr
WHERE
 r.id_proiectie = pr.id_proiectie
 AND r.id_rezervare = 1000;
INSERT INTO plati (id_plata, id_rezervare, metoda_plata, suma_platita, data_platii, status_plata)
SELECT 
 10001,
 r.id_rezervare,
 'card',
 r.locuri_rezervate * pr.pret_bilet AS suma_platita,
 r.data_rezervare,
 'efectuata'
FROM
 rezervari r, proiectii pr
WHERE
 r.id_proiectie = pr.id_proiectie
 AND r.id_rezervare = 1001;
INSERT INTO plati (id_plata, id_rezervare, metoda_plata, suma_platita, data_platii, status_plata)
SELECT
10002,
 r.id_rezervare,
 'cash',
 r.locuri_rezervate * pr.pret_bilet AS suma_platita,
 r.data_rezervare,
 'efectuata'
FROM
 rezervari r, proiectii pr
WHERE
 r.id_proiectie = pr.id_proiectie
 AND r.id_rezervare = 1002;
INSERT INTO plati (id_plata, id_rezervare, metoda_plata, suma_platita, data_platii, status_plata)
SELECT 
 10003,
 r.id_rezervare,
 'card',
 r.locuri_rezervate * pr.pret_bilet AS suma_platita,
 r.data_rezervare,
 'efectuata'
FROM
 rezervari r, proiectii pr
WHERE
 r.id_proiectie = pr.id_proiectie
 AND r.id_rezervare = 1003;
INSERT INTO plati (id_plata, id_rezervare, metoda_plata, suma_platita, data_platii, status_plata)
SELECT 
 10004,
 r.id_rezervare,
 'cash',
 r.locuri_rezervate * pr.pret_bilet AS suma_platita,
 r.data_rezervare,
 'efectuata'
FROM
 rezervari r, proiectii pr
WHERE
 r.id_proiectie = pr.id_proiectie
 AND r.id_rezervare = 1004;
INSERT INTO plati (id_plata, id_rezervare, metoda_plata, suma_platita, data_platii, status_plata)
SELECT 
 10005,
 r.id_rezervare,
 'cash',
 r.locuri_rezervate * pr.pret_bilet AS suma_platita,
 r.data_rezervare,
 'efectuata'
FROM
 rezervari r, proiectii pr
WHERE
 r.id_proiectie = pr.id_proiectie
 AND r.id_rezervare = 1005;
INSERT INTO plati (id_plata, id_rezervare, metoda_plata, suma_platita, data_platii, status_plata)
SELECT 
 10006,
 r.id_rezervare,
 'card',
 r.locuri_rezervate * pr.pret_bilet AS suma_platita,
 r.data_rezervare,
 'efectuata'
FROM
 rezervari r, proiectii pr
WHERE
 r.id_proiectie = pr.id_proiectie
 AND r.id_rezervare = 1006;
INSERT INTO plati (id_plata, id_rezervare, metoda_plata, suma_platita, data_platii, status_plata)
SELECT 
 10007,
 r.id_rezervare,
 'card',
 r.locuri_rezervate * pr.pret_bilet AS suma_platita,
 r.data_rezervare,
 'efectuata'
FROM
 rezervari r, proiectii pr
WHERE
 r.id_proiectie = pr.id_proiectie
 AND r.id_rezervare = 1007;
INSERT INTO plati (id_plata, id_rezervare, metoda_plata, suma_platita, data_platii, status_plata)
SELECT 
 10008,
 r.id_rezervare,
 'cash',
 r.locuri_rezervate * pr.pret_bilet AS suma_platita,
 r.data_rezervare,
 'efectuata'
FROM
 rezervari r, proiectii pr
WHERE
 r.id_proiectie = pr.id_proiectie
 AND r.id_rezervare = 1008;
INSERT INTO plati (id_plata, id_rezervare, metoda_plata, suma_platita, data_platii, status_plata)
SELECT 
 10009,
 r.id_rezervare,
 'cash',
 r.locuri_rezervate * pr.pret_bilet AS suma_platita,
r.data_rezervare,
 'efectuata'
FROM
 rezervari r, proiectii pr
WHERE
 r.id_proiectie = pr.id_proiectie
 AND r.id_rezervare = 1009;
INSERT INTO plati (id_plata, id_rezervare, metoda_plata, suma_platita, data_platii, status_plata)
SELECT 
 10010,
 r.id_rezervare,
 'card',
 r.locuri_rezervate * pr.pret_bilet AS suma_platita,
 r.data_rezervare,
 'efectuata'
FROM
 rezervari r, proiectii pr
WHERE
 r.id_proiectie = pr.id_proiectie
 AND r.id_rezervare = 1010;
INSERT INTO plati (id_plata, id_rezervare, metoda_plata, suma_platita, data_platii, status_plata)
SELECT 
 10011,
 r.id_rezervare,
 'card',
 r.locuri_rezervate * pr.pret_bilet AS suma_platita,
 r.data_rezervare,
 'efectuata'
FROM
 rezervari r, proiectii pr
WHERE
 r.id_proiectie = pr.id_proiectie
AND r.id_rezervare = 1011;
INSERT INTO plati (id_plata, id_rezervare, metoda_plata, suma_platita, data_platii, status_plata)
SELECT 
 10012,
 r.id_rezervare,
 'card',
 r.locuri_rezervate * pr.pret_bilet AS suma_platita,
 r.data_rezervare,
 'efectuata'
FROM
 rezervari r, proiectii pr
WHERE
 r.id_proiectie = pr.id_proiectie
 AND r.id_rezervare = 1012;
INSERT INTO plati (id_plata, id_rezervare, metoda_plata, suma_platita, data_platii, status_plata)
SELECT 
 10013,
 r.id_rezervare,
 'cash',
 r.locuri_rezervate * pr.pret_bilet AS suma_platita,
 r.data_rezervare,
 'efectuata'
FROM
 rezervari r, proiectii pr
WHERE
 r.id_proiectie = pr.id_proiectie
 AND r.id_rezervare = 1013;
INSERT INTO plati (id_plata, id_rezervare, metoda_plata, suma_platita, data_platii, status_plata)
SELECT 
 10014,
 r.id_rezervare,
 'card',
 r.locuri_rezervate * pr.pret_bilet AS suma_platita,
 r.data_rezervare,
 'efectuata'
FROM
 rezervari r, proiectii pr
WHERE
 r.id_proiectie = pr.id_proiectie
 AND r.id_rezervare = 1014;

/*8. Să se actualizeze durata filmului The Lion King la 170 de minute iar genul Aventura.
Afișeaza titlul, durata și genul filmului.*/
UPDATE filme
SET durata = 170, gen = 'Aventură'
WHERE titlu = 'The Lion King';
SELECT titlu, durata, gen FROM filme WHERE titlu = 'The Lion King';

/*9. Să se actualizeze informațiile clientului cu ID-ul 706, mai exact schimbarea email-ului 
și a numărului de telefon. După actualizare, afișați numele clientului și noile
informații.*/
SELECT nume_client, prenume_client FROM clienti
WHERE id_client = 706;
UPDATE clienti
SET email_client = 'rotaru.anastasia44@gmail.com', telefon_client = '0735123442'
WHERE id_client = 706;
SELECT nume_client, prenume_client, email_client, telefon_client FROM Clienti
WHERE ID_Client = 706;

/*10. Să se confirme toate plățile.*/
UPDATE rezervari
SET status = 'Confirmata';

/*11. Să se anuleze rezervarea cu ID 1004 și să se returneze banii clientului.*/
UPDATE plati
SET status_plata = 'Refundata'
WHERE id_rezervare = 1004;
UPDATE rezervari
SET status = 'Anulata'
WHERE id_rezervare = 1004;

/*12. Să se actualizeze filmul proiecției cu ID-ul 11, în funcție de rating. Se va proiecta unul 
dintre filmele cu ratingul cel mai mare. După actualizare, se va afișa titlul filmului, 
timpul de incepere a proiectiei si ratingul.*/
UPDATE proiectii
SET id_film = (
 SELECT id_film
 FROM (
 SELECT id_film
 FROM filme
 ORDER BY rating DESC
 )
 WHERE ROWNUM = 1
)
WHERE id_proiectie = 11;
SELECT f.titlu, p.timp_incepere, f.rating
FROM proiectii p, filme f
WHERE p.id_film = f.id_film
AND p.id_proiectie = 11;

/*13. Să se crească prețul biletelor pentru filmele de acțiune cu 10%.*/
UPDATE proiectii p
SET p.pret_bilet = p.pret_bilet + 1.10
WHERE p.id_film IN ( SELECT f.id_film 
FROM filme f WHERE f.gen = 'Action');
SELECT f.titlu, p.pret_bilet
FROM proiectii p, filme f
WHERE p.id_film = f.id_film
AND f.gen = 'Action';

/*14. Să se șteargă filmele de gen dramă care au un rating mai mic de 8.*/
DELETE FROM filme
WHERE gen = 'Drama'
AND rating < 8;
SELECT titlu, rating
FROM filme
WHERE gen = 'Drama';

/*15. Să se șteargă toate plățile care nu sunt din anul curent.*/
DELETE FROM plati
WHERE TO_CHAR(data_platii, 'YYYY') <> TO_CHAR(SYSDATE, 'YYYY');

/*16. Să se șteargă toate plățile rezervărilor anulate.*/
DELETE FROM plati
WHERE id_rezervare IN (
 SELECT id_rezervare
 FROM rezervari
 WHERE status = 'Anulata'
);

/*17. Să se șteargă rezervările care nu au o plată asociată.*/
DELETE FROM rezervari r
WHERE r.id_rezervare NOT IN (
 SELECT p.id_rezervare
 FROM plati p
);

/*18. Dacă există deja un film cu titlul "Inception", să se actualizeze durata și genul 
acestuia. Dacă nu există, să se insereze în tabelă.*/
MERGE INTO filme f
USING DUAL
ON (f.titlu = 'Inception')
WHEN MATCHED THEN
 UPDATE SET f.durata = 130
WHEN NOT MATCHED THEN
 INSERT (id_film, titlu, gen, durata, descriere, 
rating)
 VALUES (1024, 'Inception', 'Sci-Fi',
 130, 'Un film despre vise și realitate.', 8.8);

/*19. Șterge plătile clientului cu ID-ul 701. Actualizeaza statusul unei rezervări în funcție de 
starea unei plăți. Dacă nu există o plată asociata, statusul va fi „Neconfirmata”.*/
DELETE FROM plati p
WHERE p.id_rezervare IN ( SELECT 
r.id_rezervare FROM rezervari r
WHERE r.id_client = 702);
MERGE INTO rezervari r
USING (
 SELECT r.id_rezervare
 FROM rezervari r, plati p
 WHERE r.id_rezervare = 
p.id_rezervare(+)
 AND p.id_rezervare IS NULL
) np
ON (r.id_rezervare = np.id_rezervare)
WHEN MATCHED THEN
 UPDATE SET r.status = 
'Neconfirmata';

/*1. Să se automatizeze înregistrarea plăților la adăugarea unei rezervări. Plata se va realiza 
strict cu cardul.*/
--Creez o secventa pentru generarea automata a ID-urilor platilor
CREATE SEQUENCE plati_seq
START WITH 10018
INCREMENT BY 1
NOCACHE;

--Creez triggerul
CREATE TRIGGER trg_autocomplete_plati
AFTER INSERT ON rezervari
FOR EACH ROW
DECLARE
 v_pret_bilet NUMBER(10, 2);
 v_suma_platita NUMBER(10, 2);
BEGIN
 SELECT pret_bilet
INTO v_pret_bilet
 FROM proiectii
 WHERE id_proiectie = :NEW.id_proiectie;
 -- Calculeaz suma platita
 v_suma_platita := v_pret_bilet * :NEW.locuri_rezervate;
 -- Introduc automat plata
 INSERT INTO plati (id_plata, id_rezervare, metoda_plata, suma_platita, data_platii, status_plata)
 VALUES (
 plati_seq.NEXTVAL,
 :NEW.id_rezervare,
 'card',
 v_suma_platita,
 SYSDATE,
 'efectuata'
 );
END;

/*2. Să se afișeze toate filmele care au rating mai mare de 8, dar mai mic de 9.*/
SELECT titlu, rating FROM filme 
WHERE rating > 8 AND rating < 9;

/*3. Să se afișeze toate sălile care au o capacitate între 150 și 200 de locuri.*/
SELECT nume_sala, capacitate FROM sali 
WHERE capacitate BETWEEN 150 AND 200;

/*4. Să se listeze rezervările unde statusul este confirmata și care au fost făcute de clienți al
căror ID este în lista (700, 701, 702).*/
SELECT r.id_rezervare, 
r.id_proiectie, r.status, 
c.nume_client, c.prenume_client 
FROM rezervari r, clienti c
WHERE r.id_client = c.id_client
AND status = 'Confirmata' 
AND r.id_client IN (700, 701, 
702);

/*5. Să se afișeze titlul filmului, sala în care rulează și ora de început pentru toate 
proiecțiile disponibile.*/
SELECT f.titlu, s.nume_sala, 
p.timp_incepere
FROM filme f, sali s, proiectii p
WHERE f.id_film = p.id_film
 AND s.id_sala = p.id_sala;

/*6. Să se afișeze toate sălile și, dacă există, filmele care rulează în acestea. Includeți sălile 
care momentan nu au filme asociate.*/
SELECT s.nume_sala, f.titlu
FROM sali s, proiectii p, filme f
WHERE s.id_sala = p.id_sala(+)
 AND p.id_film = f.id_film(+);

/*7. Să se afișeze toate filmele și, dacă există, sălile în care acestea rulează. Includeți 
filmele care momentan nu au proiecții asociate.*/
SELECT f.titlu, s.nume_sala FROM filme f, sali s, 
proiectii p
WHERE f.id_film = p.id_film(+)
AND p.id_sala = s.id_sala(+);

/*8. Să se afișeze toate rezervările și, dacă există, plățile asociate. Includeți rezervările 
pentru care nu au fost efectuate plăți.*/
SELECT r.id_rezervare, c.nume_client, 
c.prenume_client, r.status, p.suma_platita, 
p.metoda_plata
FROM rezervari r, plati p, clienti c
WHERE c.id_client = r.id_client
AND r.id_rezervare = p.id_rezervare(+);

/*9. Să se afișeze toate filmele care rulează în săli diferite, dar cu aceeași oră de început.*/
INSERT INTO proiectii (id_proiectie, id_film, id_sala, timp_incepere, pret_bilet)
VALUES (18, 3, 1, TO_TIMESTAMP('08-01-2025 12:30', 'DD-MM-YYYY HH24:MI'), 30.0);

SELECT DISTINCT f1.titlu, 
p1.timp_incepere
FROM proiectii p1, proiectii p2, filme f1, 
filme f2
WHERE p1.timp_incepere = 
p2.timp_incepere
 AND p1.id_sala != p2.id_sala
 AND p1.id_film = f1.id_film
 AND p2.id_film = f2.id_film;

/*10. Să se calculeze numărul total de rezervări pentru fiecare film și afișați doar filmele cu 
mai mult de o rezervare.*/
SELECT f.titlu, COUNT(r.id_rezervare) AS 
total_rezervari
FROM filme f, proiectii p, rezervari r
WHERE f.id_film = p.id_film
AND p.id_proiectie = r.id_proiectie
GROUP BY f.titlu
HAVING COUNT(r.id_rezervare) > 1;

/*11. Să se afișeze numele și prenumele clienților format prin concatenare împreună cu o 
adresă de e-mail.*/
SELECT nume_client ||' '|| prenume_client AS nume,
LOWER(email_client) AS email_formatat FROM clienti;

/*12. Să se afișeze toate rezervările din ultima săptămână, extrăgând anul, luna și ziua din 
data rezervării.*/
SELECT id_rezervare, EXTRACT(YEAR FROM 
data_rezervare) AS an,
 EXTRACT(MONTH FROM data_rezervare) AS luna,
 EXTRACT(DAY FROM data_rezervare) AS zi
FROM rezervari
WHERE data_rezervare >= SYSDATE - 7;

/*13. Să se afișeze toate ID-urile clienților care au făcut rezervări, dar nu au efectuat plăți.*/
SELECT DISTINCT c.id_client
FROM clienti c, rezervari r
WHERE c.id_client = r.id_client
AND r.id_rezervare NOT IN (
 SELECT p.id_rezervare 
 FROM plati p
);

/*14. Să se afișeze titlul, genul și durata filmului care are cea mai lungă durată.*/
SELECT titlu, gen, durata FROM filme 
WHERE durata = (SELECT 
MAX(durata)FROM filme);

/*15. Să se afișeze clienții care au făcut cele mai multe rezervări.*/
SELECT id_client, COUNT(id_rezervare) AS numar_rezervari
FROM rezervari
GROUP BY id_client
HAVING COUNT(id_rezervare) = (
 SELECT MAX(cnt) 
 FROM (SELECT COUNT(id_rezervare) AS cnt 
 FROM rezervari
 GROUP BY id_client)
);

/*16. Să se creeze un index pe coloana pret_bilet din tabela proiectii pentru a optimiza 
interogările care filtrează proiectiile în funcție de preț. Afișează proiectiile unde prețul 
biletului este mai mare sau egal cu 20.*/
CREATE INDEX 
idx_pret_bilet ON 
proiectii(pret_bilet);
SELECT id_proiectie, id_film, 
id_sala, timp_incepere, 
pret_bilet
FROM proiectii
WHERE pret_bilet >= 20;

/*17. Să se creeze un sinonim privat pentru tabela clienti, numindu-l clienti_syn. Afișează 
toți clienții care au un punct in adresa de mail. */
CREATE SYNONYM clienti_syn FOR 
clienti;
SELECT id_client, nume_client, 
prenume_client, email_client
FROM clienti_syn
WHERE LENGTH(nume_client) <= 5; 

/*18. Să se afișeze toate rezervările care nu au un status specificat.*/
SELECT id_rezervare, id_client, id_proiectie
FROM rezervari
WHERE status IS NULL;

/*19. Să se afișeze toate filmele care au în descriere cuvântul "familie".*/
SELECT titlu, gen
FROM filme
WHERE LOWER(descriere) LIKE '%familie%';

/*20. Să se afișeze toți clienții al căror prenume începe cu litera "A" și conține cel puțin 
încă două caractere.*/
SELECT nume_client, prenume_client, 
email_client
FROM clienti
WHERE prenume_client LIKE 'A__%';

/*21. Să se găsească toate rezervările făcute de clienți cu adrese de email care se termină în 
gmail.com.*/
SELECT c.nume_client, c.prenume_client, 
r.id_rezervare
FROM clienti c, rezervari r
WHERE c.id_client = r.id_client
AND c.email_client LIKE '%@gmail.com';

/*22. Să se afișeze anul, luna și ziua fiecărei rezervări extrase din câmpul data_rezervare, 
utilizand SUBSTR.*/
SELECT id_rezervare,
 SUBSTR(TO_CHAR(data_rezervare, 'YYYY-MM-DD'), 
1, 4) AS an,
 SUBSTR(TO_CHAR(data_rezervare, 'YYYY-MM-DD'), 
6, 2) AS luna,
 SUBSTR(TO_CHAR(data_rezervare, 'YYYY-MM-DD'), 
9, 2) AS zi
FROM rezervari;

/*23. Să se afișeze toate rezervările care au fost făcute inainte de data de 05-01-2025.*/
SELECT id_rezervare, id_client, id_proiectie, 
data_rezervare
FROM rezervari
WHERE data_rezervare < TO_DATE('05-01-
2025', 'DD-MM-YYYY');

/*24. Să se afișeze toate proiecțiile care încep între ora 12:00 și 17:00 pe data de 05-01-
2025.*/
SELECT id_proiectie, id_film, id_sala, 
timp_incepere
FROM proiectii
WHERE timp_incepere BETWEEN 
TO_DATE('05-01-2025 12:00', 'DD-MM-YYYY HH24:MI')
AND TO_DATE('05-01-2025 17:00', 'DD-MM-YYYY HH24:MI');


/*25. Să se afișeze numele sălilor și o clasificare în funcție de capacitate.
"Mica" dacă capacitatea este sub 170.
"Medie" dacă capacitatea este între 170 și 240.
"Mare" dacă capacitatea depășește 240.*/
SELECT nume_sala, capacitate,
 DECODE(
 SIGN(capacitate - 240), 
 1, 'Mare', 
 0, 'Medie', 
 -1, DECODE(SIGN(capacitate - 170), -1, 'Mica', 
'Medie')
 ) AS categorie
FROM sali;

/*26. Să se calculeze discount-ul aplicat biletelor:
10% pentru bilete sub 20 lei.
5% pentru bilete între 20 și 30 lei.
Fără discount pentru bilete peste 30 lei.*/
SELECT id_proiectie, pret_bilet,
 DECODE(
 SIGN(pret_bilet - 30),
 1, 0,
 0, 0.05 * pret_bilet,
 -1, DECODE(SIGN(pret_bilet - 20), -1, 0.1 * pret_bilet, 
0.05 * pret_bilet)
 ) AS discount
FROM proiectii;

/*27. Să se afișeze toate filmele și indicați dacă genul acestora este unul dintre genurile 
populare ("Action", "Drama", "Sci-Fi") sau "Altul".*/
SELECT titlu, gen,
 DECODE(
 gen,
 'Action', 'Gen popular',
 'Drama', 'Gen popular',
 'Sci-Fi', 'Gen popular',
 'Altul'
 ) AS categorie_gen
FROM filme;

/*28. Să se afișeze toate filmele și asociați-leo categorie de rating: "Excelent" pentru rating 
peste 9, "Bun" pentru rating între 7.5 și 9, "Mediocru" pentru rating sub 7.5.*/
SELECT titlu, rating,
 DECODE(
 SIGN(rating - 9),
 1, 'Excelent',
 0, 'Bun',
 -1, DECODE(SIGN(rating - 7.5), -1, 
'Mediocru', 'Bun')
 ) AS categorie_rating
FROM filme;

/*29. Să se afișeze ID-ul proiecției și o clasificare a prețului biletului:"Ieftin" pentru bilete 
sub 15 lei. "Mediu" pentru bilete între 15 și 25 lei. "Scump" pentru bilete peste 25 lei.*/
SELECT id_proiectie, pret_bilet,
 CASE 
 WHEN pret_bilet < 15 THEN 'Ieftin'
 WHEN pret_bilet BETWEEN 15 AND 25 
THEN 'Mediu'
 ELSE 'Scump'
 END AS categorie_pret
FROM proiectii;

/*30. Să se afișeze ID-ul proiecției și categoria acesteia: "Dimineață" dacă începe între 
06:00 și 12:00. "După-amiază" dacă începe între 12:01 și 18:00. "Seară" dacă începe 
după ora 18:00.*/
SELECT id_proiectie, timp_incepere,
 CASE 
 WHEN EXTRACT(HOUR FROM 
timp_incepere)
BETWEEN 6 AND 12 THEN 
'Dimineață'
 WHEN EXTRACT(HOUR FROM 
timp_incepere)
BETWEEN 12 AND 18 THEN 'Dupăamiază'
 ELSE 'Seară'
 END AS categorie_timp
FROM proiectii;

/*31. Să se afișeze ID-urile rezervărilor și statusul lor, iar dacă statusul este NULL, afișați 
"Necunoscut".*/
SELECT id_rezervare, NVL(status, 'Necunoscut') AS status_final
FROM rezervari;

/*32. Să se calculeze suma totală a plăților, tratând plățile lipsă (NULL) ca 0.*/
SELECT SUM(NVL(suma_platita, 0)) AS venit_total
FROM plati;

/*33. Să se afișeze o listă combinată a clienților care au realizat rezervări și a celor care nu 
au făcut rezervări, marcând clienții fără rezervări.*/
SELECT c.id_client, c.nume_client, c.prenume_client, 'Cu 
rezervare' AS tip_client
FROM clienti c, rezervari r
WHERE c.id_client = r.id_client
UNION
SELECT c.id_client, c.nume_client, c.prenume_client, 'Fara 
rezervare' AS tip_client
FROM clienti c
WHERE NOT EXISTS (
 SELECT 1 FROM rezervari r WHERE c.id_client = 
r.id_client
);

/*34. Să se afișeze titlurile filmelor proiectate cel puțin o dată și titlurile filmelor care nu au 
fost proiectate.*/
SELECT f.titlu, 'proiectat' AS tip_film FROM 
filme f, proiectii p
WHERE f.id_film = p.id_film
UNION
SELECT f.titlu, 'neproiectat' AS tip_film FROM 
filme f
WHERE NOT EXISTS (
 SELECT 1 FROM proiectii p WHERE f.id_film 
= p.id_film);

/*35. Să se afișeze titlurile filmelor care sunt 
proiectate în săli și care au cel puțin o rezervare efectuată.*/
SELECT f.titlu FROM FILME F, PROIECTII 
P
WHERE f.id_film = p.id_film
INTERSECT
SELECT f.titlu FROM filme f, rezervari r, 
proiectii p
WHERE f.id_film = p.id_film
AND r.id_proiectie = p.id_proiectie;

/*36. Să se afișeze numele sălilor care au o capacitate mai mare decât capacitatea medie a 
tuturor sălilor.*/
SELECT nume_sala, capacitate
FROM sali s
WHERE capacitate > (SELECT AVG(capacitate) FROM sali);

/*37. Să se afișeze numarul total de locuri rezervate pt fiecare proiecție.*/
SELECT
id_proiectie,
(
SELECT COUNT(locuri_rezervate)
FROM rezervari
WHERE id_proiectie = p.id_proiectie
) AS NR_REZ
FROM
proiectii p;

/*38. Compania dorește să gestioneze ierarhia angajaților pentru a evidenția relațiile dintre 
manager și subordonați. Creează o soluție care să permită: crearea tabelei ANGAJATI, 
inserarea datelor si generarea unei ierarhii. Ulterior, sterge tabela.*/
CREATE TABLE angajati (
 id_angajat NUMBER PRIMARY KEY,
 nume_angajat VARCHAR2(50),
 prenume_angajat VARCHAR2(50),
 id_manager NUMBER,
 CONSTRAINT fk_manager FOREIGN KEY (id_manager) 
REFERENCES angajati(id_angajat)
);

INSERT INTO ANGAJATI (id_angajat, nume_angajat, prenume_angajat, id_manager) VALUES (1, 
'Popescu', 'Andrei', NULL);
INSERT INTO ANGAJATI (id_angajat, nume_angajat, prenume_angajat, id_manager) VALUES (2, 
'Ion', 'Matei', 1);
INSERT INTO ANGAJATI (id_angajat, nume_angajat, prenume_angajat, id_manager) VALUES (3, 
'Georgescu', 'Radu', 1);
INSERT INTO ANGAJATI (id_angajat, nume_angajat, prenume_angajat, id_manager) VALUES (4, 
'Dumitrescu', 'Ioana', 2);
INSERT INTO ANGAJATI (id_angajat, nume_angajat, prenume_angajat, id_manager) VALUES (5, 
'Vlad', 'Mihaela', 2);
INSERT INTO ANGAJATI (id_angajat, nume_angajat, prenume_angajat, id_manager) VALUES (6, 
'Stanciu', 'Mihai', 3);
INSERT INTO ANGAJATI (id_angajat, nume_angajat, prenume_angajat, id_manager) VALUES (7, 
'Dobre', 'Alexandru', 3);
INSERT INTO ANGAJATI (id_angajat, nume_angajat, prenume_angajat, id_manager) VALUES (8, 
'Marinescu', 'Bianca', 6);

SELECT 
 LEVEL AS NIVEL,
 LPAD(' ', LEVEL * 4) || prenume_angajat || ' ' || nume_angajat AS IERARHIE_ANGAJATI,
 SYS_CONNECT_BY_PATH(prenume_angajat || ' ' || nume_angajat, '/') AS CALE_IERARHICA
FROM angajati
START WITH id_manager IS NULL
CONNECT BY PRIOR id_angajat = id_manager;
DROP TABLE angajati;

