-- Inserimento Giocatori

INSERT INTO Giocatore (Nome, Cognome, Età, Punti_ottenuti, Sesso)  
VALUES  
('Novak', 'Djokovic', 36, 0, 'M'),  
('Rafael', 'Nadal', 37, 0, 'M'),  
('Carlos', 'Alcaraz', 20, 0, 'M'),  
('Jannik', 'Sinner', 22, 0, 'M'),  
('Daniil', 'Medvedev', 28, 0, 'M'),  
('Stefanos', 'Tsitsipas', 25, 0, 'M'),  
('Alexander', 'Zverev', 26, 0, 'M'),  
('Andrey', 'Rublev', 26, 0, 'M'),  
('Holger', 'Rune', 20, 0, 'M'),  
('Taylor', 'Fritz', 26, 0, 'M'),  
('Iga', 'Swiatek', 22, 0, 'F'),  
('Aryna', 'Sabalenka', 25, 0, 'F'),  
('Coco', 'Gauff', 19, 0, 'F'),  
('Elena', 'Rybakina', 24, 0, 'F'),  
('Jessica', 'Pegula', 29, 0, 'F'),  
('Ons', 'Jabeur', 29, 0, 'F'),  
('Maria', 'Sakkari', 28, 0, 'F'),  
('Marketa', 'Vondrousova', 24, 0, 'F'),  
('Karolina', 'Muchova', 27, 0, 'F'),  
('Jelena', 'Ostapenko', 26, 0, 'F');

-- Inserimento Allenatori
INSERT INTO Allenatore (Nome, Cognome, Ex_giocatore)  
VALUES  
('Marian', 'Vajda', 1),  
('Carlos', 'Moya', 1),  
('Juan', 'Carlos Ferrero', 1),  
('Simone', 'Vagnozzi', 1),  
('Gilles', 'Cervara', 0),  
('Patrick', 'Mouratoglou', 0),  
('Darren', 'Cahill', 1),  
('Toni', 'Nadal', 1),  
('Ivan', 'Lendl', 1),  
('Brad', 'Gilbert', 1);


-- Inserimento per la tabella Preparazione
INSERT INTO Preparazione (Giocatore, Allenatore, Data_Inizio, Data_Fine)  
VALUES  
(1, 1, '2023-01-01', '2023-06-01'),  -- Novak Djokovic con Marian Vajda
(2, 2, '2023-02-01', '2023-08-01'),  -- Rafael Nadal con Carlos Moya
(3, 3, '2023-05-01', '2023-09-01'),  -- Carlos Alcaraz con Juan Carlos Ferrero
(4, 4, '2023-03-01', '2023-07-01'),  -- Jannik Sinner con Simone Vagnozzi
(5, 5, '2023-04-01', '2023-10-01'),  -- Daniil Medvedev con Gilles Cervara
(6, 6, '2023-06-01', '2023-11-01'),  -- Stefanos Tsitsipas con Patrick Mouratoglou
(7, 7, '2023-07-01', '2023-12-01'),  -- Alexander Zverev con Darren Cahill
(8, 8, '2023-01-01', '2023-06-01'),  -- Andrey Rublev con Toni Nadal
(9, 9, '2023-02-01', '2023-07-01'),  -- Holger Rune con Ivan Lendl
(10, 10, '2023-03-01', '2023-08-01'), -- Taylor Fritz con Brad Gilbert
(11, 1, '2023-05-01', '2023-09-01'), -- Iga Swiatek con Marian Vajda
(12, 2, '2023-06-01', '2023-10-01'), -- Aryna Sabalenka con Carlos Moya
(13, 3, '2023-07-01', '2023-11-01'), -- Coco Gauff con Juan Carlos Ferrero
(14, 4, '2023-08-01', '2023-12-01'), -- Elena Rybakina con Simone Vagnozzi
(15, 5, '2023-02-01', '2023-06-01'), -- Jessica Pegula con Gilles Cervara
(16, 6, '2023-04-01', '2023-09-01'), -- Ons Jabeur con Patrick Mouratoglou
(17, 7, '2023-01-01', '2023-05-01'), -- Maria Sakkari con Darren Cahill
(18, 8, '2023-03-01', '2023-08-01'), -- Marketa Vondrousova con Toni Nadal
(19, 9, '2023-05-01', '2023-09-01'), -- Karolina Muchova con Ivan Lendl
(20, 10, '2023-07-01', '2023-11-01'); -- Jelena Ostapenko con Brad Gilbert

