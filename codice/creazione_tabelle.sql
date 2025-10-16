-- Creazione della tabella STUDENTE
CREATE TABLE STUDENTE(
    Matricola CHAR(9) PRIMARY KEY,
    Username VARCHAR(50) NOT NULL,
    Email VARCHAR(255) NOT NULL,
    Nome VARCHAR(50) NOT NULL,
    Cognome VARCHAR(50) NOT NULL,
    Passkey VARCHAR(255) NOT NULL
);

-- Aggiunta dei vincoli a STUDENTE
ALTER TABLE STUDENTE
    -- La lunghezza dell'username deve essere compresa tra i 2 e i 50 caratteri
	ADD CONSTRAINT CheckLunghezzaUsername
		CHECK (LENGTH(Username) >= 2 AND LENGTH(Username) <= 50),
    -- La lunghezza della matriola deve essere 9 caratteri
	ADD CONSTRAINT CheckLunghezzaMatricola CHECK (LENGTH(Matricola) = 9),
    -- Ogni username deve essere unico
	ADD CONSTRAINT UniqueStudenteUsername UNIQUE (Username),
    -- Ogni email deve essere unica
	ADD CONSTRAINT UniqueStudenteEmail UNIQUE (Email);

-- Creazione della tabella CATEGORIA
CREATE TABLE CATEGORIA(
    NomeCategoria VARCHAR(100) PRIMARY KEY
);

-- Creazione della tabella OGGETTO
CREATE TABLE OGGETTO(
    idOggetto SERIAL PRIMARY KEY,
    Descrizione VARCHAR(255) NOT NULL,
    FK_NomeCategoria VARCHAR(50) NOT NULL,
    FK_Matricola CHAR(9) NOT NULL
);

-- Aggiunta dei vincoli a OGGETTO
ALTER TABLE OGGETTO
    -- Vincolo di foreign key (la chiave esterna FK_NomeCategoria che si riferisce alla PK NomeCategoria)
	ADD CONSTRAINT FK_Oggetto_Categoria FOREIGN KEY (FK_NomeCategoria)
	    REFERENCES Categoria (NomeCategoria),
    -- Vincolo di foreign key (la chiave esterna FK_Matricola che si riferisce alla PK Matricola)
	ADD CONSTRAINT FK_Oggetto_Studente FOREIGN KEY (FK_Matricola)
	    REFERENCES Studente (Matricola),
    -- Ogni oggetto deve essere unico
	ADD CONSTRAINT UniqueOggettoStudente
			UNIQUE (Descrizione, FK_NomeCategoria, FK_Matricola);

-- Creazione della tabella SEDE
CREATE TABLE SEDE(
    idSede SERIAL PRIMARY KEY,
    Ptop VARCHAR(100) NOT NULL,
    Descrizione VARCHAR(255) NOT NULL,
    Civico VARCHAR(10) NOT NULL,
    CAP CHAR(5) NOT NULL
);

-- Aggiunta dei vincoli a SEDE
ALTER TABLE SEDE
-- Ogni sede deve essere unica
ADD CONSTRAINT UniqueSede UNIQUE(Ptop, Descrizione, Civico, CAP);

-- Creazione della tabella ANNUNCIO
CREATE TABLE ANNUNCIO(
    idAnnuncio SERIAL PRIMARY KEY,
    Titolo VARCHAR(255) NOT NULL,
    StatoAnnuncio boolean NOT NULL DEFAULT true,
    FasciaOrariaInizio orario_enum NOT NULL,
    FasciaOrariaFine orario_enum NOT NULL,
    Descrizione VARCHAR(255) NOT NULL,
    Prezzo NUMERIC(10, 2),
    Tipologia tipologia_annuncio_enum NOT NULL,
    DataPubblicazione DATE NOT NULL DEFAULT CURRENT_DATE,
    FK_Matricola CHAR(9) NOT NULL,
    IdOggetto INTEGER NOT NULL,
    IdSede INTEGER NOT NULL
);

