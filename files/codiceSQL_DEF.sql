
/************************************
CREAZIONE TABELLE DATABASE
************************************/

create table Utente (
    password varchar(20) not null,
    email varchar(50) check (email like '%@%.%'),
    nome varchar(20) not null,
    indirizzo varchar(50) not null,
    ordini_passati integer not null,
    mezzo_pagamento varchar(20) not null
    codici_sconto integer,
    utente_premium boolean not null,
    constraint Utente_PK primary key(password)
);

create table Ristorante (
    nome varchar(20) not null,
    indirizzo varchar(50) not null,
    costo_spedizione integer not null,
    immagine_profilo bytea,
    top_partner boolean not null,
    numero_stelle integer not null,
    constraint Ristorante_PK primary key(nome, indirizzo)
);

create table Rider (
    codice integer nbot null,
    ora_affidamento_ordine integer,
    stato varchar(20),
    posizione varchar(50) not null,
    mezzo_utilizzato varchar(50) not null,
    ora_consegna integer,
    numero_consegne_effettuate integer not null,
    constraint Rider_PK primary key(codice)
);

create table Ordinazione (
    stato_ordinazione vrchar(20) not null,
    prezzo integer not null,
    tragitto varchar(50) not null,
    constraint Ordinazione_PK primary key(stato_ordinazione)
);

create table Piatto (
    titolo varchar(50) not null,
    allergeni varchar(50) not null,
    liste varchar(50) not null,
    prezzo integer not null,
    sconto integer,
    ingredienti varchar(100) not null,
    immagine bytea,
    constraint Piatto_PK primary key(titolo)
    constraint Piatto_FK_Lista_Piatti foreign key(titolo)

);

create table Telefono (
    numero integer not null;
    constraint Telefono_PK primary key(numero)

);

create table Borsellino (
    saldo integer not null,
    constraint Borsellino_PK primary key(saldo)
);

create table Lista_Piatti (
    nome varchar(50) not null,
    constraint Lista_Piatti_PK primary key(nome)
);

create table Descrizione (
    ristorante varchar(50) not null,
    constraint Descrizione_PK primary key(ristorante),
    constraint Descrizione_FK_Ristorante foreign key(ristorante)
        references Ristorante(nome, indirizzo) on update cascade on delete cascade
);

create table Categoria (
    ristorante varchar(50) not null,
    constraint Descrizione_PK primary key(ristorante),
    constraint Descrizione_FK_Ristorante foreign key(ristorante)
        references Ristorante(nome, indirizzo) on update cascade on delete cascade
);

create table Recensione (
    ristorante varchar(50) not null,
    rider varchar(50) null not,
    utente varchar(50) not null,
    commento_testuale varchar(500),
    reclamo varchar(500),
    valutazione_stelle integer not null,
    constraint Recensione_PK primary key(nome)
    constraint Recensione_FK foreign key (nome, indirizzo) references Ristorante(nome, indirizzo) on update cascade on delete cascade
    constraint Recensione_FK foreign key (password) references Utente(password) on update cascade on delete cascade
    constraint Recensione_FK foreign key (codice) references Rider(codice) on update cascade on delete cascade
);

create table Recapito (
    telefono integer not null,
    utente varchar(50) not null,
    constraint Recapito_PK primary key(numero)
    constraint Recensione_FK foreign key (numero) references Telefono(numero) on update cascade on delete cascade
    constraint Recensione_FK foreign key (password) references Utente(password) on update cascade on delete cascade
);

create table Ricarica (
    borsellino varchar(50) not null,
    utente varchar(50) not null,
    constraint Ricarica_PK primary key(saldo)
    constraint Ricarica_FK foreign key (saldo) references Borsellino(saldo) on update cascade on delete cascade
    constraint Ricarica_FK foreign key (password) references Utente(password) on update cascade on delete cascade
);

create table Propone (
    ristorante varchar(50) not null,
    lista_piatti varchar(50) not null,
    constraint Propone_PK primary key(nome)
    constraint Propone_FK foreign key (nome) references Lista_Piatti(nome) on update cascade on delete cascade
    constraint Propone_FK foreign key (nome, indirizzo) references Ristorante(nome, indirizzp) on update cascade on delete cascade
);

create table Possiede (
    ristorante varchar(50) not null,
    descrizione varchar(500) not null,
    constraint Possiede_PK primary key(nome, indirizzo)
    constraint Possiede_FK foreign key (nome, indirizzo) references Ristorante(nome, idirizzo) on update cascade on delete cascade
);

create table Appartiene (
    ristorante varchar(50) not null,
    descrizione varchar(500) not null,
    constraint Appartiene_PK primary key(nome, indirizzo)
    constraint Appartiene_FK foreign key (nome, indirizzo) references Ristorante(nome, idirizzo) on update cascade on delete cascade
);