-- Inserimento sponsor
INSERT INTO Sponsor (Nome, Tipologia, Motto, Colore)  
VALUES  
('Nike', 'Abbigliamento sportivo', 'Just Do It', 'Nero'),  
('Adidas', 'Abbigliamento sportivo', 'Impossible is Nothing', 'Bianco'),  
('Wilson', 'Attrezzatura sportiva', 'Every Match Starts with Wilson', 'Blu'),  
('Head', 'Attrezzatura sportiva', 'Take the Lead', 'Nero'),  
('Puma', 'Abbigliamento sportivo', 'Forever Faster', 'Giallo'),  
('Rolex', 'Orologi di lusso', 'A Crown for Every Achievement', 'Oro'),  
('Pepsi', 'Bevande', 'Live for Now', 'Blu'),  
('Red Bull', 'Bevande energetiche', 'Red Bull gives you wings', 'Rosso'),  
('Emirates', 'Compagnie aeree', 'Fly Better', 'Rosso'),  
('UBS', 'Servizi finanziari', 'We will not rest', 'Blu'),  
('Audi', 'Automobili', 'Vorsprung durch Technik', 'Argento'),  
('Coca-Cola', 'Bevande', 'Taste the Feeling', 'Rosso'),  
('Asics', 'Abbigliamento sportivo', 'Anima e corpo', 'Blu'),  
('Babolat', 'Attrezzatura sportiva', 'Born to Play', 'Blu'),  
('Lacoste', 'Abbigliamento', 'Life is a Beautiful Sport', 'Verde'),  
('Unilever', 'Prodotti di consumo', 'Making Sustainable Living Commonplace', 'Blu'),  
('Mercedes-Benz', 'Automobili', 'The Best or Nothing', 'Argento'),  
('Hublot', 'Orologi di lusso', 'Be the first to experience', 'Nero'),  
('Samsung', 'Tecnologia', 'Imagine the Possibilities', 'Nero'),  
('American Express', 'Servizi finanziari', 'Don t Leave Home Without It', 'Blu');

-- Inserimento per la tabella rappresentazione
INSERT INTO Rappresentazione (Giocatore, Sponsor, Durata_contratto, Compenso)  
VALUES  
(1, 'Nike', 3, 15000000.00),  -- Novak Djokovic è sponsorizzato da Nike per 3 anni con un compenso di 15 milioni.
(2, 'Adidas', 5, 12000000.00),  -- Rafael Nadal è sponsorizzato da Adidas per 5 anni con un compenso di 12 milioni.
(3, 'Wilson', 2, 8000000.00),  -- Carlos Alcaraz è sponsorizzato da Wilson per 2 anni con un compenso di 8 milioni.
(4, 'Head', 4, 7000000.00),  -- Jannik Sinner è sponsorizzato da Head per 4 anni con un compenso di 7 milioni.
(5, 'Puma', 2, 6000000.00),  -- Daniil Medvedev è sponsorizzato da Puma per 2 anni con un compenso di 6 milioni.
(6, 'Rolex', 4, 10000000.00),  -- Stefanos Tsitsipas è sponsorizzato da Rolex per 4 anni con un compenso di 10 milioni.
(7, 'Pepsi', 3, 5000000.00),  -- Alexander Zverev è sponsorizzato da Pepsi per 3 anni con un compenso di 5 milioni.
(8, 'Red Bull', 2, 4500000.00),  -- Andrey Rublev è sponsorizzato da Red Bull per 2 anni con un compenso di 4.5 milioni.
(9, 'Emirates', 3, 11000000.00),  -- Holger Rune è sponsorizzato da Emirates per 3 anni con un compenso di 11 milioni.
(10, 'UBS', 2, 4000000.00),  -- Taylor Fritz è sponsorizzato da UBS per 2 anni con un compenso di 4 milioni.
(11, 'Nike', 3, 13000000.00),  -- Iga Swiatek è sponsorizzata da Nike per 3 anni con un compenso di 13 milioni.
(12, 'Adidas', 5, 9000000.00),  -- Aryna Sabalenka è sponsorizzata da Adidas per 5 anni con un compenso di 9 milioni.
(13, 'Coca-Cola', 4, 5500000.00),  -- Coco Gauff è sponsorizzata da Coca-Cola per 4 anni con un compenso di 5.5 milioni.
(14, 'Asics', 2, 3500000.00),  -- Elena Rybakina è sponsorizzata da Asics per 2 anni con un compenso di 3.5 milioni.
(15, 'Babolat', 3, 8000000.00),  -- Jessica Pegula è sponsorizzata da Babolat per 3 anni con un compenso di 8 milioni.
(16, 'Lacoste', 2, 4500000.00),  -- Ons Jabeur è sponsorizzata da Lacoste per 2 anni con un compenso di 4.5 milioni.
(17, 'Red Bull', 2, 7000000.00),  -- Maria Sakkari è sponsorizzata da Red Bull per 2 anni con un compenso di 7 milioni.
(18, 'Wilson', 3, 6000000.00),  -- Marketa Vondrousova è sponsorizzata da Wilson per 3 anni con un compenso di 6 milioni.
(19, 'Rolex', 4, 15000000.00),  -- Karolina Muchova è sponsorizzata da Rolex per 4 anni con un compenso di 15 milioni.
(20, 'American Express', 2, 5000000.00);  -- Jelena Ostapenko è sponsorizzata da American Express per 2 anni con un compenso di 5 milioni.

