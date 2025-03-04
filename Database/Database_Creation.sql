CREATE DATABASE TennisDB;
USE TennisDB;

-- Tabella Allenatore
CREATE TABLE Allenatore (
    ID INT PRIMARY KEY AUTO_INCREMENT,
    Nome VARCHAR(20) NOT NULL,
    Cognome VARCHAR(20) NOT NULL,
    Ex_giocatore BOOLEAN
);


-- Tabella Giocatore
CREATE TABLE Giocatore (
    ID INT PRIMARY KEY AUTO_INCREMENT,
    Nome VARCHAR(20) NOT NULL,
    Cognome VARCHAR(20) NOT NULL,
    Età INT,
    Punti_ottenuti INT,
    Sesso ENUM('M', 'F')                    -- Il sesso può essere solo 'M' oppure 'F'
);

-- Tabella Preparazione
CREATE TABLE Preparazione (
    Giocatore INT,
    Allenatore INT,
    Data_Inizio DATE,
    Data_Fine DATE,
    PRIMARY KEY (Giocatore, Allenatore),
    FOREIGN KEY (Giocatore) REFERENCES Giocatore(ID) ON DELETE CASCADE,
    FOREIGN KEY (Allenatore) REFERENCES Allenatore(ID) ON DELETE CASCADE
);

-- Tabella Sponsor
CREATE TABLE Sponsor (
    Nome VARCHAR(20) PRIMARY KEY,
    Tipologia VARCHAR(50),
    Motto VARCHAR(100),
    Colore VARCHAR(20)
);

-- Tabella Rappresentazione
CREATE TABLE Rappresentazione (
    Giocatore INT,
    Sponsor VARCHAR(20),
    Durata_contratto INT,
    Compenso DECIMAL(10,2),
    PRIMARY KEY (Giocatore, Sponsor),
    FOREIGN KEY (Giocatore) REFERENCES Giocatore(ID) ON DELETE CASCADE,
    FOREIGN KEY (Sponsor) REFERENCES Sponsor(Nome) ON DELETE CASCADE
);

-- Tabella Ente Organizzatore
CREATE TABLE Ente_organizzatore (
    ID INT PRIMARY KEY AUTO_INCREMENT,
    Nome VARCHAR(20) NOT NULL,
    Presidente VARCHAR(20),
    Anno YEAR,
    Sito_web VARCHAR(40),
    Primo_classificato INT,
    UNIQUE (Nome, Anno),
    FOREIGN KEY (Primo_classificato) REFERENCES Giocatore(ID) ON DELETE SET NULL
);

-- Tabella Torneo
CREATE TABLE Torneo (
    ID INT PRIMARY KEY AUTO_INCREMENT,
    Nome VARCHAR(40) NOT NULL,
    Tipologia VARCHAR(20),
    Punti INT,
    Anno YEAR,
    Premio_in_denaro DECIMAL(10,2),
    Ente_organizzatore INT,
    UNIQUE(Nome, Anno, Ente_organizzatore),
    FOREIGN KEY (Ente_organizzatore) REFERENCES Ente_organizzatore(ID) ON DELETE SET NULL
);

-- Tabella Partecipazione
CREATE TABLE Partecipazione (
    Giocatore INT,
    Torneo INT,
    Posizione INT,
    PRIMARY KEY (Giocatore, Torneo),
    FOREIGN KEY (Giocatore) REFERENCES Giocatore(ID) ON DELETE CASCADE,
    FOREIGN KEY (Torneo) REFERENCES Torneo(ID) ON DELETE CASCADE
);

-- Tabella Ranking
CREATE TABLE Ranking (
    Giocatore INT,
    Ente_organizzatore INT,
    Posizione INT,
    PRIMARY KEY (Giocatore, Ente_organizzatore),
    FOREIGN KEY (Giocatore) REFERENCES Giocatore(ID) ON DELETE CASCADE,
    FOREIGN KEY (Ente_organizzatore) REFERENCES Ente_organizzatore(ID) ON DELETE CASCADE
);

-- Tabella Partita
CREATE TABLE Partita (
    data DATE,
    ora TIME,
    Torneo INT,
    set_giocatore_1 INT,
    set_giocatore_2 INT,
    PRIMARY KEY (data, ora, Torneo),
    FOREIGN KEY (Torneo) REFERENCES Torneo(ID)
);

CREATE TABLE Incontro (
    Giocatore INT,
    Torneo INT,
    Data DATE,
    Ora TIME,
    Ruolo INT,
    Vincitore INT,
    PRIMARY KEY (Giocatore, Torneo, Data, Ora),
    FOREIGN KEY (Giocatore) REFERENCES Giocatore(ID) ON DELETE CASCADE,
    FOREIGN KEY (Torneo) REFERENCES Torneo(ID) ON DELETE CASCADE,
    FOREIGN KEY (Data, Ora, Torneo) REFERENCES Partita(Data, Ora, Torneo) ON DELETE CASCADE
);



-- Tabella Stadio
CREATE TABLE Stadio (
    Nome VARCHAR(40) PRIMARY KEY,
    Città VARCHAR(20),
    Superficie VARCHAR(20)
);

-- Tabella Dettagli Location
CREATE TABLE Dettagli_location (
    Torneo INT,
    Stadio VARCHAR(40),
    PRIMARY KEY (Torneo, Stadio),
    FOREIGN KEY (Torneo) REFERENCES Torneo(ID) ON DELETE CASCADE,
    FOREIGN KEY (Stadio) REFERENCES Stadio(Nome) ON DELETE CASCADE
);
