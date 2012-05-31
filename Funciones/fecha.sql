DELIMITER //

CREATE FUNcTION fecha() RETURNS datetime
BEGIN
    RETURN current_date;
END
//