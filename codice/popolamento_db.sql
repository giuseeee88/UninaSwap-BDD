-- POPOLAMENTO STUDENTE
INSERT INTO STUDENTE(Matricola, Username, Email, Nome, Cognome, Passkey) VALUES
('000000001', 'alice123', 'alice@mail.com', 'Alice', 'Rossi', 'ciaoalice'),
('000000002', 'bob456', 'bob@mail.com', 'Bob', 'Bianchi', 'ciaobob'),
('000000003', 'carla789', 'carla@mail.com', 'Carla', 'Verdi', 'ciaocarla');

-- POPOLAMENTO CATEGORIA
INSERT INTO CATEGORIA(NomeCategoria) VALUES
('Elettronica'),
('Libri'),
('Abbigliamento'),
('Sport');

-- POPOLAMENTO OGGETTO
INSERT INTO OGGETTO(Descrizione, FK_NomeCategoria, FK_Matricola) VALUES
('Macbook pro m4', 'Elettronica', '000000001'),
('Libro "SQL Avanzato"', 'Libri', '000000002'),
('Felpa Nike Blu', 'Abbigliamento', '000000003'),
('Pallone da calcio Adidas', 'Sport', '000000001');

-- POPOLAMENTO SEDE
INSERT INTO SEDE(Ptop, Descrizione, Civico, CAP) VALUES
('Piazza Università', 'Edificio Centrale', '1', '00100'),
('Via Roma', 'Biblioteca', '12', '00121'),
('Viale Sportivo', 'Palestra', '5', '00135');

-- POPOLAMENTO ANNUNCIO
INSERT INTO ANNUNCIO(Titolo, FasciaOrariaInizio, FasciaOrariaFine, Descrizione, Prezzo, Tipologia, FK_Matricola, IdOggetto, IdSede) VALUES
('Vendo Macbook pro m4', '10:00', '12:00', 'Perfetto stato, usato poco', 900.00, 'vendita', '000000001', 1, 1),
('Scambio Libro SQL', '14:00', '16:00', 'Cerco libri di Python in cambio', NULL, 'scambio', '000000002', 2, 2),
('Regalo Felpa Nike', '09:00', '11:00', 'Taglia M, ottime condizioni', NULL, 'regalo', '000000003', 3, 3),
('Vendo Pallone Adidas', '15:00', '17:00', 'Nuovo, mai usato', 25.50, 'vendita', '000000001', 4, 3);

-- POPOLAMENTO OFFERTA
INSERT INTO OFFERTA(StatoOfferta, PrezzoOfferta, Motivazione, Tipologia, FK_Matricola, IdAnnuncio) VALUES
('attesa', 850.00, 'Interessato al macbook', 'vendita', '000000002', 1),
('attesa', NULL, 'Propongo scambio con libro di Java', 'scambio', '000000003', 2),
('attesa', NULL, 'Vorrei ricevere la felpa', 'regalo', '000000001', 3),
('attesa', 20.00, 'Offerta per pallone', 'vendita', '000000003', 4);

-- POPOLAMENTO OGGETTIOFFERTI
INSERT INTO OGGETTIOFFERTI(IdOfferta, IdOggetto) VALUES
(2, 2),
(3, 3);