create table Selezione (
    utente varchar(50) not null,
    lista_piatti varchar(50) not null,
    constraint Selezione_PK primary key (nome)
    constraint Selezione_FK foreign key (nome) references Lista_piatti(nome) on update cascade on delete cascade
    constraint Selezione_FK foreign key (password) references Utente(password) on update cascade on delete cascade
);

create table Priorita (
    utente varchar(50) not null,
    ordinazione varchar(20) not null,
    constraint Priorita_PK primary key (stato_ordinazione)
    constraint Priorita_FK foreign key (stato_ordinazione) references Ordinazione(stato_ordinazione) on update cascade on delete cascade
    constraint Priorita_FK foreign key (password) references Utente(password) on update cascade on delete cascade
);

create table Comunicazione (
    ristorante varchar(50) not null,
    rider varchar(50) null not,
    utente varchar(50) not null,
    constraint Comunicazione_PK primary key(nome)
    constraint Comunicazione_FK foreign key (nome, indirizzo) references Ristorante(nome, indirizzo) on update cascade on delete cascade
    constraint Comunicazione_FK foreign key (password) references Utente(password) on update cascade on delete cascade
    constraint Comunicazione_FK foreign key (codice) references Rider(codice) on update cascade on delete cascade
);

create table Creazione_Ordine (
    lista_piatti varchar(50) not null,
    ordinazione varchar(20) not null,
    constraint Creazione_Ordine_PK primary key (nome)
    constraint Creazione_Ordine_FK foreign key (stato_ordinazione) references Ordinazione(stato_ordinazione) on update cascade on delete cascade
    constraint Creazione_Ordine_FK foreign key (nome) references Lista_Piatti(nome) on update cascade on delete cascade
);

create table Cancellazione (
    ristorante varchar(50) not null,
    utente varchar(50) not null,
    ordinazione varchar(20) not null,
    constraint Creazione_Ordine_PK primary key (stato_ordinazione)
    constraint Priorita_FK foreign key (stato_ordinazione) references Ordinazione(stato_ordinazione) on update cascade on delete cascade
    constraint Priorita_FK foreign key (password) references Utente(password) on update cascade on delete cascade
    constraint Comunicazione_FK foreign key (nome, indirizzo) references Ristorante(nome, indirizzo) on update cascade on delete cascade
);

create table Aggiornamento (
    borsellino varchar(20) not null,
    ordinazione varchar(20) not null,
    constraint Creazione_Ordine_PK primary key (stato_ordinazione)
    constraint Priorita_FK foreign key (stato_ordinazione) references Ordinazione(stato_ordinazione) on update cascade on delete cascade
    constraint Priorita_FK foreign key (saldo) references Borsellino(saldo) on update cascade on delete cascade
);

create table Consegna (
    rider varchar(50) null not,
    ordinazione varchar(20) not null,
    constraint Creazione_Ordine_PK primary key (stato_ordinazione)
    constraint Priorita_FK foreign key (stato_ordinazione) references Ordinazione(stato_ordinazione) on update cascade on delete cascade
    constraint Comunicazione_FK foreign key (codice) references Rider(codice) on update cascade on delete cascade
);





/*********************************
POPOLAMENTO TABELLE SQL
*********************************/

insert into Utente values ('asajdjajD324', 'marco@email.com', 'Marco', 'Via Roma 12', 49, 'carta di credito', 263328, true);
insert into Utente values ('326%&fGjilds', 'paolo@gmail.com', 'Paolo', 'Via Potenza 56', 167, 'satispay', 854930, false);
insert into Utente values ('768DF$rg26hk', 'luca@email.com', 'Luca', 'Via Tegas 24', 89, 'carta di credito', null, false);
insert into Utente values ('djisjjs483)K', 'maria@email.com', 'Maria', 'Via Lanza 90', 43, 'bancomat', null, false);
insert into Utente values ('hhsUIHjkj8&%', 'lucia@gmail.com', 'Lucia', 'Via Milano 12', 126, 'bancomat', 128063, true);

insert into Ristorante values ('La Rosa in Fiore', 'Viale Amicis 23', 10, 'file.rosa_in_fiore.jpg', true, 5);
insert into Ristorante values ('La Volpe Addormentata', 'Via Roma 25', 12, 'file.volpe_addormentata.jpg', true, 4);
insert into Ristorante values ('Fujot', 'Viale Leopardi 14', 8, 'file.fujot.jpg', false, 3);