-- Aggiunta dei vincoli a ANNUNCIO
ALTER TABLE ANNUNCIO
    -- Il prezzo dell'annuncio o è NULL (in caso di annuncio di scambio o di regalo) o è positivo (in caso di annuncio di vendita)
	ADD CONSTRAINT CHK_Prezzo_Positivo CHECK (Prezzo IS NULL OR Prezzo > 0),
    -- La FasciaOrariaFine deve essere maggiore di FasciaOrariaInizio (confronto tra due valori enumerati)
	ADD CONSTRAINT CHK_Orario_Valido CHECK (FasciaOrariaInizio < FasciaOrariaFine),
    -- Vincolo di foreign key (la chiave esterna FK_Matricola che si riferisce alla PK Matricola)
	ADD CONSTRAINT FK_Annuncio_Studente FOREIGN KEY (FK_Matricola)
			REFERENCES Studente (Matricola),
    -- Vincolo di foreign key (la chiave esterna IdOggetto che si riferisce alla PK idoggetto)
	ADD CONSTRAINT FK_Annuncio_Oggetto FOREIGN KEY (IdOggetto)
			REFERENCES Oggetto (idOggetto),
    -- Vincolo di foreign key (la chiave esterna IdSede che si riferisce alla PK idsede)
	ADD CONSTRAINT FK_Annuncio_Sede FOREIGN KEY (IdSede)
	    REFERENCES Sede (idSede);

-- Creazione della tabella OFFERTA
CREATE TABLE OFFERTA(
    idOfferta SERIAL PRIMARY KEY,
    StatoOfferta stato_offerta_enum NOT NULL DEFAULT 'attesa',
    PrezzoOfferta NUMERIC(10, 2),
    Motivazione VARCHAR(255),
    Tipologia VARCHAR(50) NOT NULL,
    DataInvio DATE NOT NULL DEFAULT CURRENT_DATE,
    FK_Matricola CHAR(9) NOT NULL,
    IdAnnuncio INTEGER NOT NULL
);

-- Aggiunta dei vincoli a OFFERTA
ALTER TABLE OFFERTA
    -- Il PrezzoOfferto o è NULL (in caso di offerta di scambio o di regalo) o è positivo (in caso di offerta di vendita)
	ADD CONSTRAINT CHK_PrezzoOfferta_Positivo
			CHECK (PrezzoOfferta IS NULL OR PrezzoOfferta > 0),
    -- Vincolo di foreign key (la chiave esterna FK_Matricola che si riferisce alla PK Matricola)
	ADD CONSTRAINT FK_Offerta_Studente FOREIGN KEY (FK_Matricola)
	    REFERENCES Studente (Matricola),
    -- Vincolo di foreign key (la chiave esterna IdAnnuncio che si riferisce alla PK idannuncio)
	ADD CONSTRAINT FK_Offerta_Annuncio FOREIGN KEY (IdAnnuncio)
	    REFERENCES Annuncio (idAnnuncio),
    -- Ogni offerta inviata da uno studente verso un annuncio deve essere unica
	ADD CONSTRAINT UniqueOffertaInviata UNIQUE(FK_Matricola, IdAnnuncio);

-- Creazione della tabella OGGETTIOFFERTI
CREATE TABLE OGGETTIOFFERTI(
    IdOfferta INTEGER NOT NULL,
    IdOggetto INTEGER NOT NULL,

    PRIMARY KEY (IdOfferta, IdOggetto)
);

-- Aggiunta dei vincoli a OGGETTIOFFERTI
ALTER TABLE OGGETTIOFFERTI
    -- Vincolo di foreign key (la chiave esterna IdOfferta che si riferisce alla PK idofferta)
	ADD CONSTRAINT FK_OggettiOfferti_Offerta FOREIGN KEY (IdOfferta)
	    REFERENCES Offerta (idOfferta),
    -- Vincolo di foreign key (la chiave esterna IdOggetto che si riferisce alla PK idoggetto)
	ADD CONSTRAINT FK_OggettiOfferti_Oggetto FOREIGN KEY (IdOggetto)
	    REFERENCES Oggetto (idOggetto);