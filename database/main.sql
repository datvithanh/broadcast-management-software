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
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
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

ALTER SEQUENCE requests_id_seq RESTART 1300;
ALTER SEQUENCE songs_id_seq RESTART 600;
ALTER SEQUENCE broadcast_request_id_seq RESTART 500;
ALTER SEQUENCE broadcasts_id_seq RESTART 100;
ALTER SEQUENCE users_id_seq RESTART 600;

--function

CREATE FUNCTION insert_users(_name character varying, _phone character varying, _address character varying)
  RETURNS TABLE(user_id integer)
LANGUAGE plpgsql
AS $$
BEGIN
  IF EXISTS(SELECT 1
            FROM users
            WHERE phone = _phone)
  THEN
    RETURN QUERY
    SELECT id
    FROM users
    WHERE phone = _phone
    LIMIT 1;
    RETURN;
  END IF;
  RETURN QUERY
  INSERT INTO users (name, phone, address)
  VALUES (_name, _phone, _address)
  RETURNING id;
END
$$;

--data
--songs
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (20, 'Rubber Soul', 'Neil Diamond', 'The Beatles', '1965-01-01', '2018-08-07 08:57:03.916479', '/media/Rubber Soul.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (22, 'Exile on Main St.', 'Bruce Springsteen', 'The Rolling Stones', '1972-01-01', '2018-08-07 08:57:03.916479', '/media/Exile on Main St..wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (23, 'London Calling', 'Pixies', 'The Clash', '1979-01-01', '2018-08-07 08:57:03.916479', '/media/London Calling.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (21, 'What''s Going On', 'Green Day', 'Marvin Gaye', '1971-01-01', '2018-08-07 08:56:58.766000', '/media/What''s Going On.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (18, 'Revolver', 'Professor Longhair', 'The Beatles', '1966-01-01', '2018-08-07 08:57:03.916479', '/media/Revolver.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (19, 'Highway 61 Revisited', 'U2', 'Bob Dylan', '1965-01-01', '2018-08-07 08:57:03.916479', '/media/Highway 61 Revisited.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (17, 'Pet Sounds', 'My Bloody Valentine', 'The Beach Boys', '1966-01-01', '2018-08-07 08:56:53.351000', '/media/Pet Sounds.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (263, 'The Shape of Jazz to Come', 'Bruce Springsteen', 'Ornette Coleman', '1959-01-01', '2018-08-07 08:57:19.939000', '/media/The Shape of Jazz to Come.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (257, 'Run D.M.C.', 'Public Image Ltd.', 'Run D.M.C.', '1984-01-01', '2018-08-07 08:57:19.939000', '/media/Run D.M.C..wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (258, 'Black Sabbath', 'R.E.M.', 'Black Sabbath', '1970-01-01', '2018-08-07 08:57:19.939000', '/media/Black Sabbath.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (268, 'The River', 'George Michael', 'Bruce Springsteen', '1980-01-01', '2018-08-07 08:57:19.939000', '/media/The River.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (355, 'Damaged', 'Creedence Clearwater Revival', 'Black ', '1981-01-01', '2018-08-07 08:57:19.939000', '/media/Damaged.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (36, 'The Great Twenty_Eight', 'Steely Dan', 'Chuck Berry', '1982-01-01', '2018-08-07 08:57:19.939000', '/media/The Great Twenty_Eight.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (37, 'The Complete Recordings', 'The Replacements', 'Robert Johnson', '1990-01-01', '2018-08-07 08:57:19.939000', '/media/The Complete Recordings.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (269, 'Complete & Unbelievable: The Otis Redding Dictionary of Soul', 'The Smiths', 'Otis Redding', '1966-01-01', '2018-08-07 08:57:19.939000', '/media/Complete & Unbelievable: The Otis Redding Dictionary of Soul.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (265, 'Reasonable Doubt', 'Fugees', 'Jay Z', '1996-01-01', '2018-08-07 08:57:19.939000', '/media/Reasonable Doubt.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (266, 'Low', 'L.L. Cool J', 'David Bowie', '1977-01-01', '2018-08-07 08:57:19.939000', '/media/Low.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (272, 'Whitney Houston', 'The Notorious B.I.G.', 'Whitney Houston', '1985-01-01', '2018-08-07 08:57:19.939000', '/media/Whitney Houston.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (273, 'The Kinks Are The Village Green Preservation Society', 'Merle Haggard', 'The Kinks', '1968-01-01', '2018-08-07 08:57:19.939000', '/media/The Kinks Are The Village Green Preservation Society.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (275, 'Stardust', 'Funkadelic', 'Willie Nelson', '1978-01-01', '2018-08-07 08:57:19.939000', '/media/Stardust.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (284, 'Psychocandy', 'Husker Du', 'The Jesus and Mary Chain', '1985-01-01', '2018-08-07 08:57:19.939000', '/media/Psychocandy.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (286, 'The Beach Boys Today!', 'ZZ Top', 'The Beach Boys', '1965-01-01', '2018-08-07 08:57:19.939000', '/media/The Beach Boys Today!.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (287, 'Dig Me Out', 'Albert King', 'Sleater Kinney', '1997-01-01', '2018-08-07 08:57:19.939000', '/media/Dig Me Out.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (281, 'Child Is Father to the Man', 'Pearl Jam', 'Blood, Sweat & Tears', '1968-01-01', '2018-08-07 08:57:19.939000', '/media/Child Is Father to the Man.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (282, 'Quadrophenia', 'Earth, Wind & Fire', 'The Who', '1973-01-01', '2018-08-07 08:57:19.939000', '/media/Quadrophenia.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (356, 'Play', 'Captain Beefheart & His Magic Band', 'Moby', '1999-01-01', '2018-08-07 08:57:19.939000', '/media/Play.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (357, 'Violator', 'Sly & The Family Stone', 'Depeche Mode', '1990-01-01', '2018-08-07 08:57:19.939000', '/media/Violator.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (358, 'Bat Out of Hell', 'Guns N'' Roses', 'Meat Loaf', '1977-01-01', '2018-08-07 08:57:19.939000', '/media/Bat Out of Hell.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (359, 'Berlin', 'U2', 'Lou Reed', '1973-01-01', '2018-08-07 08:57:19.939000', '/media/Berlin.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (352, 'Aqualung', 'Elvis Presley', 'Jethro Tull', '1971-01-01', '2018-08-07 08:57:19.939000', '/media/Aqualung.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (353, 'Cheap Thrills', 'Stevie Wonder', 'Big Brother & the Holding Company', '1968-01-01', '2018-08-07 08:57:19.939000', '/media/Cheap Thrills.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (354, 'The Heart of Saturday Night', 'The Rolling Stones', 'Tom Waits', '1974-01-01', '2018-08-07 08:57:19.939000', '/media/The Heart of Saturday Night.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (364, 'The Black Album', 'Michael Jackson', 'Jay Z', '2003-01-01', '2018-08-07 08:57:19.939000', '/media/The Black Album.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (366, 'Rust Never Sleeps', 'Billy Joel', 'Neil Young & Crazy Horse', '1979-01-01', '2018-08-07 08:57:19.939000', '/media/Rust Never Sleeps.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (360, 'Stop Making Sense', 'The Rolling Stones', 'Talking Heads', '1984-01-01', '2018-08-07 08:57:19.939000', '/media/Stop Making Sense.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (362, 'The Piper at the Gates of Dawn', 'Van Morrison', 'Pink Floyd', '1967-01-01', '2018-08-07 08:57:19.939000', '/media/The Piper at the Gates of Dawn.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (372, 'Between the Buttons', 'Prince and the Revolution', 'The Rolling Stones', '1967-01-01', '2018-08-07 08:57:19.939000', '/media/Between the Buttons.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (375, 'Singles Going Steady', 'Led Zeppelin', 'Buzzcocks', '1979-01-01', '2018-08-07 08:57:19.939000', '/media/Singles Going Steady.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (368, 'My Beautiful Dark Twisted Fantasy', 'Curtis Mayfield', 'Kanye West', '2010-01-01', '2018-08-07 08:57:19.939000', '/media/My Beautiful Dark Twisted Fantasy.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (369, '52nd Street', 'Led Zeppelin', 'Billy Joel', '1978-01-01', '2018-08-07 08:57:19.939000', '/media/52nd Street.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (370, 'Having a Rave Up', 'Neil Young', 'The Yardbirds', '1965-01-01', '2018-08-07 08:57:19.939000', '/media/Having a Rave Up.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (371, '12 Songs', 'James Brown', 'Randy Newman', '1970-01-01', '2018-08-07 08:57:19.939000', '/media/12 Songs.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (380, 'Rage Against the Machine', 'Aretha Franklin', 'Rage Against the Machine', '1992-01-01', '2018-08-07 08:57:19.939000', '/media/Rage Against the Machine.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (381, 'American Recordings', 'Aretha Franklin', 'Johnny Cash', '1994-01-01', '2018-08-07 08:57:19.939000', '/media/American Recordings.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (382, 'Ray of Light', 'Bruce Springsteen', 'Madonna', '1998-01-01', '2018-08-07 08:57:19.939000', '/media/Ray of Light.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (383, 'Eagles', 'Pink Floyd', 'Eagles', '1972-01-01', '2018-08-07 08:57:19.939000', '/media/Eagles.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (376, 'Stankonia', 'John Lennon', 'OutKast', '2000-01-01', '2018-08-07 08:57:19.939000', '/media/Stankonia.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (377, 'Siamese Dream', 'The Clash', 'The Smashing Pumpkins', '1993-01-01', '2018-08-07 08:57:19.939000', '/media/Siamese Dream.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (378, 'Substance 1987', 'Neil Young', 'New Order', '1987-01-01', '2018-08-07 08:57:19.939000', '/media/Substance 1987.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (324, 'Willy and the Poor Boys', 'The Who', 'Creedence Clearwater Revival', '1969-01-01', '2018-08-07 08:57:19.939000', '/media/Willy and the Poor Boys.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (325, 'Blood Sugar Sex Magik', 'Led Zeppelin', 'Red Hot Chili Peppers', '1991-01-01', '2018-08-07 08:57:19.939000', '/media/Blood Sugar Sex Magik.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (326, 'The Sun Records Collection', 'Joni Mitchell', 'Various', '1994-01-01', '2018-08-07 08:57:19.939000', '/media/The Sun Records Collection.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (327, 'Nothing''s Shocking', 'Bob Dylan', 'Jane''s Addiction', '1988-01-01', '2018-08-07 08:57:19.939000', '/media/Nothing''s Shocking.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (320, 'Car Wheels on a Gravel Road', 'Stevie Wonder', 'Lucinda Williams', '1998-01-01', '2018-08-07 08:57:19.939000', '/media/Car Wheels on a Gravel Road.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (321, 'Odelay', 'James Brown', 'Beck', '1996-01-01', '2018-08-07 08:57:19.939000', '/media/Odelay.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (322, 'A Hard Day''s Night', 'Fleetwood Mac', 'The Beatles', '1964-01-01', '2018-08-07 08:57:19.939000', '/media/A Hard Day''s Night.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (323, 'Songs for Swingin'' Lovers!', 'U2', 'Frank Sinatra', '1956-01-01', '2018-08-07 08:57:19.939000', '/media/Songs for Swingin'' Lovers!.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (332, 'Surfer Rosa', 'Carole King', 'Pixies', '1988-01-01', '2018-08-07 08:57:19.939000', '/media/Surfer Rosa.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (333, 'Back Stabbers', 'Eagles', 'The O''Jays', '1972-01-01', '2018-08-07 08:57:19.939000', '/media/Back Stabbers.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (334, 'Burnin''', 'Muddy Waters', 'The Wailers', '1973-01-01', '2018-08-07 08:57:19.939000', '/media/Burnin''.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (335, 'Amnesiac', 'The Beatles', 'Radiohead', '2001-01-01', '2018-08-07 08:57:19.939000', '/media/Amnesiac.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (328, 'MTV Unplugged in New York', 'The Rolling Stones', 'Nirvana', '1994-01-01', '2018-08-07 08:57:19.939000', '/media/MTV Unplugged in New York.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (329, 'The Miseducation of Lauryn Hill', 'Ramones', 'Lauryn Hill', '1998-01-01', '2018-08-07 08:57:19.939000', '/media/The Miseducation of Lauryn Hill.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (330, 'Damn the Torpedoes', 'The Band', 'Tom Petty and the Heartbreakers', '1979-01-01', '2018-08-07 08:57:19.939000', '/media/Damn the Torpedoes.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (331, 'The Velvet Underground', 'David Bowie', 'The Velvet Underground', '1969-01-01', '2018-08-07 08:57:19.939000', '/media/The Velvet Underground.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (340, 'Slowhand', 'Patti Smith', 'Eric Clapton', '1977-01-01', '2018-08-07 08:57:19.939000', '/media/Slowhand.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (341, 'Disintegration', 'The Band', 'The Cure', '1989-01-01', '2018-08-07 08:57:19.939000', '/media/Disintegration.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (342, 'Exile in Guyville', 'Bob Marley & The Wailers', 'Liz Phair', '1993-01-01', '2018-08-07 08:57:19.939000', '/media/Exile in Guyville.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (343, 'Daydream Nation', 'John Coltrane', 'Sonic Youth', '1988-01-01', '2018-08-07 08:57:19.939000', '/media/Daydream Nation.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (336, 'Pink Moon', 'Love', 'Nick Drake', '1972-01-01', '2018-08-07 08:57:19.939000', '/media/Pink Moon.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (337, 'Sail Away', 'Sex Pistols', 'Randy Newman', '1972-01-01', '2018-08-07 08:57:19.939000', '/media/Sail Away.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (338, 'Ghost in the Machine', 'The Doors', 'The Police', '1981-01-01', '2018-08-07 08:57:19.939000', '/media/Ghost in the Machine.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (339, 'Station to Station', 'Pink Floyd', 'David Bowie', '1976-01-01', '2018-08-07 08:57:19.939000', '/media/Station to Station.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (348, 'Wild Gift', 'Al Green', 'X', '1981-01-01', '2018-08-07 08:57:19.939000', '/media/Wild Gift.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (349, 'Squeezing Out Sparks', 'The Beatles', 'Graham Parker & The Rumour', '1979-01-01', '2018-08-07 08:57:19.939000', '/media/Squeezing Out Sparks.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (350, 'Superunknown', 'Ray Charles', 'Soundgarden', '1994-01-01', '2018-08-07 08:57:19.939000', '/media/Superunknown.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (351, 'In Rainbows', 'The Jimi Hendrix Experience', 'Radiohead', '2007-01-01', '2018-08-07 08:57:19.939000', '/media/In Rainbows.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (344, 'In the Jungle Groove', 'Public Enemy', 'James Brown', '1986-01-01', '2018-08-07 08:57:19.939000', '/media/In the Jungle Groove.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (345, 'Tonight''s the Night', 'The Allman Brothers Band', 'Neil Young', '1975-01-01', '2018-08-07 08:57:19.939000', '/media/Tonight''s the Night.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (346, 'Help!', 'Little Richard', 'The Beatles', '1965-01-01', '2018-08-07 08:57:19.939000', '/media/Help!.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (347, 'Shoot Out the Lights', 'Simon & Garfunkel', 'Richard & Linda Thompson', '1982-01-01', '2018-08-07 08:57:19.939000', '/media/Shoot Out the Lights.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (515, 'Aquemini', 'Beastie Boys', 'OutKast', '1998-01-01', '2018-08-07 08:57:19.939000', '/media/Aquemini.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (514, 'Live in Cook County Jail', 'The Smiths', 'B.B. King', '1971-01-01', '2018-08-07 08:57:19.939000', '/media/Live in Cook County Jail.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (513, 'The Stone Roses', 'Bobby "Blue" Bland', 'The Stone Roses', '1989-01-01', '2018-08-07 08:57:19.939000', '/media/The Stone Roses.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (512, 'White Blood Cells', 'Bo Diddley', 'The White Stripes', '2001-01-01', '2018-08-07 08:57:19.939000', '/media/White Blood Cells.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (164, 'Santana', 'Eagles', 'Santana', '1969-01-01', '2018-08-07 08:57:19.939000', '/media/Santana.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (165, 'Darkness on the Edge of Town', 'The Smiths', 'Bruce Springsteen', '1978-01-01', '2018-08-07 08:57:19.939000', '/media/Darkness on the Edge of Town.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (166, 'Funeral', 'Mott the Hoople', 'Arcade Fire', '2004-01-01', '2018-08-07 08:57:19.939000', '/media/Funeral.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (167, 'The B 52''s / Play Loud', 'Arctic Monkeys', 'The B 52''s', '1979-01-01', '2018-08-07 08:57:19.939000', '/media/The B 52''s / Play Loud.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (160, 'Aja', 'The Doors', 'Steely Dan', '1977-01-01', '2018-08-07 08:57:19.939000', '/media/Aja.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (161, 'Surrealistic Pillow', 'Rage Against the Machine', 'Jefferson Airplane', '1967-01-01', '2018-08-07 08:57:19.939000', '/media/Surrealistic Pillow.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (162, 'Deja vu', 'Johnny Cash', 'Crosby, Stills, Nash & Young', '1970-01-01', '2018-08-07 08:57:19.939000', '/media/Deja vu.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (163, 'Houses of the Holy', 'Madonna', 'Led Zeppelin', '1973-01-01', '2018-08-07 08:57:19.939000', '/media/Houses of the Holy.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (172, 'Closer', 'Bjork', 'Joy Division', '1980-01-01', '2018-08-07 08:57:19.939000', '/media/Closer.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (173, 'Captain Fantastic and the Brown Dirt Cowboy', 'John Lee Hooker', 'Elton John', '1975-01-01', '2018-08-07 08:57:19.939000', '/media/Captain Fantastic and the Brown Dirt Cowboy.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (174, 'Alive!', 'Oasis', 'KISS', '1975-01-01', '2018-08-07 08:57:19.939000', '/media/Alive!.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (175, 'Electric Warrior', 'TLC', 'T. Rex', '1971-01-01', '2018-08-07 08:57:19.939000', '/media/Electric Warrior.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (168, 'The Low End Theory', 'The Police', 'A Tribe Called Quest', '1991-01-01', '2018-08-07 08:57:19.939000', '/media/The Low End Theory.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (169, 'Moanin'' in the Moonlight', 'Jefferson Airplane', 'Howlin'' Wolf', '1958-01-01', '2018-08-07 08:57:19.939000', '/media/Moanin'' in the Moonlight.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (170, 'Pretenders', 'Roxy Music', 'Pretenders', '1980-01-01', '2018-08-07 08:57:19.939000', '/media/Pretenders.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (171, 'Paul''s Boutique', 'Jackson Browne', 'Beastie Boys', '1989-01-01', '2018-08-07 08:57:19.939000', '/media/Paul''s Boutique.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (180, 'Let''s Get It On', 'The Who', 'Marvin Gaye', '1973-01-01', '2018-08-07 08:57:19.939000', '/media/Let''s Get It On.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (181, 'Imperial Bedroom', 'Bob Dylan', 'Elvis Costello & The Attractions', '1982-01-01', '2018-08-07 08:57:19.939000', '/media/Imperial Bedroom.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (182, 'Master of Puppets', 'Steely Dan', 'Metallica', '1986-01-01', '2018-08-07 08:57:19.939000', '/media/Master of Puppets.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (183, 'My Aim Is True', 'Wu Tang Clan', 'Elvis Costello', '1977-01-01', '2018-08-07 08:57:19.939000', '/media/My Aim Is True.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (176, 'The Dock of the Bay', 'Toots & The Maytals', 'Otis Redding', '1968-01-01', '2018-08-07 08:57:19.939000', '/media/The Dock of the Bay.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (177, 'OK Computer', 'The Beach Boys', 'Radiohead', '1997-01-01', '2018-08-07 08:57:19.939000', '/media/OK Computer.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (178, '1999', 'The Modern Lovers', 'Prince', '1982-01-01', '2018-08-07 08:57:19.939000', '/media/1999.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (179, 'The Very Best of Linda Ronstadt', 'Talking Heads', 'Linda Ronstadt', '2002-01-01', '2018-08-07 08:57:19.939000', '/media/The Very Best of Linda Ronstadt.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (188, 'Something/Anything?', 'The Beatles', 'Todd Rundgren', '1972-01-01', '2018-08-07 08:57:19.939000', '/media/Something/Anything?.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (189, 'Desire', 'M.I.A.', 'Bob Dylan', '1976-01-01', '2018-08-07 08:57:19.939000', '/media/Desire.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (190, 'Close to You', 'Randy Newman', 'Carpenters', '1970-01-01', '2018-08-07 08:57:19.939000', '/media/Close to You.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (191, 'Rocks', 'LCD Soundsystem', 'Aerosmith', '1976-01-01', '2018-08-07 08:57:19.939000', '/media/Rocks.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (184, 'Exodus', 'Various Artists', 'Bob Marley & The Wailers', '1977-01-01', '2018-08-07 08:57:19.939000', '/media/Exodus.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (185, 'Live at Leeds', 'Don Henley', 'The Who', '1970-01-01', '2018-08-07 08:57:19.939000', '/media/Live at Leeds.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (186, 'The Notorious Byrd Brothers', 'The White Stripes', 'The Byrds', '1968-01-01', '2018-08-07 08:57:19.939000', '/media/The Notorious Byrd Brothers.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (187, 'Every Picture Tells a Story', 'Jackson Browne', 'Rod Stewart', '1971-01-01', '2018-08-07 08:57:19.939000', '/media/Every Picture Tells a Story.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (132, 'Layla and Other Assorted Love Songs', 'Radiohead', 'Derek and the Dominos', '1970-01-01', '2018-08-07 08:57:19.939000', '/media/Layla and Other Assorted Love Songs.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (133, 'Late Registration', 'Jethro Tull', 'Kanye West', '2005-01-01', '2018-08-07 08:57:19.939000', '/media/Late Registration.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (134, 'At Last!', 'Big Brother & the Holding Company', 'Etta James', '1960-01-01', '2018-08-07 08:57:19.939000', '/media/At Last!.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (135, 'Sweetheart of the Rodeo', 'Tom Waits', 'The Byrds', '1968-01-01', '2018-08-07 08:57:19.939000', '/media/Sweetheart of the Rodeo.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (128, 'Court and Spark', 'Richard & Linda Thompson', 'Joni Mitchell', '1974-01-01', '2018-08-07 08:57:19.939000', '/media/Court and Spark.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (129, 'Disraeli Gears', 'X', 'Cream', '1967-01-01', '2018-08-07 08:57:19.939000', '/media/Disraeli Gears.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (130, 'The Who Sell Out', 'Graham Parker & The Rumour', 'The Who', '1967-01-01', '2018-08-07 08:57:19.939000', '/media/The Who Sell Out.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (131, 'Out of Our Heads', 'Soundgarden', 'The Rolling Stones', '1965-01-01', '2018-08-07 08:57:19.939000', '/media/Out of Our Heads.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (140, 'Pearl', 'Lou Reed', 'Janis Joplin', '1971-01-01', '2018-08-07 08:57:19.939000', '/media/Pearl.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (141, 'Catch a Fire', 'Talking Heads', 'The Wailers', '1973-01-01', '2018-08-07 08:57:19.939000', '/media/Catch a Fire.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (142, 'Younger Than Yesterday', 'De La Soul', 'The Byrds', '1967-01-01', '2018-08-07 08:57:19.939000', '/media/Younger Than Yesterday.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (143, 'Raw Power', 'Pink Floyd', 'Iggy and The Stooges', '1973-01-01', '2018-08-07 08:57:19.939000', '/media/Raw Power.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (136, 'Stand!', 'Black Flag', 'Sly & The Family Stone', '1969-01-01', '2018-08-07 08:57:19.939000', '/media/Stand!.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (137, 'The Harder They Come', 'Moby', 'Various Artists', '1972-01-01', '2018-08-07 08:57:19.939000', '/media/The Harder They Come.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (138, 'Raising Hell', 'Depeche Mode', 'Run D.M.C.', '1986-01-01', '2018-08-07 08:57:19.939000', '/media/Raising Hell.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (139, 'Moby Grape', 'Meat Loaf', 'Moby Grape', '1967-01-01', '2018-08-07 08:57:19.939000', '/media/Moby Grape.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (148, 'The Wild, the Innocent & the E Street Shuffle', 'Dire Straits', 'Bruce Springsteen', '1973-01-01', '2018-08-07 08:57:19.939000', '/media/The Wild, the Innocent & the E Street Shuffle.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (149, 'Ready to Die', 'Kanye West', 'The Notorious B.I.G.', '1994-01-01', '2018-08-07 08:57:19.939000', '/media/Ready to Die.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (150, 'Slanted and Enchanted', 'Billy Joel', 'Pavement', '1992-01-01', '2018-08-07 08:57:19.939000', '/media/Slanted and Enchanted.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (151, 'Greatest Hits', 'The Yardbirds', 'Elton John', '1974-01-01', '2018-08-07 08:57:19.939000', '/media/Greatest Hits.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (144, 'Remain in Light', 'Muddy Waters', 'Talking Heads', '1980-01-01', '2018-08-07 08:57:19.939000', '/media/Remain in Light.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (145, 'Marquee Moon', 'Jay Z', 'Television', '1977-01-01', '2018-08-07 08:57:19.939000', '/media/Marquee Moon.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (146, 'Paranoid', 'The Yardbirds', 'Black Sabbath', '1970-01-01', '2018-08-07 08:57:19.939000', '/media/Paranoid.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (147, 'Saturday Night Fever: The Original Movie Sound Track', 'Neil Young & Crazy Horse', 'Various Artists', '1977-01-01', '2018-08-07 08:57:19.939000', '/media/Saturday Night Fever: The Original Movie Sound Track.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (156, 'Live at the Regal', 'Buzzcocks', 'B.B. King', '1965-01-01', '2018-08-07 08:57:19.939000', '/media/Live at the Regal.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (157, 'A Christmas Gift for You From Phil Spector', 'OutKast', 'Phil Spector', '1963-01-01', '2018-08-07 08:57:19.939000', '/media/A Christmas Gift for You From Phil Spector.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (158, 'Gris-Gris', 'The Smashing Pumpkins', 'Dr. John, the Night Tripper', '1968-01-01', '2018-08-07 08:57:19.939000', '/media/Gris-Gris.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (159, 'Straight Outta Compton', 'New Order', 'N.W.A', '1988-01-01', '2018-08-07 08:57:19.939000', '/media/Straight Outta Compton.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (152, 'Tim', 'Randy Newman', 'The Replacements', '1985-01-01', '2018-08-07 08:57:19.939000', '/media/Tim.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (153, 'The Chronic', 'The Rolling Stones', 'Dr. Dre', '1992-01-01', '2018-08-07 08:57:19.939000', '/media/The Chronic.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (154, 'Rejuvenation', 'Miles Davis', 'The Meters', '1974-01-01', '2018-08-07 08:57:19.939000', '/media/Rejuvenation.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (155, 'Parallel Lines', 'Elton John', 'Blondie', '1978-01-01', '2018-08-07 08:57:19.939000', '/media/Parallel Lines.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (228, 'Tattoo You', 'Brian Eno', 'The Rolling Stones', '1981-01-01', '2018-08-07 08:57:19.939000', '/media/Tattoo You.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (229, 'Proud Mary: The Best of Ike and Tina Turner', 'George Harrison', 'Ike & Tina Turner', '1991-01-01', '2018-08-07 08:57:19.939000', '/media/Proud Mary: The Best of Ike and Tina Turner.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (230, 'New York Dolls', 'Big Star', 'New York Dolls', '1973-01-01', '2018-08-07 08:57:19.939000', '/media/New York Dolls.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (231, 'Bo Diddley / Go Bo Diddley', 'Nirvana', 'Bo Diddley', '1986-01-01', '2018-08-07 08:57:19.939000', '/media/Bo Diddley / Go Bo Diddley.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (224, 'Ten', 'The Police', 'Pearl Jam', '1991-01-01', '2018-08-07 08:57:19.939000', '/media/Ten.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (225, 'Everybody Knows This Is Nowhere', 'Brian Eno', 'Neil Young & Crazy Horse', '1969-01-01', '2018-08-07 08:57:19.939000', '/media/Everybody Knows This Is Nowhere.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (226, 'Wish You Were Here', 'Vampire Weekend', 'Pink Floyd', '1975-01-01', '2018-08-07 08:57:19.939000', '/media/Wish You Were Here.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (227, 'Crooked Rain Crooked Rain', 'PJ Harvey', 'Pavement', '1994-01-01', '2018-08-07 08:57:19.939000', '/media/Crooked Rain Crooked Rain.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (236, 'Loveless', 'The Pogues', 'My Bloody Valentine', '1991-01-01', '2018-08-07 08:57:19.939000', '/media/Loveless.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (237, 'New Orleans Piano', 'Suicide', 'Professor Longhair', '1972-01-01', '2018-08-07 08:57:19.939000', '/media/New Orleans Piano.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (239, 'The Neil Diamond Collection', 'Cheap Trick', 'Neil Diamond', '1999-01-01', '2018-08-07 08:57:19.939000', '/media/The Neil Diamond Collection.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (232, 'Two Steps From the Blues', 'Beck', 'Bobby "Blue" Bland', '1961-01-01', '2018-08-07 08:57:19.939000', '/media/Two Steps From the Blues.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (233, 'The Queen Is Dead', 'Lil Wayne', 'The Smiths', '1986-01-01', '2018-08-07 08:57:19.939000', '/media/The Queen Is Dead.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (234, 'Licensed to Ill', 'The Cure', 'Beastie Boys', '1986-01-01', '2018-08-07 08:57:19.939000', '/media/Licensed to Ill.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (235, 'Look-Ka Py Py', 'Sam Cooke', 'The Meters', '1970-01-01', '2018-08-07 08:57:19.939000', '/media/Look-Ka Py Py.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (244, 'Toys in the Attic', 'The Police', 'Aerosmith', '1975-01-01', '2018-08-07 08:57:19.939000', '/media/Toys in the Attic.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (245, 'Nick of Time', 'Big Star', 'Bonnie Raitt', '1989-01-01', '2018-08-07 08:57:19.939000', '/media/Nick of Time.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (246, 'A Night at the Opera', 'Jackson Browne', 'Queen', '1975-01-01', '2018-08-07 08:57:19.939000', '/media/A Night at the Opera.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (247, 'The Kink Kronikles', 'Amy Winehouse', 'The Kinks', '1972-01-01', '2018-08-07 08:57:19.939000', '/media/The Kink Kronikles.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (240, 'American Idiot', 'War', 'Green Day', '2004-01-01', '2018-08-07 08:57:19.939000', '/media/American Idiot.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (241, 'Nebraska', 'Steve Miller Band', 'Bruce Springsteen', '1982-01-01', '2018-08-07 08:57:19.939000', '/media/Nebraska.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (242, 'Doolittle', 'MC5', 'Pixies', '1989-01-01', '2018-08-07 08:57:19.939000', '/media/Doolittle.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (243, 'Paid in Full', 'Stan Getz / Joao Gilberto featuring Antonio Carlos Jobim', 'Eric B. & Rakim', '1987-01-01', '2018-08-07 08:57:19.939000', '/media/Paid in Full.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (252, 'My Generation', 'Marvin Gaye', 'The Who', '1965-01-01', '2018-08-07 08:57:19.939000', '/media/My Generation.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (253, 'Howlin'' Wolf', 'My Morning Jacket', 'Howlin'' Wolf', '1962-01-01', '2018-08-07 08:57:19.939000', '/media/Howlin'' Wolf.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (254, 'Like a Prayer', 'Elton John', 'Madonna', '1989-01-01', '2018-08-07 08:57:19.939000', '/media/Like a Prayer.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (255, 'Can''t Buy a Thrill', 'The Drifters', 'Steely Dan', '1972-01-01', '2018-08-07 08:57:19.939000', '/media/Can''t Buy a Thrill.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (248, 'Mr. Tambourine Man', 'John Prine', 'The Byrds', '1965-01-01', '2018-08-07 08:57:19.939000', '/media/Mr. Tambourine Man.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (249, 'Bookends', 'EPMD', 'Simon & Garfunkel', '1968-01-01', '2018-08-07 08:57:19.939000', '/media/Bookends.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (238, 'War', 'DEVO', 'U2', '1983-01-01', '2018-08-07 08:57:19.939000', '/media/War.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (250, 'The Ultimate Collection', 'Alice Cooper', 'Patsy Cline', '2000-01-01', '2018-08-07 08:57:19.939000', '/media/The Ultimate Collection.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (251, 'Mr. Excitement!', 'Los Lobos', 'Jackie Wilson', '1992-01-01', '2018-08-07 08:57:19.939000', '/media/Mr. Excitement!.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (196, 'Natty Dread', 'The Temptations', 'Bob Marley & The Wailers', '1974-01-01', '2018-08-07 08:57:19.939000', '/media/Natty Dread.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (197, 'Fleetwood Mac', 'Red Hot Chili Peppers', 'Fleetwood Mac', '1975-01-01', '2018-08-07 08:57:19.939000', '/media/Fleetwood Mac.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (198, 'Red Headed Stranger', 'Nas', 'Willie Nelson', '1975-01-01', '2018-08-07 08:57:19.939000', '/media/Red Headed Stranger.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (199, 'The Immaculate Collection', 'Lynyrd Skynyrd', 'Madonna', '1990-01-01', '2018-08-07 08:57:19.939000', '/media/The Immaculate Collection.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (192, 'One Nation Under a Groove', 'Roxy Music', 'Funkadelic', '1978-01-01', '2018-08-07 08:57:19.939000', '/media/One Nation Under a Groove.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (193, 'The Anthology: 1961-1977', 'Massive Attack', 'Curtis Mayfield and The Impressions', '1992-01-01', '2018-08-07 08:57:19.939000', '/media/The Anthology: 1961-1977.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (194, 'The Definitive Collection', 'ZZ Top', 'ABBA', '2001-01-01', '2018-08-07 08:57:19.939000', '/media/The Definitive Collection.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (195, 'The Rolling Stones, Now!', 'Tom Waits', 'The Rolling Stones', '1965-01-01', '2018-08-07 08:57:19.939000', '/media/The Rolling Stones, Now!.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (204, 'Happy Trails', 'Sinead O''Connor', 'Quicksilver Messenger Service', '1969-01-01', '2018-08-07 08:57:19.939000', '/media/Happy Trails.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (205, 'From Elvis in Memphis', 'The Doors', 'Elvis Presley', '1969-01-01', '2018-08-07 08:57:19.939000', '/media/From Elvis in Memphis.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (206, 'Fun House', 'Bob Dylan', 'The Stooges', '1970-01-01', '2018-08-07 08:57:19.939000', '/media/Fun House.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (207, 'The Gilded Palace of Sin', 'Eric Clapton', 'The Flying Burrito Brothers', '1969-01-01', '2018-08-07 08:57:19.939000', '/media/The Gilded Palace of Sin.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (200, 'The Stooges', 'Dr. John', 'The Stooges', '1969-01-01', '2018-08-07 08:57:19.939000', '/media/The Stooges.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (201, 'Fresh', 'Big Star', 'Sly & The Family Stone', '1973-01-01', '2018-08-07 08:57:19.939000', '/media/Fresh.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (202, 'So', 'PJ Harvey', 'Peter Gabriel', '1986-01-01', '2018-08-07 08:57:19.939000', '/media/So.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (203, 'Buffalo Springfield Again', 'The Clash', 'Buffalo Springfield', '1967-01-01', '2018-08-07 08:57:19.939000', '/media/Buffalo Springfield Again.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (212, 'Murmur', 'Tom Waits', 'R.E.M.', '1983-01-01', '2018-08-07 08:57:19.939000', '/media/Murmur.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (213, 'The Best of Little Walter', 'U2', 'Little Walter', '1967-01-01', '2018-08-07 08:57:19.939000', '/media/The Best of Little Walter.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (214, 'Is This It', 'Paul McCartney & Wings', 'The Strokes', '2001-01-01', '2018-08-07 08:57:19.939000', '/media/Is This It.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (215, 'Highway to Hell', 'Portishead', 'AC/DC', '1979-01-01', '2018-08-07 08:57:19.939000', '/media/Highway to Hell.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (208, 'Dookie', 'Wire', 'Green Day', '1994-01-01', '2018-08-07 08:57:19.939000', '/media/Dookie.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (209, 'Transformer', 'Minutemen', 'Lou Reed', '1972-01-01', '2018-08-07 08:57:19.939000', '/media/Transformer.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (210, 'Blues Breakers With Eric Clapton ("The Beano Album")', 'The Go Go''s', 'John Mayall & The Bluesbreakers', '1966-01-01', '2018-08-07 08:57:19.939000', '/media/Blues Breakers With Eric Clapton ("The Beano Album").wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (211, 'Nuggets: Original Artyfacts From the First Psychedelic Era, 1965-1968', 'Van Halen', 'Various Artists', '1998-01-01', '2018-08-07 08:57:19.939000', '/media/Nuggets: Original Artyfacts From the First Psychedelic Era, 1965-1968.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (220, 'Wheels of Fire', 'Bruce Springsteen', 'Cream', '1968-01-01', '2018-08-07 08:57:19.939000', '/media/Wheels of Fire.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (221, 'Dirty Mind', 'Gram Parsons', 'Prince', '1980-01-01', '2018-08-07 08:57:19.939000', '/media/Dirty Mind.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (222, 'Abraxas', 'Cheap Trick', 'Santana', '1970-01-01', '2018-08-07 08:57:19.939000', '/media/Abraxas.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (223, 'Tea for the Tillerman', 'Peter Wolf', 'Cat Stevens', '1970-01-01', '2018-08-07 08:57:19.939000', '/media/Tea for the Tillerman.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (216, 'The Downward Spiral', 'The Crickets', 'Nine Inch Nails', '1994-01-01', '2018-08-07 08:57:19.939000', '/media/The Downward Spiral.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (217, 'Parsley, Sage, Rosemary and Thyme', 'Various Artists', 'Simon & Garfunkel', '1966-01-01', '2018-08-07 08:57:19.939000', '/media/Parsley, Sage, Rosemary and Thyme.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (218, 'Bad', 'The Ronettes', 'Michael Jackson', '1987-01-01', '2018-08-07 08:57:19.939000', '/media/Bad.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (219, 'Modern Times', 'Diana Ross & The Supremes', 'Bob Dylan', '2006-01-01', '2018-08-07 08:57:19.939000', '/media/Modern Times.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (38, 'John Lennon/Plastic Ono Band', 'Run D.M.C.', 'John Lennon / Plastic Ono Band', '1970-01-01', '2018-08-07 08:57:19.939000', '/media/John Lennon/Plastic Ono Band.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (39, 'Innervisions', 'Black Sabbath', 'Stevie Wonder', '1973-01-01', '2018-08-07 08:57:19.939000', '/media/Innervisions.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (32, 'Nevermind', 'Jackie Wilson', 'Nirvana', '1991-01-01', '2018-08-07 08:57:19.939000', '/media/Nevermind.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (33, 'Born to Run', 'The Who', 'Bruce Springsteen', '1975-01-01', '2018-08-07 08:57:19.939000', '/media/Born to Run.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (34, 'Astral Weeks', 'Howlin'' Wolf', 'Van Morrison', '1968-01-01', '2018-08-07 08:57:19.939000', '/media/Astral Weeks.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (35, 'Thriller', 'Madonna', 'Michael Jackson', '1982-01-01', '2018-08-07 08:57:19.939000', '/media/Thriller.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (44, 'Led Zeppelin', 'Ornette Coleman', 'Led Zeppelin', '1969-01-01', '2018-08-07 08:57:19.939000', '/media/Led Zeppelin.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (45, 'Blue', 'R.E.M.', 'Joni Mitchell', '1971-01-01', '2018-08-07 08:57:19.939000', '/media/Blue.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (46, 'Bringing It All Back Home', 'Jay Z', 'Bob Dylan', '1965-01-01', '2018-08-07 08:57:19.939000', '/media/Bringing It All Back Home.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (47, 'Let It Bleed', 'David Bowie', 'The Rolling Stones', '1969-01-01', '2018-08-07 08:57:19.939000', '/media/Let It Bleed.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (40, 'Live at the Apollo, 1962', 'Eminem', 'James Brown', '1963-01-01', '2018-08-07 08:57:19.939000', '/media/Live at the Apollo, 1962.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (41, 'Rumours', 'Jerry Lee Lewis', 'Fleetwood Mac', '1977-01-01', '2018-08-07 08:57:19.939000', '/media/Rumours.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (42, 'The Joshua Tree', 'The Mothers of Invention', 'U2', '1987-01-01', '2018-08-07 08:57:19.939000', '/media/The Joshua Tree.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (43, 'Who''s Next', 'The Grateful Dead', 'The Who', '1971-01-01', '2018-08-07 08:57:19.939000', '/media/Who''s Next.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (52, 'Hotel California', 'Kraftwerk', 'Eagles', '1976-01-01', '2018-08-07 08:57:19.939000', '/media/Hotel California.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (53, 'The Anthology', 'Whitney Houston', 'Muddy Waters', '2001-01-01', '2018-08-07 08:57:19.939000', '/media/The Anthology.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (54, 'Please Please Me', 'The Kinks', 'The Beatles', '1963-01-01', '2018-08-07 08:57:19.939000', '/media/Please Please Me.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (55, 'Forever Changes', 'Janet', 'Love', '1967-01-01', '2018-08-07 08:57:19.939000', '/media/Forever Changes.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (48, 'Ramones', 'Jay Z', 'Ramones', '1976-01-01', '2018-08-07 08:57:19.939000', '/media/Ramones.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (49, 'Music From Big Pink', 'Bruce Springsteen', 'The Band', '1968-01-01', '2018-08-07 08:57:19.939000', '/media/Music From Big Pink.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (50, 'The Rise and Fall of Ziggy Stardust and the Spiders From Mars', 'Otis Redding', 'David Bowie', '1972-01-01', '2018-08-07 08:57:19.939000', '/media/The Rise and Fall of Ziggy Stardust and the Spiders From Mars.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (51, 'Tapestry', 'Metallica', 'Carole King', '1971-01-01', '2018-08-07 08:57:19.939000', '/media/Tapestry.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (60, 'The Band ("The Brown Album")', 'Grateful Dead', 'The Band', '1969-01-01', '2018-08-07 08:57:19.939000', '/media/The Band ("The Brown Album").wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (61, 'Legend: The Best of Bob Marley and The Wailers', 'Ray Charles', 'Bob Marley & The Wailers', '1984-01-01', '2018-08-07 08:57:19.939000', '/media/Legend: The Best of Bob Marley and The Wailers.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (62, 'A Love Supreme', 'Blood, Sweat & Tears', 'John Coltrane', '1965-01-01', '2018-08-07 08:57:19.939000', '/media/A Love Supreme.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (63, 'It Takes a Nation of Millions to Hold Us Back', 'The Who', 'Public Enemy', '1988-01-01', '2018-08-07 08:57:19.939000', '/media/It Takes a Nation of Millions to Hold Us Back.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (56, 'Never Mind the Bollocks Here''s the Sex Pistols', 'Willie Nelson', 'Sex Pistols', '1977-01-01', '2018-08-07 08:57:19.939000', '/media/Never Mind the Bollocks Here''s the Sex Pistols.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (57, 'The Doors', 'Grateful Dead', 'The Doors', '1967-01-01', '2018-08-07 08:57:19.939000', '/media/The Doors.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (58, 'The Dark Side of the Moon', 'Crosby, Stills & Nash', 'Pink Floyd', '1973-01-01', '2018-08-07 08:57:19.939000', '/media/The Dark Side of the Moon.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (59, 'Horses', 'Tracy Chapman', 'Patti Smith', '1975-01-01', '2018-08-07 08:57:19.939000', '/media/Horses.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (28, 'The Velvet Underground & Nico', 'The Kinks', 'The Velvet Underground', '1967-01-01', '2018-08-07 08:57:19.939000', '/media/The Velvet Underground & Nico.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (29, 'Abbey Road', 'The Byrds', 'The Beatles', '1969-01-01', '2018-08-07 08:57:19.939000', '/media/Abbey Road.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (30, 'Are You Experienced', 'Simon & Garfunkel', 'The Jimi Hendrix Experience', '1967-01-01', '2018-08-07 08:57:19.939000', '/media/Are You Experienced.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (31, 'Blood on the Tracks', 'Patsy Cline', 'Bob Dylan', '1975-01-01', '2018-08-07 08:57:19.939000', '/media/Blood on the Tracks.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (24, 'Blonde on Blonde', 'Eric B. & Rakim', 'Bob Dylan', '1966-01-01', '2018-08-07 08:57:19.939000', '/media/Blonde on Blonde.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (25, 'The Beatles ("The White Album")', 'Aerosmith', 'The Beatles', '1968-01-01', '2018-08-07 08:57:19.939000', '/media/The Beatles ("The White Album").wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (26, 'The Sun Sessions', 'Bonnie Raitt', 'Elvis Presley', '1976-01-01', '2018-08-07 08:57:19.939000', '/media/The Sun Sessions.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (27, 'Kind of Blue', 'Queen', 'Miles Davis', '1959-01-01', '2018-08-07 08:57:19.939000', '/media/Kind of Blue.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (100, 'Lady Soul', 'Jeff Buckley', 'Aretha Franklin', '1968-01-01', '2018-08-07 08:57:19.939000', '/media/Lady Soul.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (101, 'Born in the U.S.A.', 'Lucinda Williams', 'Bruce Springsteen', '1984-01-01', '2018-08-07 08:57:19.939000', '/media/Born in the U.S.A..wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (102, 'The Wall', 'Beck', 'Pink Floyd', '1979-01-01', '2018-08-07 08:57:19.939000', '/media/The Wall.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (103, 'At Folsom Prison', 'The Beatles', 'Johnny Cash', '1968-01-01', '2018-08-07 08:57:19.939000', '/media/At Folsom Prison.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (96, 'The Clash', 'Black Sabbath', 'The Clash', '1977-01-01', '2018-08-07 08:57:19.939000', '/media/The Clash.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (97, 'Harvest', 'Dolly Parton', 'Neil Young', '1972-01-01', '2018-08-07 08:57:19.939000', '/media/Harvest.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (98, 'Axis: Bold as Love', 'Public Enemy', 'The Jimi Hendrix Experience', '1967-01-01', '2018-08-07 08:57:19.939000', '/media/Axis: Bold as Love.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (99, 'I Never Loved a Man the Way I Love You', 'Bob Dylan', 'Aretha Franklin', '1967-01-01', '2018-08-07 08:57:19.939000', '/media/I Never Loved a Man the Way I Love You.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (108, 'Sign "Peace" the Times', 'Jane''s Addiction', 'Prince', '1987-01-01', '2018-08-07 08:57:19.939000', '/media/Sign "Peace" the Times.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (109, '40 Greatest Hits', 'Nirvana', 'Hank Williams', '1984-01-01', '2018-08-07 08:57:19.939000', '/media/40 Greatest Hits.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (110, 'Bitches Brew', 'Lauryn Hill', 'Miles Davis', '1970-01-01', '2018-08-07 08:57:19.939000', '/media/Bitches Brew.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (111, 'Tommy', 'Tom Petty and the Heartbreakers', 'The Who', '1969-01-01', '2018-08-07 08:57:19.939000', '/media/Tommy.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (104, 'Dusty in Memphis', 'Frank Sinatra', 'Dusty Springfield', '1969-01-01', '2018-08-07 08:57:19.939000', '/media/Dusty in Memphis.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (105, 'Talking Book', 'Creedence Clearwater Revival', 'Stevie Wonder', '1972-01-01', '2018-08-07 08:57:19.939000', '/media/Talking Book.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (106, 'Goodbye Yellow Brick Road', 'Red Hot Chili Peppers', 'Elton John', '1973-01-01', '2018-08-07 08:57:19.939000', '/media/Goodbye Yellow Brick Road.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (107, '20 Golden Greats', 'Various', 'Buddy Holly', '1978-01-01', '2018-08-07 08:57:19.939000', '/media/20 Golden Greats.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (116, 'In the Wee Small Hours', 'Radiohead', 'Frank Sinatra', '1955-01-01', '2018-08-07 08:57:19.939000', '/media/In the Wee Small Hours.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (117, 'Fresh Cream', 'Nick Drake', 'Cream', '1966-01-01', '2018-08-07 08:57:19.939000', '/media/Fresh Cream.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (118, 'Giant Steps', 'Randy Newman', 'John Coltrane', '1959-01-01', '2018-08-07 08:57:19.939000', '/media/Giant Steps.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (119, 'Sweet Baby James', 'The Police', 'James Taylor', '1970-01-01', '2018-08-07 08:57:19.939000', '/media/Sweet Baby James.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (112, 'The Freewheelin'' Bob Dylan', 'The Velvet Underground', 'Bob Dylan', '1963-01-01', '2018-08-07 08:57:19.939000', '/media/The Freewheelin'' Bob Dylan.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (113, 'This Year''s Model', 'Pixies', 'Elvis Costello', '1978-01-01', '2018-08-07 08:57:19.939000', '/media/This Year''s Model.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (114, 'There''s a Riot Goin'' On', 'The O''Jays', 'Sly & The Family Stone', '1971-01-01', '2018-08-07 08:57:19.939000', '/media/There''s a Riot Goin'' On.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (115, 'Odessey and Oracle', 'The Wailers', 'The Zombies', '1968-01-01', '2018-08-07 08:57:19.939000', '/media/Odessey and Oracle.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (124, 'Aftermath', 'Sonic Youth', 'The Rolling Stones', '1966-01-01', '2018-08-07 08:57:19.939000', '/media/Aftermath.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (125, 'Loaded', 'James Brown', 'The Velvet Underground', '1970-01-01', '2018-08-07 08:57:19.939000', '/media/Loaded.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (126, 'The Bends', 'Neil Young', 'Radiohead', '1995-01-01', '2018-08-07 08:57:19.939000', '/media/The Bends.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (127, 'If You Can Believe Your Eyes and Ears', 'The Beatles', 'The Mamas and the Papas', '1966-01-01', '2018-08-07 08:57:19.939000', '/media/If You Can Believe Your Eyes and Ears.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (120, 'Modern Sounds in Country and Western Music', 'David Bowie', 'Ray Charles', '1962-01-01', '2018-08-07 08:57:19.939000', '/media/Modern Sounds in Country and Western Music.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (121, 'Rocket to Russia', 'Eric Clapton', 'Ramones', '1977-01-01', '2018-08-07 08:57:19.939000', '/media/Rocket to Russia.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (122, 'Portrait of a Legend 1951-1964', 'The Cure', 'Sam Cooke', '2003-01-01', '2018-08-07 08:57:19.939000', '/media/Portrait of a Legend 1951-1964.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (123, 'Hunky Dory', 'Liz Phair', 'David Bowie', '1971-01-01', '2018-08-07 08:57:19.939000', '/media/Hunky Dory.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (68, 'Meet The Beatles!', 'Sleater Kinney', 'The Beatles', '1964-01-01', '2018-08-07 08:57:19.939000', '/media/Meet The Beatles!.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (69, 'The Birth of Soul', 'Smokey Robinson & The Miracles', 'Ray Charles', '1991-01-01', '2018-08-07 08:57:19.939000', '/media/The Birth of Soul.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (70, 'Electric Ladyland', 'LaBelle', 'The Jimi Hendrix Experience', '1968-01-01', '2018-08-07 08:57:19.939000', '/media/Electric Ladyland.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (71, 'Elvis Presley', 'Eminem', 'Elvis Presley', '1956-01-01', '2018-08-07 08:57:19.939000', '/media/Elvis Presley.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (64, 'At Fillmore East', 'Paul Simon', 'The Allman Brothers Band', '1971-01-01', '2018-08-07 08:57:19.939000', '/media/At Fillmore East.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (65, 'Here''s Little Richard', 'The Jesus and Mary Chain', 'Little Richard', '1957-01-01', '2018-08-07 08:57:19.939000', '/media/Here''s Little Richard.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (66, 'Bridge Over Troubled Water', 'The Rolling Stones', 'Simon & Garfunkel', '1970-01-01', '2018-08-07 08:57:19.939000', '/media/Bridge Over Troubled Water.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (67, 'Greatest Hits', 'The Beach Boys', 'Al Green', '1975-01-01', '2018-08-07 08:57:19.939000', '/media/Greatest Hits.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (76, 'Greatest Hits', 'U2', 'Sly & The Family Stone', '1970-01-01', '2018-08-07 08:57:19.939000', '/media/Greatest Hits.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (77, 'Appetite for Destruction', 'Mary J. Blige', 'Guns N'' Roses', '1987-01-01', '2018-08-07 08:57:19.939000', '/media/Appetite for Destruction.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (78, 'Achtung Baby', 'Muddy Waters', 'U2', '1991-01-01', '2018-08-07 08:57:19.939000', '/media/Achtung Baby.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (79, 'Sticky Fingers', 'Barry White', 'The Rolling Stones', '1971-01-01', '2018-08-07 08:57:19.939000', '/media/Sticky Fingers.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (72, 'Songs in the Key of Life', 'Parliament', 'Stevie Wonder', '1976-01-01', '2018-08-07 08:57:19.939000', '/media/Songs in the Key of Life.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (73, 'Beggars Banquet', 'Janet Jackson', 'The Rolling Stones', '1968-01-01', '2018-08-07 08:57:19.939000', '/media/Beggars Banquet.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (74, 'Chronicle: The 20 Greatest Hits', 'Various', 'Creedence Clearwater Revival', '1976-01-01', '2018-08-07 08:57:19.939000', '/media/Chronicle: The 20 Greatest Hits.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (75, 'Trout Mask Replica', 'David Bowie', 'Captain Beefheart & His Magic Band', '1969-01-01', '2018-08-07 08:57:19.939000', '/media/Trout Mask Replica.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (84, '[Led Zeppelin IV]', 'Grateful Dead', 'Led Zeppelin', '1971-01-01', '2018-08-07 08:57:19.939000', '/media/[Led Zeppelin IV].wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (85, 'The Stranger', 'The Kinks', 'Billy Joel', '1977-01-01', '2018-08-07 08:57:19.939000', '/media/The Stranger.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (86, 'Graceland', 'Al Green', 'Paul Simon', '1986-01-01', '2018-08-07 08:57:19.939000', '/media/Graceland.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (87, 'Superfly', 'Talking Heads', 'Curtis Mayfield', '1972-01-01', '2018-08-07 08:57:19.939000', '/media/Superfly.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (80, 'Back to Mono (1958-1969)', 'The Cars', 'Phil Spector', '1991-01-01', '2018-08-07 08:57:19.939000', '/media/Back to Mono (1958-1969).wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (81, 'Moondance', 'Stevie Wonder', 'Van Morrison', '1970-01-01', '2018-08-07 08:57:19.939000', '/media/Moondance.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (82, 'Kid A', 'Al Green', 'Radiohead', '2000-01-01', '2018-08-07 08:57:19.939000', '/media/Kid A.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (83, 'Off the Wall', 'X', 'Michael Jackson', '1979-01-01', '2018-08-07 08:57:19.939000', '/media/Off the Wall.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (92, 'Back in Black', 'The Smiths', 'AC/DC', '1980-01-01', '2018-08-07 08:57:19.939000', '/media/Back in Black.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (93, 'Otis Blue: Otis Redding Sings Soul', 'The Mothers of Invention', 'Otis Redding', '1965-01-01', '2018-08-07 08:57:19.939000', '/media/Otis Blue: Otis Redding Sings Soul.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (94, 'Led Zeppelin II', 'Kanye West', 'Led Zeppelin', '1969-01-01', '2018-08-07 08:57:19.939000', '/media/Led Zeppelin II.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (95, 'Imagine', 'Weezer', 'John Lennon', '1971-01-01', '2018-08-07 08:57:19.939000', '/media/Imagine.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (88, 'Physical Graffiti', 'Bob Dylan and the Band', 'Led Zeppelin', '1975-01-01', '2018-08-07 08:57:19.939000', '/media/Physical Graffiti.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (89, 'After the Gold Rush', 'The Velvet Underground', 'Neil Young', '1970-01-01', '2018-08-07 08:57:19.939000', '/media/After the Gold Rush.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (90, 'Star Time', 'MC5', 'James Brown', '1991-01-01', '2018-08-07 08:57:19.939000', '/media/Star Time.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (91, 'Purple Rain', 'Leonard Cohen', 'Prince and the Revolution', '1984-01-01', '2018-08-07 08:57:19.939000', '/media/Purple Rain.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (420, 'Radio City', 'Moby Grape', 'Big Star', '1974-01-01', '2018-08-07 08:57:19.939000', '/media/Radio City.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (421, 'Rid of Me', 'Janis Joplin', 'PJ Harvey', '1993-01-01', '2018-08-07 08:57:19.939000', '/media/Rid of Me.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (422, 'Sandinista!', 'The Wailers', 'The Clash', '1980-01-01', '2018-08-07 08:57:19.939000', '/media/Sandinista!.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (423, 'I Do Not Want What I Haven''t Got', 'The Byrds', 'Sinead O''Connor', '1989-01-01', '2018-08-07 08:57:19.939000', '/media/I Do Not Want What I Haven''t Got.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (416, 'Californication', 'The Byrds', 'Red Hot Chili Peppers', '1999-01-01', '2018-08-07 08:57:19.939000', '/media/Californication.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (417, 'Illmatic', 'Sly & The Family Stone', 'Nas', '1994-01-01', '2018-08-07 08:57:19.939000', '/media/Illmatic.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (418, '(pronounced ''leh-''nerd ''skin-''nerd)', 'Various Artists', 'Lynyrd Skynyrd', '1973-01-01', '2018-08-07 08:57:19.939000', '/media/(pronounced ''leh-''nerd ''skin-''nerd).wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (419, 'Dr. John''s Gumbo', 'Run D.M.C.', 'Dr. John', '1972-01-01', '2018-08-07 08:57:19.939000', '/media/Dr. John''s Gumbo.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (428, 'Double Nickels on the Dime', 'Various Artists', 'Minutemen', '1984-01-01', '2018-08-07 08:57:19.939000', '/media/Double Nickels on the Dime.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (429, 'Beauty and the Beat', 'Bruce Springsteen', 'The Go Go''s', '1981-01-01', '2018-08-07 08:57:19.939000', '/media/Beauty and the Beat.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (430, 'Van Halen', 'The Notorious B.I.G.', 'Van Halen', '1978-01-01', '2018-08-07 08:57:19.939000', '/media/Van Halen.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (431, 'Mule Variations', 'Pavement', 'Tom Waits', '1999-01-01', '2018-08-07 08:57:19.939000', '/media/Mule Variations.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (424, 'Strange Days', 'Iggy and The Stooges', 'The Doors', '1967-01-01', '2018-08-07 08:57:19.939000', '/media/Strange Days.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (425, 'Time Out of Mind', 'Talking Heads', 'Bob Dylan', '1997-01-01', '2018-08-07 08:57:19.939000', '/media/Time Out of Mind.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (426, '461 Ocean Boulevard', 'Television', 'Eric Clapton', '1974-01-01', '2018-08-07 08:57:19.939000', '/media/461 Ocean Boulevard.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (427, 'Pink Flag', 'Black Sabbath', 'Wire', '1977-01-01', '2018-08-07 08:57:19.939000', '/media/Pink Flag.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (436, 'The Best of the Girl Groups, Volume 1', 'Blondie', 'Various Artists', '1990-01-01', '2018-08-07 08:57:19.939000', '/media/The Best of the Girl Groups, Volume 1.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (437, 'Presenting the Fabulous Ronettes Featuring Veronica', 'B.B. King', 'The Ronettes', '1963-01-01', '2018-08-07 08:57:19.939000', '/media/Presenting the Fabulous Ronettes Featuring Veronica.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (438, 'Anthology', 'Phil Spector', 'Diana Ross & The Supremes', '2001-01-01', '2018-08-07 08:57:19.939000', '/media/Anthology.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (439, 'The Rising', 'Dr. John, the Night Tripper', 'Bruce Springsteen', '2002-01-01', '2018-08-07 08:57:19.939000', '/media/The Rising.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (432, 'Boy', 'Elton John', 'U2', '1980-01-01', '2018-08-07 08:57:19.939000', '/media/Boy.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (433, 'Band on the Run', 'The Replacements', 'Paul McCartney & Wings', '1973-01-01', '2018-08-07 08:57:19.939000', '/media/Band on the Run.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (434, 'Dummy', 'Dr. Dre', 'Portishead', '1994-01-01', '2018-08-07 08:57:19.939000', '/media/Dummy.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (435, 'The "Chirping" Crickets', 'The Meters', 'The Crickets', '1957-01-01', '2018-08-07 08:57:19.939000', '/media/The "Chirping" Crickets.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (444, 'Another Green World', 'Led Zeppelin', 'Brian Eno', '1975-01-01', '2018-08-07 08:57:19.939000', '/media/Another Green World.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (445, 'Vampire Weekend', 'Santana', 'Vampire Weekend', '2007-01-01', '2018-08-07 08:57:19.939000', '/media/Vampire Weekend.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (446, 'Stories From the City, Stories From the Sea', 'Bruce Springsteen', 'PJ Harvey', '2000-01-01', '2018-08-07 08:57:19.939000', '/media/Stories From the City, Stories From the Sea.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (447, 'Here Come the Warm Jets', 'Arcade Fire', 'Brian Eno', '1973-01-01', '2018-08-07 08:57:19.939000', '/media/Here Come the Warm Jets.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (440, 'Grievous Angel', 'N.W.A', 'Gram Parsons', '1974-01-01', '2018-08-07 08:57:19.939000', '/media/Grievous Angel.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (441, 'Cheap Trick at Budokan', 'Steely Dan', 'Cheap Trick', '1978-01-01', '2018-08-07 08:57:19.939000', '/media/Cheap Trick at Budokan.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (442, 'Sleepless', 'Jefferson Airplane', 'Peter Wolf', '2002-01-01', '2018-08-07 08:57:19.939000', '/media/Sleepless.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (443, 'Outlandos d''Amour', 'Crosby, Stills, Nash & Young', 'The Police', '1978-01-01', '2018-08-07 08:57:19.939000', '/media/Outlandos d''Amour.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (388, 'Volunteers', 'Buddy Holly', 'Jefferson Airplane', '1969-01-01', '2018-08-07 08:57:19.939000', '/media/Volunteers.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (389, 'Siren', 'Prince', 'Roxy Music', '1975-01-01', '2018-08-07 08:57:19.939000', '/media/Siren.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (390, 'Late for the Sky', 'Hank Williams', 'Jackson Browne', '1974-01-01', '2018-08-07 08:57:19.939000', '/media/Late for the Sky.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (391, 'Post', 'Miles Davis', 'Bjork', '1995-01-01', '2018-08-07 08:57:19.939000', '/media/Post.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (384, 'Louder Than Bombs', 'Johnny Cash', 'The Smiths', '1987-01-01', '2018-08-07 08:57:19.939000', '/media/Louder Than Bombs.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (385, 'Mott', 'Dusty Springfield', 'Mott the Hoople', '1973-01-01', '2018-08-07 08:57:19.939000', '/media/Mott.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (386, 'Whatever People Say I Am, That''s What I''m Not', 'Stevie Wonder', 'Arctic Monkeys', '2006-01-01', '2018-08-07 08:57:19.939000', '/media/Whatever People Say I Am, That''s What I''m Not.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (387, 'Reggatta de Blanc', 'Elton John', 'The Police', '1979-01-01', '2018-08-07 08:57:19.939000', '/media/Reggatta de Blanc.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (396, 'The Smile Sessions', 'The Zombies', 'The Beach Boys', '2011-01-01', '2018-08-07 08:57:19.939000', '/media/The Smile Sessions.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (397, 'The Modern Lovers', 'Frank Sinatra', 'The Modern Lovers', '1976-01-01', '2018-08-07 08:57:19.939000', '/media/The Modern Lovers.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (398, 'More Songs About Buildings and Food', 'Cream', 'Talking Heads', '1978-01-01', '2018-08-07 08:57:19.939000', '/media/More Songs About Buildings and Food.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (399, 'A Quick One', 'John Coltrane', 'The Who', '1966-01-01', '2018-08-07 08:57:19.939000', '/media/A Quick One.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (392, 'The Ultimate Collection: 1948-1990', 'The Who', 'John Lee Hooker', '1991-01-01', '2018-08-07 08:57:19.939000', '/media/The Ultimate Collection: 1948-1990.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (393, '(What''s the Story) Morning Glory?', 'Bob Dylan', 'Oasis', '1995-01-01', '2018-08-07 08:57:19.939000', '/media/(What''s the Story) Morning Glory?.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (394, 'CrazySexyCool', 'Elvis Costello', 'TLC', '1994-01-01', '2018-08-07 08:57:19.939000', '/media/CrazySexyCool.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (395, 'Funky Kingston', 'Sly & The Family Stone', 'Toots & The Maytals', '1973-01-01', '2018-08-07 08:57:19.939000', '/media/Funky Kingston.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (404, 'The End of the Innocence', 'David Bowie', 'Don Henley', '1989-01-01', '2018-08-07 08:57:19.939000', '/media/The End of the Innocence.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (405, 'Elephant', 'The Rolling Stones', 'The White Stripes', '2003-01-01', '2018-08-07 08:57:19.939000', '/media/Elephant.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (406, 'The Pretender', 'The Velvet Underground', 'Jackson Browne', '1976-01-01', '2018-08-07 08:57:19.939000', '/media/The Pretender.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (407, 'Let It Be', 'Radiohead', 'The Beatles', '1970-01-01', '2018-08-07 08:57:19.939000', '/media/Let It Be.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (400, 'Love and Theft', 'James Taylor', 'Bob Dylan', '2001-01-01', '2018-08-07 08:57:19.939000', '/media/"Love and Theft".wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (401, 'Pretzel Logic', 'Ray Charles', 'Steely Dan', '1974-01-01', '2018-08-07 08:57:19.939000', '/media/Pretzel Logic.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (402, 'Enter the Wu_Tang: 36 Chambers', 'Ramones', 'Wu Tang Clan', '1993-01-01', '2018-08-07 08:57:19.939000', '/media/Enter the Wu_Tang: 36 Chambers.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (403, 'The Indestructible Beat of Soweto', 'Sam Cooke', 'Various Artists', '1985-01-01', '2018-08-07 08:57:19.939000', '/media/The Indestructible Beat of Soweto.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (412, 'Blue Lines', 'The Rolling Stones', 'Massive Attack', '1991-01-01', '2018-08-07 08:57:19.939000', '/media/Blue Lines.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (413, 'Eliminator', 'Derek and the Dominos', 'ZZ Top', '1983-01-01', '2018-08-07 08:57:19.939000', '/media/Eliminator.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (414, 'Rain Dogs', 'Kanye West', 'Tom Waits', '1985-01-01', '2018-08-07 08:57:19.939000', '/media/Rain Dogs.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (415, 'Anthology: The Best of The Temptations', 'Etta James', 'The Temptations', '1995-01-01', '2018-08-07 08:57:19.939000', '/media/Anthology: The Best of The Temptations.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (408, 'Kala', 'The Mamas and the Papas', 'M.I.A.', '2007-01-01', '2018-08-07 08:57:19.939000', '/media/Kala.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (409, 'Good Old Boys', 'Joni Mitchell', 'Randy Newman', '1974-01-01', '2018-08-07 08:57:19.939000', '/media/Good Old Boys.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (410, 'Sound of Silver', 'Cream', 'LCD Soundsystem', '2007-01-01', '2018-08-07 08:57:19.939000', '/media/Sound of Silver.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (411, 'For Your Pleasure', 'The Who', 'Roxy Music', '1973-01-01', '2018-08-07 08:57:19.939000', '/media/For Your Pleasure.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (484, 'The Score', 'Buffalo Springfield', 'Fugees', '1996-01-01', '2018-08-07 08:57:19.939000', '/media/The Score.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (485, 'Radio', 'Quicksilver Messenger Service', 'L.L. Cool J', '1985-01-01', '2018-08-07 08:57:19.939000', '/media/Radio.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (486, 'I Want to See the Bright Lights Tonight', 'Elvis Presley', 'Richard & Linda Thompson', '1974-01-01', '2018-08-07 08:57:19.939000', '/media/I Want to See the Bright Lights Tonight.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (487, 'Faith', 'The Stooges', 'George Michael', '1987-01-01', '2018-08-07 08:57:19.939000', '/media/Faith.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (480, '69 Love Songs', 'Madonna', 'The Magnetic Fields', '1999-01-01', '2018-08-07 08:57:19.939000', '/media/69 Love Songs.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (481, 'A Rush of Blood to the Head', 'The Stooges', 'Coldplay', '2002-01-01', '2018-08-07 08:57:19.939000', '/media/A Rush of Blood to the Head.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (482, 'Tunnel of Love', 'Sly & The Family Stone', 'Bruce Springsteen', '1987-01-01', '2018-08-07 08:57:19.939000', '/media/Tunnel of Love.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (483, 'The Paul Butterfield Blues Band', 'Peter Gabriel', 'The Paul Butterfield Blues Band', '1965-01-01', '2018-08-07 08:57:19.939000', '/media/The Paul Butterfield Blues Band.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (492, 'Down Every Road', 'Various Artists', 'Merle Haggard', '1996-01-01', '2018-08-07 08:57:19.939000', '/media/Down Every Road.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (493, 'All Time Greatest Hits', 'R.E.M.', 'Loretta Lynn', '2002-01-01', '2018-08-07 08:57:19.939000', '/media/All Time Greatest Hits.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (494, 'Maggot Brain', 'Little Walter', 'Funkadelic', '1971-01-01', '2018-08-07 08:57:19.939000', '/media/Maggot Brain.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (495, 'Only Built 4 Cuban Linx', 'The Strokes', 'Raekwon', '1995-01-01', '2018-08-07 08:57:19.939000', '/media/Only Built 4 Cuban Linx.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (488, 'The Smiths', 'The Flying Burrito Brothers', 'The Smiths', '1984-01-01', '2018-08-07 08:57:19.939000', '/media/The Smiths.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (489, 'Proxima estacion: Esperanza', 'Green Day', 'Manu Chao', '2001-01-01', '2018-08-07 08:57:19.939000', '/media/Proxima estacion: Esperanza.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (490, 'Armed Forces', 'Lou Reed', 'Elvis Costello & The Attractions', '1979-01-01', '2018-08-07 08:57:19.939000', '/media/Armed Forces.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (491, 'Life After Death', 'John Mayall & The Bluesbreakers', 'The Notorious B.I.G.', '1997-01-01', '2018-08-07 08:57:19.939000', '/media/Life After Death.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (500, 'Vitalogy', 'Bob Dylan', 'Pearl Jam', '1994-01-01', '2018-08-07 08:57:19.939000', '/media/Vitalogy.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (501, 'That''s the Way of the World', 'Cream', 'Earth, Wind & Fire', '1975-01-01', '2018-08-07 08:57:19.939000', '/media/That''s the Way of the World.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (502, 'She''s So Unusual', 'Prince', 'Cyndi Lauper', '1983-01-01', '2018-08-07 08:57:19.939000', '/media/She''s So Unusual.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (503, 'New Day Rising', 'Santana', 'Husker Du', '1985-01-01', '2018-08-07 08:57:19.939000', '/media/New Day Rising.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (496, 'Voodoo', 'AC/DC', 'D''Angelo', '2000-01-01', '2018-08-07 08:57:19.939000', '/media/Voodoo.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (497, 'Guitar Town', 'Nine Inch Nails', 'Steve Earle', '1986-01-01', '2018-08-07 08:57:19.939000', '/media/Guitar Town.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (498, 'Entertainment!', 'Simon & Garfunkel', 'Gang of Four', '1979-01-01', '2018-08-07 08:57:19.939000', '/media/Entertainment!.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (499, 'All the Young Dudes', 'Michael Jackson', 'Mott the Hoople', '1972-01-01', '2018-08-07 08:57:19.939000', '/media/All the Young Dudes.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (508, 'Yankee Hotel Foxtrot', 'Pavement', 'Wilco', '2002-01-01', '2018-08-07 08:57:19.939000', '/media/Yankee Hotel Foxtrot.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (509, 'Oracular Spectacular', 'The Rolling Stones', 'MGMT', '2007-01-01', '2018-08-07 08:57:19.939000', '/media/Oracular Spectacular.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (510, 'Give It Up', 'Ike & Tina Turner', 'Bonnie Raitt', '1972-01-01', '2018-08-07 08:57:19.939000', '/media/Give It Up.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (511, 'Boz Scaggs', 'New York Dolls', 'Boz Scaggs', '1969-01-01', '2018-08-07 08:57:19.939000', '/media/Boz Scaggs.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (504, 'Destroyer', 'Cat Stevens', 'KISS', '1976-01-01', '2018-08-07 08:57:19.939000', '/media/Destroyer.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (505, 'Tres hombres', 'Pearl Jam', 'ZZ Top', '1973-01-01', '2018-08-07 08:57:19.939000', '/media/Tres hombres.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (506, 'Born Under a Bad Sign', 'Neil Young & Crazy Horse', 'Albert King', '1967-01-01', '2018-08-07 08:57:19.939000', '/media/Born Under a Bad Sign.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (507, 'Touch', 'Pink Floyd', 'Eurythmics', '1983-01-01', '2018-08-07 08:57:19.939000', '/media/Touch.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (452, 'Tha Carter III', 'Beastie Boys', 'Lil Wayne', '2008-01-01', '2018-08-07 08:57:19.939000', '/media/Tha Carter III.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (453, 'Boys Don''t Cry', 'Joy Division', 'The Cure', '1979-01-01', '2018-08-07 08:57:19.939000', '/media/Boys Don''t Cry.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (454, 'Live at the Harlem Square Club, 1963', 'Elton John', 'Sam Cooke', '1985-01-01', '2018-08-07 08:57:19.939000', '/media/Live at the Harlem Square Club, 1963.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (455, 'Rum Sodomy & the Lash', 'KISS', 'The Pogues', '1985-01-01', '2018-08-07 08:57:19.939000', '/media/Rum Sodomy & the Lash.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (448, 'All Things Must Pass', 'The B 52''s', 'George Harrison', '1970-01-01', '2018-08-07 08:57:19.939000', '/media/All Things Must Pass.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (449, '#1 Record', 'A Tribe Called Quest', 'Big Star', '1972-01-01', '2018-08-07 08:57:19.939000', '/media/#1 Record.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (450, 'In Utero', 'Howlin'' Wolf', 'Nirvana', '1993-01-01', '2018-08-07 08:57:19.939000', '/media/In Utero.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (451, 'Sea Change', 'Pretenders', 'Beck', '2002-01-01', '2018-08-07 08:57:19.939000', '/media/Sea Change.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (460, 'Fly Like an Eagle', 'Linda Ronstadt', 'Steve Miller Band', '1976-01-01', '2018-08-07 08:57:19.939000', '/media/Fly Like an Eagle.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (461, 'Back in the USA', 'Marvin Gaye', 'MC5', '1970-01-01', '2018-08-07 08:57:19.939000', '/media/Back in the USA.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (462, 'Getz / Gilberto', 'Elvis Costello & The Attractions', 'Stan Getz / Joao Gilberto featuring Antonio Carlos Jobim', '1964-01-01', '2018-08-07 08:57:19.939000', '/media/Getz / Gilberto.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (463, 'Synchronicity', 'Metallica', 'The Police', '1983-01-01', '2018-08-07 08:57:19.939000', '/media/Synchronicity.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (456, 'Suicide', 'T. Rex', 'Suicide', '1977-01-01', '2018-08-07 08:57:19.939000', '/media/Suicide.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (457, 'Q: Are We Not Men? A: We Are Devo!', 'Otis Redding', 'DEVO', '1978-01-01', '2018-08-07 08:57:19.939000', '/media/Q: Are We Not Men? A: We Are Devo!.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (458, 'In Color', 'Radiohead', 'Cheap Trick', '1977-01-01', '2018-08-07 08:57:19.939000', '/media/In Color.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (459, 'The World Is a Ghetto', 'Prince', 'War', '1972-01-01', '2018-08-07 08:57:19.939000', '/media/The World Is a Ghetto.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (468, 'Strictly Business', 'Rod Stewart', 'EPMD', '1987-01-01', '2018-08-07 08:57:19.939000', '/media/Strictly Business.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (469, 'Love It to Death', 'Todd Rundgren', 'Alice Cooper', '1971-01-01', '2018-08-07 08:57:19.939000', '/media/Love It to Death.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (470, 'How Will the Wolf Survive?', 'Bob Dylan', 'Los Lobos', '1984-01-01', '2018-08-07 08:57:19.939000', '/media/How Will the Wolf Survive?.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (471, 'Here, My Dear', 'Carpenters', 'Marvin Gaye', '1978-01-01', '2018-08-07 08:57:19.939000', '/media/Here, My Dear.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (464, 'Third/Sister Lovers', 'Elvis Costello', 'Big Star', '1978-01-01', '2018-08-07 08:57:19.939000', '/media/Third/Sister Lovers.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (465, 'For Everyman', 'Bob Marley & The Wailers', 'Jackson Browne', '1973-01-01', '2018-08-07 08:57:19.939000', '/media/For Everyman.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (466, 'Back to Black', 'The Who', 'Amy Winehouse', '2006-01-01', '2018-08-07 08:57:19.939000', '/media/Back to Black.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (467, 'John Prine', 'The Byrds', 'John Prine', '1971-01-01', '2018-08-07 08:57:19.939000', '/media/John Prine.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (476, 'Metal Box', 'The Rolling Stones', 'Public Image Ltd.', '1979-01-01', '2018-08-07 08:57:19.939000', '/media/Metal Box.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (477, 'Document', 'Bob Marley & The Wailers', 'R.E.M.', '1987-01-01', '2018-08-07 08:57:19.939000', '/media/Document.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (478, 'Heaven Up Here', 'Fleetwood Mac', 'Echo and The Bunnymen', '1981-01-01', '2018-08-07 08:57:19.939000', '/media/Heaven Up Here.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (479, 'Hysteria', 'Willie Nelson', 'Def Leppard', '1987-01-01', '2018-08-07 08:57:19.939000', '/media/Hysteria.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (472, 'Z', 'Aerosmith', 'My Morning Jacket', '2005-01-01', '2018-08-07 08:57:19.939000', '/media/Z.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (473, 'Tumbleweed Connection', 'Funkadelic', 'Elton John', '1970-01-01', '2018-08-07 08:57:19.939000', '/media/Tumbleweed Connection.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (474, 'The Drifters'' Golden Hits', 'Curtis Mayfield and The Impressions', 'The Drifters', '1968-01-01', '2018-08-07 08:57:19.939000', '/media/The Drifters'' Golden Hits.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (475, 'Live Through This', 'ABBA', 'Hole', '1994-01-01', '2018-08-07 08:57:19.939000', '/media/Live Through This.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (292, 'Rhythm Nation 1814', 'Boz Scaggs', 'Janet Jackson', '1989-01-01', '2018-08-07 08:57:19.939000', '/media/Rhythm Nation 1814.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (293, 'Anthology of American Folk Music', 'The White Stripes', 'Various', '1997-01-01', '2018-08-07 08:57:19.939000', '/media/Anthology of American Folk Music.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (294, 'Aladdin Sane', 'The Stone Roses', 'David Bowie', '1973-01-01', '2018-08-07 08:57:19.939000', '/media/Aladdin Sane.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (295, 'All That You Can''t Leave Behind', 'B.B. King', 'U2', '2000-01-01', '2018-08-07 08:57:19.939000', '/media/All That You Can''t Leave Behind.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (288, 'Going to a Go-Go', 'Eurythmics', 'Smokey Robinson & The Miracles', '1966-01-01', '2018-08-07 08:57:19.939000', '/media/Going to a Go-Go.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (289, 'Nightbirds', 'Wilco', 'LaBelle', '1974-01-01', '2018-08-07 08:57:19.939000', '/media/Nightbirds.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (290, 'The Slim Shady LP', 'MGMT', 'Eminem', '1999-01-01', '2018-08-07 08:57:19.939000', '/media/The Slim Shady LP.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (291, 'Mothership Connection', 'Bonnie Raitt', 'Parliament', '1975-01-01', '2018-08-07 08:57:19.939000', '/media/Mothership Connection.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (300, 'Music of My Mind', 'Bob Dylan', 'Stevie Wonder', '1972-01-01', '2018-08-07 08:57:19.939000', '/media/Music of My Mind.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (301, 'I''m Still in Love With You', 'The Beatles', 'Al Green', '1972-01-01', '2018-08-07 08:57:19.939000', '/media/I''m Still in Love With You.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (302, 'Los Angeles', 'Marvin Gaye', 'X', '1980-01-01', '2018-08-07 08:57:19.939000', '/media/Los Angeles.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (303, 'Anthem of the Sun', 'The Rolling Stones', 'Grateful Dead', '1968-01-01', '2018-08-07 08:57:19.939000', '/media/Anthem of the Sun.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (296, 'My Life', 'OutKast', 'Mary J. Blige', '1994-01-01', '2018-08-07 08:57:19.939000', '/media/My Life.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (297, 'Folk Singer', 'The Beatles', 'Muddy Waters', '1964-01-01', '2018-08-07 08:57:19.939000', '/media/Folk Singer.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (298, 'Can''t Get Enough', 'The Beach Boys', 'Barry White', '1974-01-01', '2018-08-07 08:57:19.939000', '/media/Can''t Get Enough.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (299, 'The Cars', 'The Beatles', 'The Cars', '1978-01-01', '2018-08-07 08:57:19.939000', '/media/The Cars.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (308, 'White Light/White Heat', 'Miles Davis', 'The Velvet Underground', '1968-01-01', '2018-08-07 08:57:19.939000', '/media/White Light/White Heat.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (309, 'Kick Out the Jams', 'The Velvet Underground', 'MC5', '1969-01-01', '2018-08-07 08:57:19.939000', '/media/Kick Out the Jams.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (310, 'Songs of Love and Hate', 'The Beatles', 'Leonard Cohen', '1970-01-01', '2018-08-07 08:57:19.939000', '/media/Songs of Love and Hate.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (311, 'Meat Is Murder', 'The Jimi Hendrix Experience', 'The Smiths', '1985-01-01', '2018-08-07 08:57:19.939000', '/media/Meat Is Murder.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (304, 'Something Else by The Kinks', 'The Clash', 'The Kinks', '1967-01-01', '2018-08-07 08:57:19.939000', '/media/Something Else by The Kinks.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (305, 'Call Me', 'Bob Dylan', 'Al Green', '1973-01-01', '2018-08-07 08:57:19.939000', '/media/Call Me.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (306, 'Talking Heads: 77', 'The Beatles', 'Talking Heads', '1977-01-01', '2018-08-07 08:57:19.939000', '/media/Talking Heads: 77.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (307, 'The Basement Tapes', 'Elvis Presley', 'Bob Dylan and the Band', '1975-01-01', '2018-08-07 08:57:19.939000', '/media/The Basement Tapes.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (316, 'Coat of Many Colors', 'Michael Jackson', 'Dolly Parton', '1971-01-01', '2018-08-07 08:57:19.939000', '/media/Coat of Many Colors.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (317, 'Fear of a Black Planet', 'Chuck Berry', 'Public Enemy', '1990-01-01', '2018-08-07 08:57:19.939000', '/media/Fear of a Black Planet.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (318, 'John Wesley Harding', 'Robert Johnson', 'Bob Dylan', '1967-01-01', '2018-08-07 08:57:19.939000', '/media/John Wesley Harding.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (319, 'Grace', 'John Lennon / Plastic Ono Band', 'Jeff Buckley', '1994-01-01', '2018-08-07 08:57:19.939000', '/media/Grace.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (312, 'We''re Only in It for the Money', 'Bob Dylan', 'The Mothers of Invention', '1968-01-01', '2018-08-07 08:57:19.939000', '/media/We''re Only in It for the Money.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (313, 'The College Dropout', 'Nirvana', 'Kanye West', '2003-01-01', '2018-08-07 08:57:19.939000', '/media/The College Dropout.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (314, 'Weezer (Blue Album)', 'Bruce Springsteen', 'Weezer', '1994-01-01', '2018-08-07 08:57:19.939000', '/media/Weezer (Blue Album).wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (315, 'Master of Reality', 'Van Morrison', 'Black Sabbath', '1971-01-01', '2018-08-07 08:57:19.939000', '/media/Master of Reality.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (260, 'All Killer No Filler! The Jerry Lee Lewis Anthology', 'Def Leppard', 'Jerry Lee Lewis', '1993-01-01', '2018-08-07 08:57:19.939000', '/media/All Killer No Filler! The Jerry Lee Lewis Anthology.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (261, 'Freak Out!', 'The Magnetic Fields', 'The Mothers of Invention', '1966-01-01', '2018-08-07 08:57:19.939000', '/media/Freak Out!.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (262, 'Live/Dead', 'Coldplay', 'The Grateful Dead', '1969-01-01', '2018-08-07 08:57:19.939000', '/media/Live/Dead.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (270, 'Metallica ("The Black Album")', 'Manu Chao', 'Metallica', '1991-01-01', '2018-08-07 08:57:19.939000', '/media/Metallica ("The Black Album").wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (271, 'Trans Europa Express', 'Elvis Costello & The Attractions', 'Kraftwerk', '1977-01-01', '2018-08-07 08:57:19.939000', '/media/Trans Europa Express.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (267, 'The Blueprint', 'Richard & Linda Thompson', 'Jay Z', '2001-01-01', '2018-08-07 08:57:19.939000', '/media/The Blueprint.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (365, 'Roger the Engineer', 'Led Zeppelin', 'The Yardbirds', '1966-01-01', '2018-08-07 08:57:19.939000', '/media/Roger the Engineer.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (367, 'Brothers in Arms', 'Paul Simon', 'Dire Straits', '1985-01-01', '2018-08-07 08:57:19.939000', '/media/Brothers in Arms.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (361, '3 Feet High and Rising', 'Phil Spector', 'De La Soul', '1989-01-01', '2018-08-07 08:57:19.939000', '/media/3 Feet High and Rising.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (363, 'Muddy Waters at Newport 1960', 'Radiohead', 'Muddy Waters', '1960-01-01', '2018-08-07 08:57:19.939000', '/media/Muddy Waters at Newport 1960.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (373, 'Sketches of Spain', 'AC/DC', 'Miles Davis', '1960-01-01', '2018-08-07 08:57:19.939000', '/media/Sketches of Spain.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (280, 'The Genius of Ray Charles', 'Mott the Hoople', 'Ray Charles', '1959-01-01', '2018-08-07 08:57:19.939000', '/media/The Genius of Ray Charles.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (256, 'Let It Be', 'Hole', 'The Replacements', '1984-01-01', '2018-08-07 08:57:19.939000', '/media/Let It Be.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (279, 'Workingman''s Dead', 'Gang of Four', 'Grateful Dead', '1970-01-01', '2018-08-07 08:57:19.939000', '/media/Workingman''s Dead.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (274, 'The Velvet Rope', 'Loretta Lynn', 'Janet', '1997-01-01', '2018-08-07 08:57:19.939000', '/media/The Velvet Rope.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (16, 'Sgt. Pepper''s Lonely Hearts Club Band', 'The Meters', 'The Beatles', '1967-01-01', '2018-08-07 08:56:44.343000', '/media/Sgt. Pepper''s Lonely Hearts Club Band.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (259, 'The Marshall Mathers LP', 'Echo and The Bunnymen', 'Eminem', '2000-01-01', '2018-08-07 08:57:19.939000', '/media/The Marshall Mathers LP.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (264, 'Automatic for the People', 'The Paul Butterfield Blues Band', 'R.E.M.', '1992-01-01', '2018-08-07 08:57:19.939000', '/media/Automatic for the People.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (276, 'American Beauty', 'Raekwon', 'Grateful Dead', '1970-01-01', '2018-08-07 08:57:19.939000', '/media/American Beauty.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (277, 'Crosby, Stills & Nash', 'D''Angelo', 'Crosby, Stills & Nash', '1969-01-01', '2018-08-07 08:57:19.939000', '/media/Crosby, Stills & Nash.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (278, 'Tracy Chapman', 'Steve Earle', 'Tracy Chapman', '1988-01-01', '2018-08-07 08:57:19.939000', '/media/Tracy Chapman.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (285, 'Some Girls', 'KISS', 'The Rolling Stones', '1978-01-01', '2018-08-07 08:57:19.939000', '/media/Some Girls.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (283, 'Paul Simon', 'Cyndi Lauper', 'Paul Simon', '1972-01-01', '2018-08-07 08:57:19.939000', '/media/Paul Simon.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (374, 'Honky Château', 'Otis Redding', 'Elton John', '1972-01-01', '2018-08-07 08:57:19.939000', '/media/Honky Château.wav');
INSERT INTO public.songs (id, name, composer, singer, released_at, created_at, link) VALUES (379, 'L.A. Woman', 'The Jimi Hendrix Experience', 'The Doors', '1971-01-01', '2018-08-07 08:57:19.939000', '/media/L.A. Woman.wav');

-- users
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (16, 'Warner Anderson', '016258759823
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (17, 'Griselda Margrett', '09605845765
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (18, 'Alva Billie', '016645623385
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (19, 'Darrin Gidget', '08654929796
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (20, 'Cyndy Jerrod', '016736367596
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (21, 'Jona Eugene', '016520082328
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (22, 'Teisha Lynna', '016738488066
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (23, 'Cassie Jessie', '016575947242
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (24, 'Lela Timika', '09726725603
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (25, 'Madge Sherwood', '016731199725
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (26, 'Lanelle Hildegarde', '016331798786
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (27, 'Dale Tess', '09761296162
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (28, 'Vincenzo Devora', '016966220858
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (29, 'Lamonica Shaun', '016600429938
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (30, 'Willodean Takako', '016689509787
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (31, 'Teodora Bobette', '09655876087
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (32, 'Natalya Zack', '09741965902
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (33, 'Shantae Gil', '08685109855
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (34, 'Cecilia Emeline', '016575121767
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (35, 'Marcos Christal', '016698979893
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (36, 'Harriette Kiley', '09773864950
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (37, 'Merle Mauro', '016436108575
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (38, 'Danilo Cara', '016738089745
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (39, 'Ray Rana', '016819514151
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (40, 'Vonnie Everette', '016728380084
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (41, 'Shalonda Broderick', '016614439806
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (42, 'Fabian Brooks', '016362205001
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (43, 'Anastacia Carmella', '09779518010
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (44, 'Juliane Dessie', '09806292169
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (45, 'Carly Oretha', '016824038913
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (46, 'Linh Willia', '08613401565
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (47, 'Reina Hulda', '08699789536
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (48, 'Chante Curtis', '012566607942
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (49, 'Ramon Moses', '016620956955
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (50, 'Georgetta Lida', '012507336363
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (51, 'Estelle Margherita', '016719290683
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (52, 'Nannette Russell', '09666005116
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (53, 'Tom Carmon', '016850882814
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (54, 'Merlene Shiloh', '016869369890
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (55, 'Marsha Margit', '09817426620
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (56, 'Susannah Tommie', '016892200731
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (57, 'Rosann Ashley', '09875092356
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (58, 'Audra Martha', '09885533473
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (59, 'Jonna Chasidy', '016294920120
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (60, 'Russ Lucilla', '016905799562
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (61, 'Lanell France', '09666899480
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (62, 'Jada Travis', '016256256184
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (63, 'Roma Jenice', '016490861507
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (64, 'Martin Corina', '016940172695
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (65, 'Terrilyn Chung', '016448437968
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (66, 'Jolene Avril', '016446421116
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (67, 'Lindsay Lidia', '016747210774
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (68, 'Hiedi Hermine', '09729539586
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (69, 'Samual Kirsten', '016825541562
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (70, 'Steffanie Sharell', '08692009355
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (71, 'Michale Marcell', '016623944783
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (72, 'Arvilla Maryam', '016209853940
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (73, 'Anibal Madalyn', '09740890355
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (74, 'Rosalyn Marlana', '016241749710
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (75, 'Raye Carl', '09799903306
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (76, 'Perry Camelia', '09708669620
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (77, 'Ema Kenia', '016684944339
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (78, 'Latanya Eleni', '016645867948
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (79, 'Bea Travis', '016784982325
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (80, 'Katherin Selina', '016982379119
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (81, 'Johnie Eloise', '012529643247
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (82, 'Ashli Denyse', '09654195685
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (83, 'Hermelinda Johnetta', '012596538219
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (84, 'Rodrick Yael', '09682239923
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (85, 'Candice Palmira', '016647479513
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (86, 'Valene Callie', '016903008822
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (87, 'Lindy Kermit', '016477148479
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (88, 'Marta Rubin', '016546393902
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (89, 'Frank Rhona', '016480599501
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (90, 'Delpha Allegra', '016601354232
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (91, 'Ruby Mikaela', '016550179677
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (92, 'Shella Quinn', '08600328103
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (93, 'Frankie Peggie', '09623128907
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (94, 'Magnolia Brett', '012543032838
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (95, 'Lourie Elbert', '016278699976
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (96, 'Paula Adolph', '012525315023
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (97, 'Jim Phoebe', '016747838923
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (98, 'Sharan Angila', '016220157071
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (99, 'Julee Magan', '016568454284
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (100, 'Miki Desmond', '09764256336
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (101, 'Erminia Raphael', '016692205533
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (102, 'Carmelia Osvaldo', '012575207737
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (103, 'Edie Kara', '016591826639
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (104, 'Alina Audry', '09878751487
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (105, 'John Marla', '08621721344
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (106, 'Karisa Carrie', '09891993401
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (107, 'Etsuko Loris', '016953909286
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (108, 'Pinkie Edris', '09792242734
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (109, 'Trevor Alexa', '016693667463
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (110, 'Luci Laci', '016663564256
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (111, 'Rodrick Lula', '016303736781
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (112, 'Dorcas Elda', '016248358806
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (113, 'Denae Drusilla', '09670030402
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (114, 'Carrol Arnita', '016262427321
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (115, 'Myrtie Marquitta', '09783537267
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (116, 'Daysi Cortney', '016644600657
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (117, 'Kaylene Annetta', '09752528979
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (118, 'Jasper Jerrold', '016843353804
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (119, 'Domingo Buford', '09706409993
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (120, 'Estrella Dayle', '09642396113
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (121, 'Dannie Alene', '09890551135
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (122, 'Celia Steven', '016685702917
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (123, 'Jewel Alexander', '016826976093
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (124, 'Everett Jeniffer', '012570929776
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (125, 'Bell Denisse', '016394350014
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (126, 'Jamaal Colin', '012557111479
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (127, 'Clementine Josiah', '016920351148
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (128, 'Charlette Angelyn', '09858516820
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (129, 'Lourdes Vaughn', '016625216777
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (130, 'Lorri Latisha', '09711882205
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (131, 'Petra Gerry', '016802666392
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (132, 'Edythe Glinda', '08610641554
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (133, 'Mario Annalee', '08660190744
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (134, 'Clarence Leesa', '016778758675
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (135, 'Maricela Bertha', '09812006853
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (136, 'Regan Takisha', '08630065479
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (137, 'Logan Lynn', '012505032789
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (138, 'Patria Xuan', '016663312175
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (139, 'Shaquita Janeth', '016558154518
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (140, 'Meagan Vena', '012584572899
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (141, 'Latonya Floria', '016563433725
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (142, 'Harriet Annamaria', '016312395062
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (143, 'Lavina Lauran', '012511420217
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (144, 'Johna Jammie', '08630085233
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (145, 'Ping Imogene', '016577706899
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (146, 'Rachel Shandra', '09706912376
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (147, 'Glayds Anisa', '09857330245
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (148, 'Ezra Willa', '08646989540
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (149, 'Raina Ai', '09656798057
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (150, 'Sheba Mia', '012596745523
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (151, 'Jama Mafalda', '016828036744
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (152, 'Carmel Rocio', '016628088756
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (153, 'Classie Macy', '016278593060
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (154, 'Brandee Silvana', '08677792773
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (155, 'Sanjuanita Mallory', '09821327665
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (156, 'Cesar Terrell', '08672636556
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (157, 'Herschel Eddie', '08628277828
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (158, 'Antionette Abe', '016954426033
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (159, 'Emelina Christoper', '016824570841
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (160, 'Amanda Guillermo', '016591099438
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (161, 'Irene Floy', '09738301981
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (162, 'Ethan Werner', '016335506044
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (163, 'Jacquelyn Stefanie', '016299153356
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (164, 'Gene Stanford', '016216141800
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (165, 'Eleanor Shameka', '016644530622
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (166, 'Allyn Kaylene', '016936161681
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (167, 'Dino Meda', '08628417583
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (168, 'Marva Alvaro', '016747850010
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (169, 'Quiana Charlott', '016227328079
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (170, 'Blair Marjorie', '08678491458
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (171, 'Brandon Arron', '016495623802
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (172, 'Dodie Carmelina', '012511723585
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (173, 'Charolette Heidi', '016418349549
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (174, 'Trudie Gaylene', '016350985616
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (175, 'Dinah Lino', '016831128979
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (176, 'Chieko Darcel', '09657985992
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (177, 'Thomasina Henry', '08659058650
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (178, 'Paris Cherri', '016473082427
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (179, 'Alexandria Irina', '016860495277
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (180, 'Loan Kizzie', '09823710788
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (181, 'Clayton Zana', '016394591161
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (182, 'Merrilee Terrell', '09808048592
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (183, 'Rosalba Ty', '09730882959
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (184, 'Misha Ashely', '09629497298
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (185, 'Bridgett Valery', '012565451094
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (186, 'Christena Effie', '016320035397
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (187, 'Young Kyung', '016452242372
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (188, 'Porter Meta', '016686422345
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (189, 'Roxane Lorene', '016534600680
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (190, 'Teisha Bonnie', '016597506588
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (191, 'Candis Ligia', '016725210078
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (192, 'Clarinda Geraldo', '09844927641
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (193, 'Jean Ulysses', '012535344613
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (194, 'Samatha Keisha', '016497420715
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (195, 'Melina Tamra', '09643197400
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (196, 'Sheila Genevieve', '016794980334
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (197, 'Cathy Tomi', '09780816391
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (198, 'Keven Burl', '016311823950
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (199, 'Julianne Tomoko', '016914821763
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (200, 'Madeleine Chu', '09678425021
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (201, 'Tanisha Nicholas', '016702698377
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (202, 'Corrinne Stephnie', '09705017054
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (203, 'Jamison Tammera', '016311549509
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (204, 'Halina Leeann', '016249509200
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (205, 'Caitlin Dianna', '012503075135
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (206, 'Lara Tressa', '09630330010
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (207, 'Claudine Edda', '09610817395
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (208, 'Delphia Cody', '016381304159
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (209, 'Athena Annelle', '016735623018
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (210, 'Khadijah Aubrey', '016953759113
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (211, 'Taunya Christinia', '016537581589
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (212, 'Su Kendrick', '012515642377
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (213, 'Tabitha Mi', '016675048164
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (214, 'Jeffrey Ron', '09780412264
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (215, 'Winona Arron', '016679987973
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (216, 'Maryetta Ka', '016647318086
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (217, 'Ji Alexandria', '09746388169
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (218, 'Maurice Christel', '016228121830
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (219, 'Marquetta Alphonso', '016654182549
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (220, 'Halley Garrett', '016496018485
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (221, 'Alma Daniella', '016477715763
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (222, 'Willette Aaron', '016661807292
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (223, 'Nana Dante', '016932671835
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (224, 'Virgil Jana', '012513449032
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (225, 'Bruna Kandis', '016332174638
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (226, 'Ryan Kayleen', '012518111796
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (227, 'Oleta Breanna', '016914931571
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (228, 'Zenobia Latanya', '012551002453
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (229, 'Haywood Sydney', '016478925444
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (230, 'Michelle Judie', '09882998937
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (231, 'Carri Ching', '016418744719
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (232, 'Gerri Mike', '016701003226
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (348, 'Jack Louis', '016986032262
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (233, 'Cyrstal Hallie', '016547723018
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (234, 'Marylynn Alline', '09614735065
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (235, 'Arlena Audrey', '016543278244
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (236, 'Keenan Launa', '09844290707
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (237, 'Duncan Kum', '08620517894
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (238, 'Gwenn Adella', '012527298120
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (239, 'Wilburn Betsey', '08606592161
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (240, 'Rickie Odette', '012587385625
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (241, 'Aracelis Ike', '09682437586
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (242, 'Cody Alida', '016392844826
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (243, 'Katie Florrie', '09778403878
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (244, 'Joan Demetria', '016245919835
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (245, 'Reid Erline', '016251782512
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (246, 'Kattie Gerard', '016227115697
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (247, 'Bertie Tomoko', '016968398485
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (248, 'Francene Erminia', '09897988389
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (249, 'Palma Jimmie', '09718651100
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (250, 'Jaime Stefani', '016658803353
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (251, 'Kasandra Violet', '016376958907
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (252, 'Courtney Jerri', '016742128163
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (253, 'Robin Eva', '016929619411
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (254, 'Lauran Jerrie', '016820407032
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (255, 'Antonetta Linsey', '016419030539
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (256, 'Anton Amelia', '09892315294
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (257, 'Kasandra Selene', '016760682194
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (258, 'Maryjane Ranee', '016715272603
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (259, 'Mack Glenna', '09810460955
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (260, 'Tiara Mora', '016423476270
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (261, 'Hee Otto', '016202508359
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (262, 'Lizbeth Vinita', '016813031768
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (263, 'Kennith Britt', '016569413225
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (264, 'Dominic Mikel', '016233111856
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (265, 'Carita Madalyn', '016772571441
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (266, 'Marybeth Agueda', '09668452062
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (267, 'Millicent Numbers', '016872617148
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (268, 'Haley Annabelle', '016981276421
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (269, 'Carman Mariko', '016761488954
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (270, 'Andra Virgil', '016505415643
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (271, 'Hisako Lilliam', '016890982144
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (272, 'Mathilde Augustus', '016473660989
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (273, 'Christine Jeanne', '016400031436
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (274, 'Colette Malik', '016727302768
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (275, 'Christian Eugene', '016756441236
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (276, 'Fernande Justine', '09826645221
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (277, 'Tomi Hae', '016360945008
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (278, 'Joseph Coleen', '016308128620
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (279, 'Judith Letty', '012519667556
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (280, 'Ebony Leigh', '09630782727
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (281, 'Gertrud Rosena', '016638614957
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (282, 'Conception Nana', '016591641414
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (283, 'Loura Janelle', '016534032347
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (284, 'Hien Chung', '016901926807
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (285, 'Davis Yong', '016810166960
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (286, 'Jonie Clemmie', '016359550073
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (287, 'Zachary Brittney', '012563870259
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (288, 'Donn Milan', '016273771218
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (289, 'Enola Denis', '016789028755
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (290, 'Carlyn Lashon', '09837889362
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (291, 'Garnet Kenton', '016229420268
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (292, 'Wonda Sylvia', '016872185071
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (293, 'Adrian Stasia', '016426545686
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (294, 'Janelle Toshiko', '016830696150
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (295, 'Soraya Paulene', '016845659910
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (296, 'Juan Walker', '016232748996
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (297, 'Carmen Sharen', '09681479206
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (298, 'Selene Hassan', '016341687824
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (299, 'Perla Ursula', '016910523395
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (300, 'Tracey Angelyn', '016958276278
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (301, 'Grayce Mireya', '09727671409
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (302, 'Kenneth Dominique', '016259051019
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (303, 'Renato Catalina', '016214076434
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (304, 'Sandy Miss', '09702598252
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (305, 'Chandra Shanon', '016862261358
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (306, 'Faviola Kecia', '09611580333
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (307, 'Marguerite Tawnya', '016413182274
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (308, 'Malcolm Almeda', '09613212353
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (309, 'Dorine Selma', '09650335442
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (310, 'Roxy Sanford', '08604802004
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (311, 'Tawnya Lavern', '09812546345
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (312, 'Melissia Norman', '016677509774
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (313, 'Alita Jacklyn', '09654768255
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (314, 'Ronnie Winston', '08634573035
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (315, 'Tamisha Jody', '016236719562
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (316, 'Vernie Albertina', '016352791217
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (317, 'Jerald Kia', '09891622812
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (318, 'Ardelia Tom', '016295687533
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (319, 'Brenton Claretta', '09874061104
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (320, 'Elinor Pinkie', '09789241637
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (321, 'Sammy Gertrudis', '08675320444
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (322, 'Rosanne Crysta', '016284127696
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (323, 'Joane Sandra', '012553426329
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (324, 'Vanesa Alberta', '09600407957
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (325, 'Jena Kirby', '08693480629
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (326, 'Reginia Tamisha', '016885851605
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (327, 'Ramonita Aurelio', '08618647561
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (328, 'Latoria Claudette', '016939171780
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (329, 'Chun Marlyn', '09884127776
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (330, 'Fredericka Jeneva', '016455708020
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (331, 'Dawna Tandy', '012511925243
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (332, 'Pamila Izola', '08631124444
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (333, 'Nguyet Jeannette', '016995699568
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (334, 'Blake Keely', '08619377027
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (335, 'Cari Cameron', '09720699700
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (336, 'Rory Susan', '016228903073
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (337, 'Kristopher Coy', '09747579955
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (338, 'Sherita Lincoln', '08610423150
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (339, 'Alecia Delmy', '08618166426
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (340, 'Mattie Vella', '016554221228
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (341, 'Korey Narcisa', '012589963870
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (342, 'Imelda Marty', '016261147708
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (343, 'Krysta Beverlee', '012528984935
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (344, 'Winford Ruthann', '09716196237
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (345, 'Allyn Hisako', '016637417203
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (346, 'Jacinda Tim', '09729219990
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (347, 'Sade Lasonya', '016864123197
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (349, 'Kyung Andrew', '09615145439
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (350, 'Maryam Jonelle', '016413744961
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (351, 'Chia Kyong', '012508306522
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (352, 'Howard Maragret', '09723168858
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (353, 'Nichol Glory', '016720245691
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (354, 'Tiara Lavone', '016418806899
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (355, 'Sherita Cody', '016288065846
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (356, 'Vida Otha', '016242843445
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (357, 'Shin Cassidy', '016683673745
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (358, 'Harriette Augusta', '09611990395
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (359, 'Shante Maritza', '016390079751
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (360, 'Antony Tu', '016633634673
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (361, 'Beatriz Maude', '09823236298
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (362, 'Sasha Chieko', '016887363983
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (363, 'Naida Elke', '08604096027
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (364, 'Lanny Rivka', '08693859089
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (365, 'Wanetta Clifford', '016671525849
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (366, 'Vivan Aurea', '016271936909
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (367, 'Sumiko Jeanelle', '016629916638
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (368, 'Laurine Neville', '016271080021
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (369, 'Marceline Mario', '08689944944
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (370, 'Tamica Marcela', '016600761121
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (371, 'Makeda Daphne', '09662467108
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (372, 'Lorean Alex', '09687723034
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (373, 'Scot Shelba', '016410987656
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (374, 'Antonietta Damaris', '016911493384
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (375, 'Pennie Shoshana', '016595615770
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (376, 'Sylvie Gudrun', '016807741755
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (377, 'Jacinta Mozelle', '09618809121
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (378, 'Stacy Evia', '016290342545
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (379, 'Salvatore Anneliese', '016930918186
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (380, 'Jordan Heidy', '09643832724
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (381, 'Roxanna Harley', '016511266086
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (382, 'Jesus Mireille', '09844361800
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (383, 'Eura Micki', '016763679517
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (384, 'Celesta Latasha', '08618765230
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (385, 'Abbey Tamara', '08671867270
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (386, 'Tiffani Rochell', '016973037279
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (387, 'Laine Maximo', '012566599640
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (388, 'Sherlene Frida', '016678320711
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (389, 'Trula Allegra', '016963332100
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (390, 'Dacia Majorie', '09686556735
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (391, 'Sherrell Stacia', '016582408420
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (392, 'Linwood Dee', '08654826055
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (393, 'Ninfa Chantay', '016508594290
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (394, 'Yung Hong', '09702893241
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (395, 'Alvin Jene', '016807089262
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (396, 'Nicki Desire', '016337845660
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (397, 'Rudolf Graciela', '016221933309
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (398, 'Sharri Scot', '012593766898
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (399, 'Denae Abbey', '09852138947
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (400, 'Page Shanita', '016644062091
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (401, 'Lea Glady', '016438600989
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (402, 'Olimpia Fredric', '016668744541
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (403, 'Tangela Freeda', '09776058363
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (404, 'Eartha Susannah', '09744485734
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (405, 'Colby Tabetha', '016200422708
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (406, 'Audie Moses', '016317987690
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (407, 'Jacalyn Collene', '09803801852
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (408, 'Jeanette Michell', '016929314870
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (409, 'Leah Maile', '016781926309
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (410, 'Bulah Trevor', '016204824927
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (411, 'Floy Cameron', '016662138284
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (412, 'Harriet Ouida', '016289780750
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (413, 'Kimber Enda', '016549135435
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (414, 'Earlene Lourdes', '016942765811
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (415, 'Carly Pattie', '012569071509
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (416, 'Gudrun Aretha', '016277099808
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (417, 'Cheryll Mica', '09748965424
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (418, 'Delois Kisha', '09739474937
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (419, 'Suzette George', '016824282624
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (420, 'Berniece Archie', '09617927598
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (421, 'Buster Lady', '016517336981
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (422, 'Milagros Karyl', '012535659995
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (423, 'Karren Penelope', '012559338608
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (424, 'Adelaide Bridgette', '016805625043
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (425, 'Bobbi Daysi', '012519964399
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (426, 'Gwenn Jerrie', '09633027228
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (427, 'Denny Jed', '016622264699
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (428, 'Cleta Genevieve', '09769226728
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (429, 'Cicely Tyesha', '016292856642
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (430, 'Loan Deedra', '016378747372
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (431, 'Gertrude Amos', '016225852641
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (432, 'Janeth Ella', '08646802818
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (433, 'Bettye Terrie', '016309451932
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (434, 'Zola Lawanda', '016869494833
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (435, 'Ivey Kimi', '016360766971
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (436, 'Elbert Sandy', '09743114214
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (437, 'Yi Robyn', '016433990971
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (438, 'Elly Micki', '016556863180
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (439, 'Bethann Hermine', '016835707039
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (440, 'Rosalva Shasta', '09617202562
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (441, 'Dewitt Signe', '012503586656
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (442, 'Vikki Maryetta', '016278256662
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (443, 'Brandie Patrick', '09626790602
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (444, 'Jeramy Rosamond', '09739853205
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (445, 'Lyle Olympia', '016870936716
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (446, 'Dorla Geri', '016278977117
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (447, 'Corrine Yong', '09714303617
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (448, 'Steve Jacquiline', '016305557988
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (449, 'Kristel Candra', '09664387969
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (450, 'Paulette Augustina', '016905636944
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (451, 'Carmelo Carlena', '012517892078
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (452, 'Willie Carin', '016584314429
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (453, 'Tangela Jermaine', '016878961204
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (454, 'Annmarie Hang', '016371730169
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (455, 'Jacquelynn Maude', '012517617164
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (456, 'Gretta Danna', '012596591816
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (457, 'Mose Paulina', '016501538841
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (458, 'Hilde Dakota', '09842913931
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (459, 'Rebecka Michale', '09654257787
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (460, 'Alysa Oda', '016275670784
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (461, 'Debbi Napoleon', '09894935617
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (462, 'Reiko Myrna', '016939850793
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (463, 'Blake Ula', '012532059180
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (464, 'Florance Lee', '016737972647
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (465, 'Miss Marjorie', '016825316069
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (466, 'Rickie Tammara', '016659498341
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (467, 'Kim Althea', '016211687104
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (468, 'Louanne Alexander', '09856182168
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (469, 'Refugia Alex', '09643096973
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (470, 'Drusilla Terrence', '016281552592
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (471, 'Ira Angila', '016291066201
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (472, 'Celestina Carmine', '09634242439
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (473, 'Derek Lorene', '08632728178
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (474, 'Irma Marlys', '012520011978
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (475, 'Belia Jasmin', '016559376840
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (476, 'Jayne Angelica', '08673195589
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (477, 'Linette Larae', '08616111499
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (478, 'Eloise Teodora', '09730844907
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (479, 'Virgina Aleshia', '016498639464
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (480, 'Laticia Elaine', '016850683508
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (481, 'Normand Peg', '09716875328
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (482, 'Ellsworth Alleen', '016994005170
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (483, 'Millicent Jesse', '09696123413
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (484, 'Lenna Casie', '016736636501
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (485, 'Nathanael Mauro', '012518003452
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (486, 'Krissy Martina', '016910860811
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (487, 'Birgit Wanda', '08669323632
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (488, 'Marhta Jazmine', '08688341301
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (489, 'Magan Jimmie', '012540165076
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (490, 'Hyman China', '016371499497
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (491, 'Jinny Ines', '012534233963
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (492, 'Lindsy Sharika', '016601851977
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (493, 'Danilo Luis', '012595105222
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (494, 'Drucilla Marion', '016896563453
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (495, 'Lavone Vickie', '016998896661
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (496, 'Olin Leticia', '09603471067
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (497, 'Patrina Audrie', '016596054403
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (498, 'Bernadine Sherrill', '016580758924
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (499, 'Suzanne Alyse', '012551745133
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (500, 'Tai Haywood', '09857570269
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (501, 'Micheal Quinn', '09824124401
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (502, 'Porter Chastity', '012508908942
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (503, 'Nubia Evelyn', '016378694621
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (504, 'Guillermo Lupe', '08688858198
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (505, 'Emerald Evon', '016313700079
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (506, 'Latina Christine', '016978482937
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (507, 'Delcie Apryl', '016972934078
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (508, 'Joaquin Krystin', '016933400489
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (509, 'Margherita Mayra', '08644889998
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (510, 'Thaddeus Ariel', '016625346268
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (511, 'Courtney Sommer', '016230258047
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (512, 'Keri Jim', '016447856946
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (513, 'Benjamin Margurite', '08697447305
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (514, 'Lan Anthony', '016421043638
', null, '2018-08-07 14:51:37.644580');
INSERT INTO public.users (id, name, phone, address, created_at) VALUES (515, 'Alline Verla', '016894121676', null, '2018-08-07 14:51:37.644580');

-- requests
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (424, 362, '31', true, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (220, 134, '31', true, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (505, 254, '31', true, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (243, 353, '31', true, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (343, 105, '443', true, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (239, 152, '177', true, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (550, 433, '110', true, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (416, 507, '511', true, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (122, 96, '119', true, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (440, 339, '508', true, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (217, 333, '443', true, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (334, 212, '439', true, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (419, 457, '439', true, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (410, 345, '410', true, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (274, 210, '390', true, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (192, 211, '281', true, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (507, 230, '33', true, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (226, 359, '267', true, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (402, 102, '263', true, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (509, 61, '389', true, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (268, 188, '389', true, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (235, 109, '60', true, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (324, 306, '60', true, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (535, 338, '123', true, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (493, 376, '214', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (459, 438, '509', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (223, 474, '402', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (222, 65, '115', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (449, 91, '203', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (295, 110, '188', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (480, 298, '422', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (465, 73, '250', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (255, 34, '375', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (225, 114, '168', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (443, 331, '300', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (267, 446, '301', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (512, 89, '157', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (562, 44, '189', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (341, 373, '460', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (492, 461, '487', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (233, 401, '278', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (282, 414, '228', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (340, 19, '428', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (466, 218, '524', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (293, 429, '291', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (510, 399, '328', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (303, 237, '318', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (231, 479, '201', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (451, 155, '141', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (390, 277, '84', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (412, 476, '58', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (287, 357, '29', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (332, 187, '352', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (468, 342, '349', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (548, 346, '34', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (498, 442, '171', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (371, 130, '303', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (425, 120, '467', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (237, 107, '349', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (308, 130, '356', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (470, 92, '125', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (489, 379, '133', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (153, 367, '504', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (357, 341, '25', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (212, 243, '61', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (105, 70, '101', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (281, 227, '421', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (111, 76, '426', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (564, 240, '133', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (195, 204, '485', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (404, 364, '506', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (173, 355, '440', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (79, 296, '245', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (246, 82, '367', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (540, 128, '420', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (354, 362, '141', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (353, 407, '187', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (442, 478, '402', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (119, 499, '477', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (283, 470, '76', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (435, 490, '17', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (97, 162, '367', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (221, 330, '391', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (474, 337, '258', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (361, 414, '140', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (312, 401, '464', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (399, 107, '462', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (426, 266, '90', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (96, 213, '179', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (387, 244, '360', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (309, 423, '381', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (230, 382, '467', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (547, 244, '474', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (552, 337, '298', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (495, 515, '38', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (346, 99, '500', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (351, 121, '89', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (266, 59, '357', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (290, 305, '231', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (280, 261, '72', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (289, 31, '200', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (224, 241, '153', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (333, 218, '29', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (228, 75, '145', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (359, 103, '101', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (151, 348, '176', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (392, 159, '210', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (385, 207, '36', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (542, 435, '513', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (478, 387, '441', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (394, 65, '129', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (490, 462, '253', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (164, 468, '339', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (256, 223, '194', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (211, 286, '474', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (317, 47, '157', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (476, 397, '305', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (347, 361, '404', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (200, 132, '371', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (463, 268, '454', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (409, 367, '441', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (400, 138, '135', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (299, 430, '514', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (313, 56, '83', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (120, 389, '337', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (159, 241, '329', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (525, 456, '40', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (174, 420, '18', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (297, 472, '135', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (260, 269, '91', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (349, 446, '176', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (458, 489, '277', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (182, 321, '514', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (129, 411, '142', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (250, 112, '158', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (529, 499, '525', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (338, 39, '151', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (316, 21, '189', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (204, 130, '364', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (101, 444, '141', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (514, 229, '251', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (355, 506, '306', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (154, 73, '455', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (244, 449, '144', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (85, 122, '524', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (191, 221, '66', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (358, 255, '143', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (126, 393, '287', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (271, 461, '139', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (556, 159, '501', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (245, 156, '282', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (166, 304, '62', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (483, 26, '215', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (454, 432, '285', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (382, 167, '229', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (485, 171, '122', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (114, 241, '371', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (135, 402, '463', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (106, 278, '475', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (144, 366, '484', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (567, 108, '164', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (178, 301, '145', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (285, 185, '418', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (177, 248, '172', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (248, 279, '71', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (273, 361, '179', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (518, 303, '94', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (276, 243, '49', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (411, 210, '68', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (215, 324, '240', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (350, 218, '131', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (113, 225, '425', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (202, 225, '77', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (131, 316, '430', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (148, 498, '292', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (441, 140, '280', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (116, 42, '116', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (322, 465, '248', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (320, 66, '231', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (456, 280, '417', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (496, 503, '182', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (108, 336, '372', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (185, 495, '520', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (127, 283, '46', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (537, 35, '89', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (205, 237, '149', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (472, 109, '319', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (521, 297, '67', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (130, 485, '274', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (386, 135, '244', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (506, 153, '342', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (110, 506, '139', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (352, 90, '459', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (74, 294, '78', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (374, 312, '151', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (414, 267, '521', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (208, 264, '287', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (171, 258, '51', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (461, 349, '359', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (147, 337, '356', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (417, 119, '429', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (219, 176, '414', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (561, 399, '401', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (523, 290, '56', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (292, 96, '271', true, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (389, 259, '439', true, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (161, 459, '410', true, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (504, 72, '424', true, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (176, 18, '294', true, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (236, 451, '170', true, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (232, 156, '177', true, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (526, 328, '110', true, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (253, 368, '473', true, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (398, 286, '317', true, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (436, 415, '206', true, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (140, 368, '206', true, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (501, 56, '59', true, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (227, 277, '281', true, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (558, 136, '33', true, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (92, 336, '267', true, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (330, 330, '511', true, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (258, 98, '436', true, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (189, 159, '389', true, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (141, 370, '28', true, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (494, 290, '28', true, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (541, 357, '119', true, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (437, 121, '119', true, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (413, 74, '123', true, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (109, 302, '123', true, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (430, 195, '337', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (432, 165, '411', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (367, 143, '166', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (199, 405, '407', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (557, 284, '62', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (395, 250, '299', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (70, 469, '408', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (254, 177, '34', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (559, 214, '127', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (545, 64, '129', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (94, 449, '496', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (388, 177, '223', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (207, 41, '254', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (477, 310, '191', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (369, 425, '108', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (450, 247, '273', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (314, 169, '39', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (249, 246, '403', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (377, 308, '346', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (428, 299, '163', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (543, 396, '373', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (565, 145, '27', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (434, 246, '382', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (306, 497, '54', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (522, 115, '96', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (247, 25, '343', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (77, 311, '342', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (76, 257, '75', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (115, 380, '442', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (515, 412, '38', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (272, 368, '268', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (149, 300, '323', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (284, 271, '472', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (136, 454, '526', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (401, 294, '64', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (124, 481, '358', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (403, 52, '211', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (193, 92, '45', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (263, 88, '433', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (356, 358, '153', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (301, 390, '79', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (384, 202, '229', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (427, 177, '483', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (438, 299, '318', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (549, 397, '78', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (138, 495, '23', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (257, 259, '300', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (93, 172, '525', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (264, 283, '503', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (288, 138, '453', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (517, 230, '529', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (362, 20, '32', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (279, 16, '427', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (170, 80, '87', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (422, 372, '493', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (180, 494, '373', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (269, 134, '68', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (423, 131, '397', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (325, 254, '395', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (186, 227, '245', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (142, 201, '301', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (323, 331, '279', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (455, 79, '116', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (415, 377, '81', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (447, 210, '272', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (488, 485, '268', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (262, 212, '332', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (291, 218, '364', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (203, 163, '37', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (84, 463, '309', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (365, 144, '485', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (259, 445, '83', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (75, 171, '477', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (337, 26, '26', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (375, 230, '173', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (376, 429, '530', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (81, 491, '506', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (457, 274, '270', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (143, 355, '398', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (168, 425, '154', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (481, 292, '96', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (372, 327, '25', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (275, 90, '198', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (452, 195, '418', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (433, 93, '375', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (513, 269, '264', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (238, 382, '362', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (183, 86, '130', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (475, 52, '159', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (471, 475, '107', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (214, 194, '494', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (446, 472, '262', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (546, 391, '111', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (107, 208, '46', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (407, 482, '452', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (378, 294, '74', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (482, 47, '22', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (321, 169, '79', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (460, 236, '351', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (484, 206, '518', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (216, 114, '420', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (71, 245, '181', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (344, 60, '55', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (327, 282, '98', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (511, 490, '140', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (530, 123, '442', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (278, 440, '77', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (383, 267, '311', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (467, 183, '191', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (87, 168, '274', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (187, 281, '523', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (336, 73, '80', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (563, 205, '161', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (69, 505, '440', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (499, 195, '366', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (82, 58, '175', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (508, 354, '128', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (315, 241, '192', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (429, 216, '95', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (234, 360, '498', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (527, 482, '292', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (368, 456, '239', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (100, 283, '214', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (270, 115, '480', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (252, 205, '468', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (445, 101, '236', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (469, 122, '508', true, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (555, 55, '508', true, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (137, 237, '271', true, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (242, 260, '443', true, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (80, 368, '439', true, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (396, 368, '466', true, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (348, 507, '466', true, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (473, 118, '424', true, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (210, 488, '424', true, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (196, 337, '193', true, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (328, 491, '294', true, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (305, 201, '294', true, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (128, 385, '170', true, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (201, 287, '177', true, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (197, 44, '473', true, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (439, 284, '473', true, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (487, 148, '317', true, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (184, 17, '317', true, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (553, 257, '206', true, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (229, 371, '59', true, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (150, 487, '59', true, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (165, 502, '281', true, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (418, 203, '267', true, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (339, 501, '511', true, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (213, 501, '263', true, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (479, 360, '28', true, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (103, 349, '60', true, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (121, 152, '428', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (538, 176, '215', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (364, 447, '339', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (531, 511, '298', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (421, 340, '168', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (331, 143, '527', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (406, 514, '510', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (373, 297, '269', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (240, 18, '493', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (379, 123, '113', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (188, 446, '529', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (134, 65, '519', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (209, 183, '37', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (381, 327, '90', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (420, 292, '147', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (86, 197, '26', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (311, 330, '478', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (533, 380, '478', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (544, 322, '210', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (296, 237, '429', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (366, 40, '112', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (261, 18, '194', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (500, 308, '329', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (146, 245, '61', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (304, 182, '55', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (370, 423, '476', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (89, 116, '213', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (319, 320, '64', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (145, 413, '108', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (286, 205, '105', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (342, 421, '302', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (360, 154, '120', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (102, 453, '36', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (91, 334, '190', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (300, 356, '285', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (318, 315, '484', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (265, 130, '236', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (326, 332, '112', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (560, 216, '408', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (380, 418, '416', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (363, 41, '422', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (405, 398, '393', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (551, 167, '43', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (393, 147, '302', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (431, 269, '310', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (462, 200, '311', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (497, 496, '362', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (163, 225, '438', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (453, 302, '256', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (310, 371, '343', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (524, 290, '333', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (502, 435, '44', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (90, 471, '313', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (391, 122, '254', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (519, 317, '144', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (277, 467, '433', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (302, 101, '224', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (294, 141, '335', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (554, 85, '351', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (241, 117, '386', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (503, 304, '472', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (345, 394, '16', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (251, 354, '299', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (448, 251, '397', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (169, 147, '157', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (98, 382, '412', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (464, 294, '241', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (329, 302, '102', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (152, 378, '120', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (444, 151, '486', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (528, 270, '95', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (408, 425, '80', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (397, 263, '244', false, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (198, 488, '31', true, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (181, 17, '508', true, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (118, 394, '271', true, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (516, 413, '271', true, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (566, 461, '443', true, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (520, 250, '466', true, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (99, 43, '410', true, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (307, 317, '390', true, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (536, 101, '390', true, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (156, 457, '193', true, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (532, 23, '193', true, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (298, 423, '170', true, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (190, 468, '110', true, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (534, 433, '33', true, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (83, 97, '436', true, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (486, 50, '436', true, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (491, 276, '263', true, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (335, 33, '174', true, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (539, 292, '174', true, '2018-08-07 14:59:50.220417', null);
INSERT INTO public.requests (id, user_id, song_id, resolved, created_at, message) VALUES (194, 361, '174', true, '2018-08-07 14:59:50.220417', null);

-- broadcasts
INSERT INTO public.broadcasts (id, name, broadcast_at, created_at) VALUES (33, 'Phat song ngay 2018-08-07 lan 3', '2018-08-07 22:01:44', '2018-08-07 22:01:43.911103');
INSERT INTO public.broadcasts (id, name, broadcast_at, created_at) VALUES (34, 'Phat song ngay 2018-08-07 lan 4', '2018-08-07 22:01:47', '2018-08-07 22:01:46.994131');
INSERT INTO public.broadcasts (id, name, broadcast_at, created_at) VALUES (35, 'Phat song ngay 2018-08-07 lan 5', '2018-08-07 22:01:49', '2018-08-07 22:01:49.059323');
INSERT INTO public.broadcasts (id, name, broadcast_at, created_at) VALUES (36, 'Phat song ngay 2018-08-07 lan 6', '2018-08-07 22:01:51', '2018-08-07 22:01:51.185425');
INSERT INTO public.broadcasts (id, name, broadcast_at, created_at) VALUES (37, 'Phat song ngay 2018-08-07 lan 7', '2018-08-07 22:01:53', '2018-08-07 22:01:53.180334');
INSERT INTO public.broadcasts (id, name, broadcast_at, created_at) VALUES (38, 'Phat song ngay 2018-08-07 lan 8', '2018-08-07 22:01:57', '2018-08-07 22:01:56.565081');

--broadcast_request
INSERT INTO public.broadcast_request (id, broadcast_id, request_id, order_number, created_at) VALUES (34, 33, 424, 1, '2018-08-07 22:01:43.949596');
INSERT INTO public.broadcast_request (id, broadcast_id, request_id, order_number, created_at) VALUES (35, 33, 220, 1, '2018-08-07 22:01:43.951856');
INSERT INTO public.broadcast_request (id, broadcast_id, request_id, order_number, created_at) VALUES (36, 33, 505, 1, '2018-08-07 22:01:43.953289');
INSERT INTO public.broadcast_request (id, broadcast_id, request_id, order_number, created_at) VALUES (37, 33, 243, 1, '2018-08-07 22:01:43.954723');
INSERT INTO public.broadcast_request (id, broadcast_id, request_id, order_number, created_at) VALUES (38, 33, 198, 1, '2018-08-07 22:01:43.956555');
INSERT INTO public.broadcast_request (id, broadcast_id, request_id, order_number, created_at) VALUES (39, 33, 440, 2, '2018-08-07 22:01:43.995849');
INSERT INTO public.broadcast_request (id, broadcast_id, request_id, order_number, created_at) VALUES (40, 33, 469, 2, '2018-08-07 22:01:43.998639');
INSERT INTO public.broadcast_request (id, broadcast_id, request_id, order_number, created_at) VALUES (41, 33, 555, 2, '2018-08-07 22:01:44.000638');
INSERT INTO public.broadcast_request (id, broadcast_id, request_id, order_number, created_at) VALUES (42, 33, 181, 2, '2018-08-07 22:01:44.002059');
INSERT INTO public.broadcast_request (id, broadcast_id, request_id, order_number, created_at) VALUES (43, 33, 292, 3, '2018-08-07 22:01:44.030645');
INSERT INTO public.broadcast_request (id, broadcast_id, request_id, order_number, created_at) VALUES (44, 33, 137, 3, '2018-08-07 22:01:44.033260');
INSERT INTO public.broadcast_request (id, broadcast_id, request_id, order_number, created_at) VALUES (45, 33, 118, 3, '2018-08-07 22:01:44.035051');
INSERT INTO public.broadcast_request (id, broadcast_id, request_id, order_number, created_at) VALUES (46, 33, 516, 3, '2018-08-07 22:01:44.036856');
INSERT INTO public.broadcast_request (id, broadcast_id, request_id, order_number, created_at) VALUES (47, 33, 217, 4, '2018-08-07 22:01:44.051289');
INSERT INTO public.broadcast_request (id, broadcast_id, request_id, order_number, created_at) VALUES (48, 33, 343, 4, '2018-08-07 22:01:44.053610');
INSERT INTO public.broadcast_request (id, broadcast_id, request_id, order_number, created_at) VALUES (49, 33, 242, 4, '2018-08-07 22:01:44.055330');
INSERT INTO public.broadcast_request (id, broadcast_id, request_id, order_number, created_at) VALUES (50, 33, 566, 4, '2018-08-07 22:01:44.057846');
INSERT INTO public.broadcast_request (id, broadcast_id, request_id, order_number, created_at) VALUES (51, 33, 334, 5, '2018-08-07 22:01:44.085976');
INSERT INTO public.broadcast_request (id, broadcast_id, request_id, order_number, created_at) VALUES (52, 33, 419, 5, '2018-08-07 22:01:44.088881');
INSERT INTO public.broadcast_request (id, broadcast_id, request_id, order_number, created_at) VALUES (53, 33, 389, 5, '2018-08-07 22:01:44.090603');
INSERT INTO public.broadcast_request (id, broadcast_id, request_id, order_number, created_at) VALUES (54, 33, 80, 5, '2018-08-07 22:01:44.092049');
INSERT INTO public.broadcast_request (id, broadcast_id, request_id, order_number, created_at) VALUES (55, 34, 396, 1, '2018-08-07 22:01:47.018570');
INSERT INTO public.broadcast_request (id, broadcast_id, request_id, order_number, created_at) VALUES (56, 34, 348, 1, '2018-08-07 22:01:47.021725');
INSERT INTO public.broadcast_request (id, broadcast_id, request_id, order_number, created_at) VALUES (57, 34, 520, 1, '2018-08-07 22:01:47.023574');
INSERT INTO public.broadcast_request (id, broadcast_id, request_id, order_number, created_at) VALUES (58, 34, 410, 2, '2018-08-07 22:01:47.034296');
INSERT INTO public.broadcast_request (id, broadcast_id, request_id, order_number, created_at) VALUES (59, 34, 161, 2, '2018-08-07 22:01:47.036579');
INSERT INTO public.broadcast_request (id, broadcast_id, request_id, order_number, created_at) VALUES (60, 34, 99, 2, '2018-08-07 22:01:47.041623');
INSERT INTO public.broadcast_request (id, broadcast_id, request_id, order_number, created_at) VALUES (61, 34, 274, 3, '2018-08-07 22:01:47.072873');
INSERT INTO public.broadcast_request (id, broadcast_id, request_id, order_number, created_at) VALUES (62, 34, 307, 3, '2018-08-07 22:01:47.076192');
INSERT INTO public.broadcast_request (id, broadcast_id, request_id, order_number, created_at) VALUES (63, 34, 536, 3, '2018-08-07 22:01:47.077998');
INSERT INTO public.broadcast_request (id, broadcast_id, request_id, order_number, created_at) VALUES (64, 34, 504, 4, '2018-08-07 22:01:47.107181');
INSERT INTO public.broadcast_request (id, broadcast_id, request_id, order_number, created_at) VALUES (65, 34, 473, 4, '2018-08-07 22:01:47.115712');
INSERT INTO public.broadcast_request (id, broadcast_id, request_id, order_number, created_at) VALUES (66, 34, 210, 4, '2018-08-07 22:01:47.117991');
INSERT INTO public.broadcast_request (id, broadcast_id, request_id, order_number, created_at) VALUES (67, 34, 196, 5, '2018-08-07 22:01:47.142967');
INSERT INTO public.broadcast_request (id, broadcast_id, request_id, order_number, created_at) VALUES (68, 34, 156, 5, '2018-08-07 22:01:47.145384');
INSERT INTO public.broadcast_request (id, broadcast_id, request_id, order_number, created_at) VALUES (69, 34, 532, 5, '2018-08-07 22:01:47.146932');
INSERT INTO public.broadcast_request (id, broadcast_id, request_id, order_number, created_at) VALUES (70, 35, 176, 1, '2018-08-07 22:01:49.071617');
INSERT INTO public.broadcast_request (id, broadcast_id, request_id, order_number, created_at) VALUES (71, 35, 328, 1, '2018-08-07 22:01:49.073740');
INSERT INTO public.broadcast_request (id, broadcast_id, request_id, order_number, created_at) VALUES (72, 35, 305, 1, '2018-08-07 22:01:49.075199');
INSERT INTO public.broadcast_request (id, broadcast_id, request_id, order_number, created_at) VALUES (73, 35, 236, 2, '2018-08-07 22:01:49.092593');
INSERT INTO public.broadcast_request (id, broadcast_id, request_id, order_number, created_at) VALUES (74, 35, 128, 2, '2018-08-07 22:01:49.094749');
INSERT INTO public.broadcast_request (id, broadcast_id, request_id, order_number, created_at) VALUES (75, 35, 298, 2, '2018-08-07 22:01:49.096472');
INSERT INTO public.broadcast_request (id, broadcast_id, request_id, order_number, created_at) VALUES (76, 35, 232, 3, '2018-08-07 22:01:49.106294');
INSERT INTO public.broadcast_request (id, broadcast_id, request_id, order_number, created_at) VALUES (77, 35, 201, 3, '2018-08-07 22:01:49.108482');
INSERT INTO public.broadcast_request (id, broadcast_id, request_id, order_number, created_at) VALUES (78, 35, 239, 3, '2018-08-07 22:01:49.110293');
INSERT INTO public.broadcast_request (id, broadcast_id, request_id, order_number, created_at) VALUES (79, 35, 526, 4, '2018-08-07 22:01:49.122097');
INSERT INTO public.broadcast_request (id, broadcast_id, request_id, order_number, created_at) VALUES (80, 35, 550, 4, '2018-08-07 22:01:49.123910');
INSERT INTO public.broadcast_request (id, broadcast_id, request_id, order_number, created_at) VALUES (81, 35, 190, 4, '2018-08-07 22:01:49.125357');
INSERT INTO public.broadcast_request (id, broadcast_id, request_id, order_number, created_at) VALUES (82, 35, 253, 5, '2018-08-07 22:01:49.137208');
INSERT INTO public.broadcast_request (id, broadcast_id, request_id, order_number, created_at) VALUES (83, 35, 197, 5, '2018-08-07 22:01:49.142517');
INSERT INTO public.broadcast_request (id, broadcast_id, request_id, order_number, created_at) VALUES (84, 35, 439, 5, '2018-08-07 22:01:49.144032');
INSERT INTO public.broadcast_request (id, broadcast_id, request_id, order_number, created_at) VALUES (85, 36, 398, 1, '2018-08-07 22:01:51.198680');
INSERT INTO public.broadcast_request (id, broadcast_id, request_id, order_number, created_at) VALUES (86, 36, 487, 1, '2018-08-07 22:01:51.201075');
INSERT INTO public.broadcast_request (id, broadcast_id, request_id, order_number, created_at) VALUES (87, 36, 184, 1, '2018-08-07 22:01:51.202942');
INSERT INTO public.broadcast_request (id, broadcast_id, request_id, order_number, created_at) VALUES (88, 36, 436, 2, '2018-08-07 22:01:51.232210');
INSERT INTO public.broadcast_request (id, broadcast_id, request_id, order_number, created_at) VALUES (89, 36, 140, 2, '2018-08-07 22:01:51.234598');
INSERT INTO public.broadcast_request (id, broadcast_id, request_id, order_number, created_at) VALUES (90, 36, 553, 2, '2018-08-07 22:01:51.236392');
INSERT INTO public.broadcast_request (id, broadcast_id, request_id, order_number, created_at) VALUES (91, 36, 501, 3, '2018-08-07 22:01:51.263349');
INSERT INTO public.broadcast_request (id, broadcast_id, request_id, order_number, created_at) VALUES (92, 36, 229, 3, '2018-08-07 22:01:51.266533');
INSERT INTO public.broadcast_request (id, broadcast_id, request_id, order_number, created_at) VALUES (93, 36, 150, 3, '2018-08-07 22:01:51.268488');
INSERT INTO public.broadcast_request (id, broadcast_id, request_id, order_number, created_at) VALUES (94, 36, 192, 4, '2018-08-07 22:01:51.288984');
INSERT INTO public.broadcast_request (id, broadcast_id, request_id, order_number, created_at) VALUES (95, 36, 227, 4, '2018-08-07 22:01:51.291168');
INSERT INTO public.broadcast_request (id, broadcast_id, request_id, order_number, created_at) VALUES (96, 36, 165, 4, '2018-08-07 22:01:51.292622');
INSERT INTO public.broadcast_request (id, broadcast_id, request_id, order_number, created_at) VALUES (97, 36, 507, 5, '2018-08-07 22:01:51.306425');
INSERT INTO public.broadcast_request (id, broadcast_id, request_id, order_number, created_at) VALUES (98, 36, 558, 5, '2018-08-07 22:01:51.308725');
INSERT INTO public.broadcast_request (id, broadcast_id, request_id, order_number, created_at) VALUES (99, 36, 534, 5, '2018-08-07 22:01:51.310620');
INSERT INTO public.broadcast_request (id, broadcast_id, request_id, order_number, created_at) VALUES (100, 37, 226, 1, '2018-08-07 22:01:53.190962');
INSERT INTO public.broadcast_request (id, broadcast_id, request_id, order_number, created_at) VALUES (101, 37, 92, 1, '2018-08-07 22:01:53.193601');
INSERT INTO public.broadcast_request (id, broadcast_id, request_id, order_number, created_at) VALUES (102, 37, 418, 1, '2018-08-07 22:01:53.195082');
INSERT INTO public.broadcast_request (id, broadcast_id, request_id, order_number, created_at) VALUES (103, 37, 330, 2, '2018-08-07 22:01:53.207152');
INSERT INTO public.broadcast_request (id, broadcast_id, request_id, order_number, created_at) VALUES (104, 37, 416, 2, '2018-08-07 22:01:53.209396');
INSERT INTO public.broadcast_request (id, broadcast_id, request_id, order_number, created_at) VALUES (105, 37, 339, 2, '2018-08-07 22:01:53.213503');
INSERT INTO public.broadcast_request (id, broadcast_id, request_id, order_number, created_at) VALUES (106, 37, 258, 3, '2018-08-07 22:01:53.228747');
INSERT INTO public.broadcast_request (id, broadcast_id, request_id, order_number, created_at) VALUES (107, 37, 83, 3, '2018-08-07 22:01:53.230868');
INSERT INTO public.broadcast_request (id, broadcast_id, request_id, order_number, created_at) VALUES (108, 37, 486, 3, '2018-08-07 22:01:53.233340');
INSERT INTO public.broadcast_request (id, broadcast_id, request_id, order_number, created_at) VALUES (109, 37, 402, 4, '2018-08-07 22:01:53.249967');
INSERT INTO public.broadcast_request (id, broadcast_id, request_id, order_number, created_at) VALUES (110, 37, 213, 4, '2018-08-07 22:01:53.252018');
INSERT INTO public.broadcast_request (id, broadcast_id, request_id, order_number, created_at) VALUES (111, 37, 491, 4, '2018-08-07 22:01:53.253768');
INSERT INTO public.broadcast_request (id, broadcast_id, request_id, order_number, created_at) VALUES (112, 37, 509, 5, '2018-08-07 22:01:53.278425');
INSERT INTO public.broadcast_request (id, broadcast_id, request_id, order_number, created_at) VALUES (113, 37, 268, 5, '2018-08-07 22:01:53.281594');
INSERT INTO public.broadcast_request (id, broadcast_id, request_id, order_number, created_at) VALUES (114, 37, 189, 5, '2018-08-07 22:01:53.284927');
INSERT INTO public.broadcast_request (id, broadcast_id, request_id, order_number, created_at) VALUES (115, 38, 141, 1, '2018-08-07 22:01:56.585156');
INSERT INTO public.broadcast_request (id, broadcast_id, request_id, order_number, created_at) VALUES (116, 38, 494, 1, '2018-08-07 22:01:56.587064');
INSERT INTO public.broadcast_request (id, broadcast_id, request_id, order_number, created_at) VALUES (117, 38, 479, 1, '2018-08-07 22:01:56.588730');
INSERT INTO public.broadcast_request (id, broadcast_id, request_id, order_number, created_at) VALUES (118, 38, 335, 2, '2018-08-07 22:01:56.607293');
INSERT INTO public.broadcast_request (id, broadcast_id, request_id, order_number, created_at) VALUES (119, 38, 539, 2, '2018-08-07 22:01:56.610293');
INSERT INTO public.broadcast_request (id, broadcast_id, request_id, order_number, created_at) VALUES (120, 38, 194, 2, '2018-08-07 22:01:56.612191');
INSERT INTO public.broadcast_request (id, broadcast_id, request_id, order_number, created_at) VALUES (121, 38, 235, 3, '2018-08-07 22:01:56.625219');
INSERT INTO public.broadcast_request (id, broadcast_id, request_id, order_number, created_at) VALUES (122, 38, 324, 3, '2018-08-07 22:01:56.628175');
INSERT INTO public.broadcast_request (id, broadcast_id, request_id, order_number, created_at) VALUES (123, 38, 103, 3, '2018-08-07 22:01:56.629987');
INSERT INTO public.broadcast_request (id, broadcast_id, request_id, order_number, created_at) VALUES (124, 38, 541, 4, '2018-08-07 22:01:56.641703');
INSERT INTO public.broadcast_request (id, broadcast_id, request_id, order_number, created_at) VALUES (125, 38, 437, 4, '2018-08-07 22:01:56.644100');
INSERT INTO public.broadcast_request (id, broadcast_id, request_id, order_number, created_at) VALUES (126, 38, 122, 4, '2018-08-07 22:01:56.645583');
INSERT INTO public.broadcast_request (id, broadcast_id, request_id, order_number, created_at) VALUES (127, 38, 413, 5, '2018-08-07 22:01:56.660827');
INSERT INTO public.broadcast_request (id, broadcast_id, request_id, order_number, created_at) VALUES (128, 38, 109, 5, '2018-08-07 22:01:56.662685');
INSERT INTO public.broadcast_request (id, broadcast_id, request_id, order_number, created_at) VALUES (129, 38, 535, 5, '2018-08-07 22:01:56.664133');