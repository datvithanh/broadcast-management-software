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

