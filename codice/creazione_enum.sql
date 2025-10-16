CREATE TYPE tipologia_annuncio_enum AS ENUM (
    'vendita',
    'scambio',
    'regalo'
);

CREATE TYPE stato_offerta_enum AS ENUM (
    'attesa',
    'accettata',
    'rifiutata'
);

CREATE TYPE orario_enum AS ENUM (
    '07:00',
    '08:00',
    '09:00',
    '10:00',
    '11:00',
    '12:00',
    '13:00',
    '14:00',
    '15:00',
    '16:00',
    '17:00',
    '18:00',
    '19:00',
    '20:00',
    '21:00',
    '22:00'
);