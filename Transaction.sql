#Transaction
#Adds a new staff member to a gym and updates the gym's details.

START TRANSACTION;

-- Insert a new staff member
INSERT INTO Staff (FullName, ContactNumber, DateOfBirth, HomeAddress, Role, Specialization)
VALUES ('Chris', '691234', '1990-05-01', 'katoikia', 'trainer', 'Karate instructor');



UPDATE Gym
SET OperatingHours = '06:00-22:00'
WHERE GymID = 1;

COMMIT;