-- Inserimento degli enti organizzatori
INSERT INTO Ente_Organizzatore (Nome, Presidente, Anno, Sito_web)  
VALUES  
('ATP', 'Andrea Gaudenzi', 2025, 'https://www.atptour.com'),  -- ATP, Associazione dei professionisti del tennis maschile.
('WTA', 'Mickey Lawler', 2025, 'https://www.wtatennis.com'),  -- WTA, Associazione delle tenniste professioniste femminili.
('ITF', 'David Haggerty', 2025, 'https://www.itftennis.com');  -- ITF, Federazione Internazionale Tennis.

-- Inserimento dei tornei
INSERT INTO Torneo (Nome, Tipologia, Punti, Anno, Premio_in_denaro, Ente_organizzatore)  
VALUES  
('Australian Open', 'Grand Slam', 2000, 2025, 7500000.00, 1),  -- ATP
('French Open', 'Grand Slam', 2000, 2025, 22000000.00, 1),  -- ATP
('Wimbledon', 'Grand Slam', 2000, 2025, 15000000.00, 1),  -- ATP
('US Open', 'Grand Slam', 2000, 2025, 57000000.00, 1),  -- ATP
('Roland Garros', 'ATP Masters 1000', 1000, 2025, 800000.00, 1),  -- ATP
('Indian Wells', 'ATP Masters 1000', 1000, 2025, 800000.00, 1),  -- ATP
('Miami Open', 'ATP Masters 1000', 1000, 2025, 600000.00, 1),  -- ATP
('Monte Carlo Masters', 'ATP Masters 1000', 1000, 2025, 1000000.00, 1),  -- ATP
('Madrid Open', 'ATP Masters 1000', 1000, 2025, 900000.00, 1),  -- ATP
('Rome Masters', 'ATP Masters 1000', 1000, 2025, 950000.00, 1),  -- ATP
('Canadian Open', 'ATP Masters 1000', 1000, 2025, 750000.00, 1),  -- ATP
('Cincinnati Open', 'ATP Masters 1000', 1000, 2025, 850000.00, 1),  -- ATP
('Shanghai Masters', 'ATP Masters 1000', 1000, 2025, 1000000.00, 1),  -- ATP
('Paris Masters', 'ATP Masters 1000', 1000, 2025, 1200000.00, 1),  -- ATP
('Stuttgart Open', 'WTA 500', 500, 2025, 600000.00, 2),  -- WTA
('Miami Open', 'WTA 1000', 1000, 2025, 1200000.00, 2),  -- WTA
('Indian Wells', 'WTA 1000', 1000, 2025, 1400000.00, 2),  -- WTA
('Dubai Tennis Championships', 'WTA 1000', 1000, 2025, 2000000.00, 2),  -- WTA
('Rome Open', 'WTA 1000', 1000, 2025, 1000000.00, 2),  -- WTA
('Madrid Open', 'WTA 1000', 1000, 2025, 900000.00, 2),  -- WTA
('Australian Open', 'WTA 500', 500, 2025, 850000.00, 2),  -- WTA
('Charleston Open', 'WTA 500', 500, 2025, 750000.00, 2),  -- WTA
('Eastbourne International', 'WTA 500', 500, 2025, 700000.00, 2),  -- WTA
('Tokyo Open', 'WTA 500', 500, 2025, 650000.00, 2),  -- WTA
('New Haven Open', 'WTA 500', 500, 2025, 600000.00, 2),  -- WTA
('Sydney International', 'WTA 250', 250, 2025, 350000.00, 2),  -- WTA
('Acapulco Open', 'ATP 500', 500, 2025, 600000.00, 1),  -- ATP
('Rio Open', 'ATP 500', 500, 2025, 700000.00, 1),  -- ATP
('Hamburg Open', 'ATP 500', 500, 2025, 550000.00, 1),  -- ATP
('Washington Open', 'ATP 500', 500, 2025, 450000.00, 1),  -- ATP
('Delray Beach Open', 'ATP 250', 250, 2025, 350000.00, 1),  -- ATP
('Sydney International', 'ATP 250', 250, 2025, 300000.00, 1),  -- ATP
('Chengdu Open', 'ATP 250', 250, 2025, 250000.00, 1),  -- ATP
('Kitzbuhel Open', 'ATP 250', 250, 2025, 400000.00, 1),  -- ATP
('Los Cabos Open', 'ATP 250', 250, 2025, 450000.00, 1),  -- ATP
('Gstaad Open', 'ATP 250', 250, 2025, 300000.00, 1),  -- ATP
('St. Petersburg Open', 'WTA 250', 250, 2025, 250000.00, 2),  -- WTA
('Prague Open', 'WTA 250', 250, 2025, 200000.00, 2),  -- WTA
('Luxembourg Open', 'WTA 250', 250, 2025, 220000.00, 2),  -- WTA
('Hong Kong Open', 'WTA 250', 250, 2025, 300000.00, 2),  -- WTA
('Birmingham Classic', 'WTA 250', 250, 2025, 270000.00, 2),  -- WTA
('Nottingham Open', 'WTA 250', 250, 2025, 250000.00, 2),  -- WTA
('Seoul Open', 'WTA 250', 250, 2025, 200000.00, 2),  -- WTA
('Nanchang Open', 'WTA 250', 250, 2025, 180000.00, 2),  -- WTA
('Guangzhou Open', 'WTA 250', 250, 2025, 150000.00, 2),  -- WTA
('Taipei Open', 'WTA 250', 250, 2025, 220000.00, 2),  -- WTA
('Tashkent Open', 'WTA 250', 250, 2025, 190000.00, 2),  -- WTA
('Wuhan Open', 'WTA 250', 250, 2025, 240000.00, 2),  -- WTA
('Coppa Davis', 'Team Competition', 100, 2025, 0.00, 3);  -- ITF


