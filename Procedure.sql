#Procedure
#Register a client for a class session ensuring that the class
#session exists and that the client is not already registered for it.


DELIMITER //

CREATE PROCEDURE RegisterClientToClass(IN client_id INT, IN class_session_id INT)
BEGIN
    DECLARE class_exists INT;
    DECLARE client_already_registered INT;

    -- Check if the class session exists
    SELECT COUNT(*)
    INTO class_exists
    FROM ClassSession
    WHERE ClassSessionID = class_session_id;

    -- Check if the client is already registered for the class
    SELECT COUNT(*)
    INTO client_already_registered
    FROM ClientClassRegistration
    WHERE ClientID = client_id AND ClassSessionID = class_session_id;

    -- If the class session exists and the client isn't already registered, insert the registration
    IF class_exists > 0 AND client_already_registered = 0 THEN
        INSERT INTO ClientClassRegistration (ClientID, ClassSessionID)
        VALUES (client_id, class_session_id);
    ELSEIF class_exists = 0 THEN
        -- Raise an error if the class session doesn't exist
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: Class session does not exist.';
    ELSEIF client_already_registered > 0 THEN
        -- Raise an error if the client is already registered
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: Client is already registered for this class session.';
    END IF;
END //

DELIMITER ;