-- schema
CREATE TABLE users
(
  id         SERIAL       NOT NULL
    CONSTRAINT users_pkey
    PRIMARY KEY,
  name       VARCHAR(255) NOT NULL,
  phone      VARCHAR(255) NOT NULL,
  address    VARCHAR(255),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE songs
(
  id          SERIAL       NOT NULL
    CONSTRAINT songs_pkey
    PRIMARY KEY,
  name        VARCHAR(255) NOT NULL,
  composer    VARCHAR(255),
  singer      VARCHAR(255),
  released_at DATE,
  created_at  TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  link        VARCHAR(255)
);

CREATE TABLE requests
(
  id         SERIAL NOT NULL
    CONSTRAINT requests_pkey
    PRIMARY KEY,
  user_id    INTEGER
    CONSTRAINT requests_user_id_foreign
    REFERENCES users,
  song_id    VARCHAR(255),
  resolved   BOOLEAN DEFAULT FALSE,
  created_at DATE    DEFAULT CURRENT_DATE,
  message    TEXT
);

CREATE TABLE broadcasts
(
  id           SERIAL       NOT NULL
    CONSTRAINT broadcasts_pkey
    PRIMARY KEY,
  name         VARCHAR(255) NOT NULL,
  broadcast_at TIMESTAMP(0) DEFAULT CURRENT_TIMESTAMP,
  created_at   TIMESTAMP    DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE broadcast_request
(
  id           SERIAL  NOT NULL
    CONSTRAINT broadcast_request_pkey
    PRIMARY KEY,
  broadcast_id INTEGER
    CONSTRAINT broadcast_request_broadcast_id_foreign
    REFERENCES broadcasts,
  request_id   INTEGER
    CONSTRAINT broadcast_request_request_id_foreign
    REFERENCES requests,
  order_number INTEGER NOT NULL,
  created_at   TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);