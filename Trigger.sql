#Trigger
#When a new class session is created (ClassSession), there's a check to ensure it does not
#overlap with existing class sessions that use the same equipment or facility area.

DELIMITER //

CREATE TRIGGER BeforeInsertClassSession
BEFORE INSERT ON ClassSession
FOR EACH ROW
BEGIN
    DECLARE overlap_count INT;
    
    -- Check for any overlap in class sessions for the same equipment and group by EquipmentID
    SELECT COUNT(*) INTO overlap_count
    FROM ClassSession
    WHERE NEW.EquipmentID = EquipmentID
    AND (
        (NEW.StartTime BETWEEN StartTime AND EndTime)
        OR (NEW.EndTime BETWEEN StartTime AND EndTime)
        OR (StartTime BETWEEN NEW.StartTime AND NEW.EndTime)
        OR (EndTime BETWEEN NEW.StartTime AND NEW.EndTime)
    )
    GROUP BY EquipmentID
    HAVING COUNT(*) > 1; -- You can adjust the threshold in the HAVING clause as needed

    -- If there is an overlap, signal an error
    IF overlap_count > 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: Overlapping class session times.';
    END IF;
END //

DELIMITER ;
