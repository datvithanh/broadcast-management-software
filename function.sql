CREATE OR REPLACE FUNCTION insert_broadcasts(_name VARCHAR(255), _broadcast_at DATE)
  RETURNS VOID
LANGUAGE plpgsql
AS
$$
BEGIN
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