-- Inserimento nella tabella Partecipazione
INSERT INTO Partecipazione (Giocatore, Torneo, Posizione)
VALUES
(1, 1, 1),  -- Giocatore1 vince Australian Open (Posizione 1)
(1, 2, 2),  -- Giocatore1 arriva in finale al French Open (Posizione 2)
(2, 3, 1),  -- Giocatore2 vince Wimbledon (Posizione 1)
(2, 4, 2),  -- Giocatore2 arriva in finale al US Open (Posizione 2)
(3, 1, 4),  -- Giocatore3 arriva ai quarti all'Australian Open (Posizione 4)
(3, 2, 8),  -- Giocatore3 arriva agli ottavi al French Open (Posizione 8)
(4, 3, 2),  -- Giocatore4 arriva in finale a Wimbledon (Posizione 2)
(4, 4, 4),  -- Giocatore4 arriva in semifinale al US Open (Posizione 4)
(5, 5, 1),  -- Giocatore5 vince Roland Garros (Posizione 1)
(5, 6, 2),  -- Giocatore5 arriva in finale a Indian Wells (Posizione 2)
(6, 7, 4),  -- Giocatore6 arriva in semifinale a Miami Open (Posizione 4)
(6, 8, 2),  -- Giocatore6 arriva in finale a Monte Carlo (Posizione 2)
(7, 9, 8),  -- Giocatore7 arriva ai quarti a Madrid Open (Posizione 8)
(7, 10, 1),  -- Giocatore7 vince Rome Masters (Posizione 1)
(8, 11, 4),  -- Giocatore8 arriva in semifinale a Canadian Open (Posizione 4)
(8, 12, 2),  -- Giocatore8 arriva in finale a Cincinnati Open (Posizione 2)
(9, 13, 1),  -- Giocatore9 vince Shanghai Masters (Posizione 1)
(9, 14, 4),  -- Giocatore9 arriva in semifinale a Paris Masters (Posizione 4)
(10, 15, 8),  -- Giocatore10 arriva ai quarti a Stuttgart Open (Posizione 8)
(10, 16, 1),  -- Giocatore10 vince Miami Open (WTA) (Posizione 1)
(11, 17, 2),  -- Giocatore11 arriva in finale a Indian Wells (WTA) (Posizione 2)
(1, 18, 3),  -- Giocatore1 arriva in semifinale a US Open (Posizione 3)
(2, 19, 1);  -- Giocatore2 vince Coppa Davis (Posizione 1, ITF)

