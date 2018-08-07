CREATE OR REPLACE FUNCTION insert_broadcasts(_name character varying, _broadcast_at timestamp without time zone)
  RETURNS void
LANGUAGE plpgsql
AS $$
BEGIN
  IF (_broadcast_at = '1970-01-01 00:00:01')
  THEN
    INSERT INTO broadcasts (name)
    VALUES (_name);
    RETURN;
  END IF;

  INSERT INTO broadcasts (name, broadcast_at)
  VALUES (_name, _broadcast_at);
END
$$;

CREATE OR REPLACE FUNCTION insert_requests(_user_id INTEGER, _song_id INTEGER)
  RETURNS VOID
LANGUAGE plpgsql
AS
$$
BEGIN
  INSERT INTO requests (user_id, song_id)
  VALUES (_user_id, _song_id);
END
$$;

CREATE OR REPLACE FUNCTION insert_users(_name VARCHAR(255), _phone VARCHAR(255), _address VARCHAR(255))
  RETURNS TABLE(user_id INTEGER)
LANGUAGE plpgsql
AS
$$
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

CREATE OR REPLACE FUNCTION insert_songs(_name        VARCHAR(255), _composer VARCHAR(255), _singer VARCHAR(255),
                                        _released_at DATE)
  RETURNS VOID
LANGUAGE plpgsql
AS
$$
BEGIN
  INSERT INTO songs (name, composer, singer, released_at) VALUES (_name, _composer, _singer, _released_at);
END
$$;

CREATE OR REPLACE FUNCTION insert_broadcast_request(_broadcast_id INTEGER, _request_id INTEGER, _order_number INTEGER)
  RETURNS VOID
LANGUAGE plpgsql
AS $$
BEGIN
  INSERT INTO broadcast_request (broadcast_id, request_id, order_number)
  VALUES (_broadcast_id, _request_id, _order_number);
END $$;

CREATE OR REPLACE FUNCTION get_songs()
  RETURNS TABLE(id integer, name character varying, composer character varying, singer character varying, released_at date, created_at date)
LANGUAGE plpgsql
AS $$
BEGIN
  RETURN QUERY SELECT * FROM songs;
END;
$$;

CREATE OR REPLACE FUNCTION get_requests()
  RETURNS TABLE(id integer, user_name character varying, created_at DATE, song_name character varying, singer_name character varying, composer_name character varying, resolved boolean)
LANGUAGE plpgsql
AS $$
BEGIN
  RETURN QUERY (
  SELECT requests.id, requests.user_name, requests.created_at as created_at, songs.name as song_name, songs.singer as singer_name, songs.composer as composer_name, requests.resolved
  FROM (
          SELECT requests.*, users.name as user_name
          FROM requests LEFT JOIN users ON requests.user_id = users.id
       ) as requests LEFT JOIN songs ON requests.song_id = songs.id
  );

END;
$$;

CREATE OR REPLACE FUNCTION get_favorite_songs()
  RETURNS TABLE(id INTEGER, song_name VARCHAR(255), request_count BIGINT)
LANGUAGE plpgsql
AS $$
BEGIN
  RETURN QUERY (
    SELECT songs.id as id, songs.name as song_name, count(r.id) as request_count
    FROM songs LEFT JOIN requests r ON songs.id = r.song_id
    WHERE r.resolved = TRUE 
    GROUP BY songs.id
    ORDER BY count(r.id) DESC
  );
END;
$$

CREATE OR REPLACE FUNCTION get_unbroadcasted_songs()
  RETURNS TABLE(id INTEGER, song_name VARCHAR(255), request_count BIGINT)
LANGUAGE plpgsql
AS $$
BEGIN
  RETURN QUERY (
    SELECT songs.id as id, songs.name as song_name, count(r.id) as request_count
    FROM songs LEFT JOIN requests r ON songs.id = r.song_id
    WHERE r.resolved = FALSE 
    GROUP BY songs.id
    ORDER BY count(r.id) DESC
  );
END;
$$