insert into Rider values (452695, 15:30, 'spedito', 'via tesla', 'bicicletta', 16:00, 19);
insert into Rider values (781340, 19:20, 'consegnato', 'via torino', 'monopattino', 20:00, 71);
insert into Rider values (854714, 20:00, 'preparazione', 'via milano', 'monopattino', 20:20, 54);
insert into Rider values (878543, 18:45, 'spedito', 'via tegas', 'bicicletta elettrica', 19:00, 27);
insert into Rider values (878545, null, 'annullato', 'via lamarmora', 'biciletta', null, 45);

insert into Ordinazione values ('spedito', 14, 'via mazzini');
insert into Ordinazione values ('annullato', 16, 'via milano');
insert into Ordinazione values ('consegnato', 10, 'piazza darmi');
insert into Ordinazione values ('spedito', 12, 'via rossini');

insert into Piatto values ('pasta al pomodoro', 'glutine', 'primi', 9, null, 'farina,pomodoro', 'file.pasta_pomodoro.jpg');
insert into Piatto values ('gnocchi alla romana', 'lattosio, uova, glutine', 'primi', 8, 2, 'formaggio, farina', 'file.gnocchi_romana.jpg');
insert into Piatto values ('gelato', 'lattosio', 'dolci', 3, null, 'latte, frutta', 'file.gelato.jpg');

insert into Telefono values ('340 1587439');
insert into Telefono values ('334 8587413');
insert into Telefono values ('340 8755674');
insert into Telefono values ('348 8544355');
insert into Telefono values ('333 4857854');

insert into Borsellino values (154);
insert into Borsellino values (74);
insert into Borsellino values (85);
insert into Borsellino values (20);

insert into Lista_Piatti values ('primi');
insert into Lista_Piatti values ('secondi');
insert into Lista_Piatti values ('contorni');
insert into Lista_Piatti values ('dolci');

insert into Descrizione values ('La Rosa in Fiore');
insert into Descrizione values ('La Volpe Addormentata');
insert into Descrizione values ('Il Fujot');
insert into Descrizione values ('La Sirena');

insert into Categoria values ('La Rosa in Fiore');
insert into Categoria values ('La Volpe Addormentata');
insert into Categoria values ('Il Fujot');

insert into Recensione values ('La Sirena', 'Paolo', 'Marco', 'Cibo eccellente, grazie', null, 5);
insert into Recensione values ('La Volpe Addormentata', 'Luca', 'Marta', 'Cibo scadente', 'Non compreprò più da questo ristorante', 2);
insert into Recensione values ('La Rosa in Fiore', 'Raffaele', 'Mario', 'Ottimo cibo', null, 4);
insert into Recensione values ('Il Fujot', 'Paolo', 'Francesca', 'Nulla da dire, perfetto', null, 5);

insert into Recapito values ('340 4589712', 'Paolo');
insert into Recapito values ('338 5454566', 'Mario');
insert into Recapito values ('348 5689656', 'Vittoria');

insert into Ricarica values (20);
insert into Ricarica values (50);
insert into Ricarica values (100);

insert into Propone values ('La Rosa in Fiore', 'primi');
insert into Propone values ('La Rosa in Fiore', 'dolci');
insert into Propone values ('La Volpe Addormentata', 'contorni');
insert into Propone values ('Il Fujot', 'dolci');

insert into Selezione values ('Paolo', 'primi');
insert into Selezione values ('Marco', 'dolci');
insert into Selezione values ('Lucia', 'contorni');

insert into Priorita values ('Luca', 'spedito');
insert into Priorita values ('Marta', 'consegnato');

insert into Comunicazione values ('La Rosa in Fiore', 'Luca', 'Marco');
insert into Comunicazione values ('La Volpe Addormentata', 'Francesco', 'Raffaele');
insert into Comunicazione values ('Il Fujot', 'Manuel', 'Giuseppe');

insert into Creazione_Ordine values ('primi', 'preparazione');
insert into Creazione_Ordine values ('primi', 'spedito');
insert into Creazione_Ordine values ('dolci', 'spedito');
insert into Creazione_Ordine values ('contorni', 'consegnato');

insert into Cancellazione values ('La Rosa in Fiore', 'Luca', 'preparazione');
insert into Cancellazione values ('La Volpe Addormentata', 'Marlo', 'preparazione');
insert into Cancellazione values ('Il Fujot', 'Niccolo', 'spedito');

insert into Aggiornamento values (20, 'annullata');
insert into Aggiornamento values (59, 'consegnata');
insert into Aggiornamento values (89, 'spedita');
insert into Aggiornamento values (137, 'consegnata');

insert into Consegna values ('Paolo', 'spedito');
insert into Consegna values ('Marco', 'annullato');
insert into Consegna values ('Maria', 'consegnato');

---------------------------------------------------------------