-- Inserimento nella tabella Ranking
INSERT INTO Ranking (Giocatore, Ente_Organizzatore, Posizione)
VALUES
(1, 1, NULL),  -- Giocatore 1, ATP, Posizione NULL
(2, 1, NULL),  -- Giocatore 2, ATP, Posizione NULL
(3, 1, NULL),  -- Giocatore 3, ATP, Posizione NULL
(4, 1, NULL),  -- Giocatore 4, ATP, Posizione NULL
(5, 1, NULL),  -- Giocatore 5, ATP, Posizione NULL
(6, 1, NULL),  -- Giocatore 6, ATP, Posizione NULL
(18, 2, NULL),  -- Giocatore 18, WTA, Posizione NULL
(19, 2, NULL),  -- Giocatore 19, WTA, Posizione NULL
(17, 2, NULL),  -- Giocatore 17, WTA, Posizione NULL
(10, 2, NULL), -- Giocatore 10, WTA, Posizione NULL
(11, 3, NULL), -- Giocatore 11, ITF, Posizione NULL
(12, 3, NULL), -- Giocatore 12, ITF, Posizione NULL
(13, 3, NULL), -- Giocatore 13, ITF, Posizione NULL
(14, 3, NULL), -- Giocatore 14, ITF, Posizione NULL
(15, 3, NULL); -- Giocatore 15, ITF, Posizione NULL

-- Inserimento nella tabella Partita
INSERT INTO Partita (Data, Ora, Torneo, set_giocatore_1, set_giocatore_2)
VALUES
('2025-02-20', '14:00:00', 1, 3, 0),  -- Torneo 1, Giocatore 1 vince 3 set a 0 contro Giocatore 2
('2025-02-20', '16:00:00', 1, 2, 3),  -- Torneo 1, Giocatore 1 perde 2 set a 3 contro Giocatore 2
('2025-02-21', '10:00:00', 2, 2, 3),  -- Torneo 2, Giocatore 1 perde 2 set a 3 contro Giocatore 2
('2025-02-21', '13:00:00', 2, 1, 3),  -- Torneo 2, Giocatore 1 perde 1 set a 3 contro Giocatore 2
('2025-02-22', '09:00:00', 3, 2, 3),  -- Torneo 3, Giocatore 1 perde 2 set a 3 contro Giocatore 2
('2025-02-22', '12:30:00', 3, 3, 1),  -- Torneo 3, Giocatore 1 vince 3 set a 1 contro Giocatore 2
('2025-02-23', '11:00:00', 4, 2, 3),  -- Torneo 4, Giocatore 1 perde 2 set a 3 contro Giocatore 2
('2025-02-23', '14:30:00', 4, 3, 1),  -- Torneo 4, Giocatore 1 vince 3 set a 1 contro Giocatore 2
('2025-02-24', '10:00:00', 5, 2, 0),  -- Torneo 5, Giocatore 1 vince 2 set a 0 contro Giocatore 2
('2025-02-24', '13:00:00', 5, 3, 0),  -- Torneo 5, Giocatore 1 vince 3 set a 0 contro Giocatore 2
('2025-02-25', '11:00:00', 6, 2, 1),  -- Torneo 6, Giocatore 1 vince 2 set a 1 contro Giocatore 2
('2025-02-25', '15:00:00', 6, 3, 0),  -- Torneo 6, Giocatore 1 vince 3 set a 0 contro Giocatore 2
('2025-02-26', '09:30:00', 7, 3, 2),  -- Torneo 7, Giocatore 1 vince 3 set a 2 contro Giocatore 2
('2025-02-26', '12:00:00', 7, 2, 3);  -- Torneo 7, Giocatore 1 perde 2 set a 3 contro Giocatore 2

-- Inserimenti nella tabella Incontro
INSERT INTO Incontro (Giocatore, Torneo, Data, Ora, Ruolo, Vincitore)
VALUES
(1, 1, '2025-02-20', '14:00:00', 1, 1),  -- Giocatore 1 vince contro Giocatore 2
(2, 1, '2025-02-20', '14:00:00', 2, 0),  -- Giocatore 2 perde contro Giocatore 1
(1, 1, '2025-02-20', '16:00:00', 1, 0),  -- Giocatore 1 perde contro Giocatore 2
(2, 1, '2025-02-20', '16:00:00', 2, 1),  -- Giocatore 2 vince contro Giocatore 1 
(3, 2, '2025-02-21', '13:00:00', 1, 0),  -- Giocatore 1 vince contro Giocatore 2
(1, 2, '2025-02-21', '13:00:00', 2, 1),  -- Giocatore 2 perde contro Giocatore 1
(4, 3, '2025-02-22', '12:30:00', 1, 1),  -- Giocatore 1 vince contro Giocatore 2 
(5, 3, '2025-02-22', '12:30:00', 2, 0),  -- Giocatore 2 perde contro Giocatore 1
(2, 3, '2025-02-22', '09:00:00', 1, 1),  -- Giocatore 1 vince contro Giocatore 2
(1, 3, '2025-02-22', '09:00:00', 2, 0);  -- Giocatore 2 perde contro Giocatore 1


-- Inserimento nella tabella Stadio
INSERT INTO Stadio (Nome, Città, Superficie)
VALUES
('Rod Laver Arena', 'Melbourne', 'Erba'),
('Philippe Chatrier Court', 'Parigi', 'Terra'),
('Central Court', 'Londra', 'Erba'),
('Arthur Ashe Stadium', 'New York', 'Cemento'),
('O1 Arena', 'Londra', 'Cemento'),
('Stadium 1', 'Indian Wells', 'Cemento'),
('Hard Rock Stadium', 'Miami', 'Cemento'),
('Court Central', 'Monte Carlo', 'Terra'),
('Manolo Santana Stadium', 'Madrid', 'Terra'),
('Campo Centrale', 'Roma', 'Terra'),
('Lindner Family Tennis Center', 'Cincinnati', 'Cemento'),
('Qi Zhong Stadium', 'Shanghai', 'Cemento'),
('Bercy Arena', 'Parigi', 'Cemento'),
('Aviva Centre', 'Toronto', 'Cemento'),
('Sibur Arena', 'San Pietroburgo', 'Cemento'),
('Centre Court', 'Londra', 'Erba'),
('Gerry Weber Stadion', 'Halle', 'Erba'),
('Wiener Stadthalle', 'Vienna', 'Cemento'),
('Madrid Arena', 'Madrid', 'Cemento'),
('O2 Arena', 'Londra', 'Cemento');

-- Inserimento di dettagli location 
INSERT INTO Dettagli_location (Torneo, Stadio)
VALUES
(1, 'Rod Laver Arena'),  -- Australian Open, Melbourne (Erba)
(2, 'Philippe Chatrier Court'),  -- Roland Garros, Parigi (Terra rossa)
(3, 'Centre Court'),  -- Wimbledon, Londra (Erba)
(4, 'Arthur Ashe Stadium'),  -- US Open, New York (Cemento)
(5, 'O2 Arena'),  -- ATP Finals, Londra (Cemento)
(6, 'Stadium 1'),  -- Indian Wells, California (Cemento)
(7, 'Hard Rock Stadium'),  -- Miami Open, Miami (Cemento)
(8, 'Court Central'),  -- Monte Carlo Masters, Monte Carlo (Terra rossa)
(9, 'Manolo Santana Stadium'),  -- Madrid Open, Madrid (Terra rossa)
(10, 'Campo Centrale'),  -- Internazionali d'Italia, Roma (Terra rossa)
(11, 'Lindner Family Tennis Center'),  -- Cincinnati Masters, Cincinnati (Cemento)
(12, 'Qi Zhong Stadium'),  -- Shanghai Masters, Shanghai (Cemento)
(13, 'Bercy Arena'),  -- Paris Masters, Parigi (Cemento)
(14, 'Aviva Centre'),  -- Canada Open, Toronto (Cemento)
(15, 'Sibur Arena'),  -- St. Petersburg Open, San Pietroburgo (Cemento)
(16, 'Centre Court'),  -- Queen's Club Championships, Londra (Erba)
(17, 'Gerry Weber Stadion'),  -- Halle Open, Halle (Erba)
(18, 'Wiener Stadthalle'),  -- Austrian Open, Vienna (Cemento)
(19, 'Madrid Arena'),  -- Coppa Davis, Madrid (Cemento)
(20, 'O2 Arena');  -- Laver Cup, Londra (Cemento)