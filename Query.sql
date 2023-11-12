#Retrieve the total number of gyms per city:
SELECT City, COUNT(*) as TotalGyms
FROM Gym
GROUP BY City;

#Retrieve owners who have a unique VAT number and order them by name:
SELECT FullName, VATNumber
FROM Owner
ORDER BY FullName;

#List staff members who are trainers and their specializations:
SELECT FullName, Specialization
FROM Staff
WHERE Role LIKE '%trainer%'
AND Specialization IS NOT NULL;

#Retrieve clients with their registration types, sorted by date of birth:
SELECT FullName, RegistrationType, DateOfBirth
FROM Client
ORDER BY DateOfBirth;

#Retrieve all equipment types available in each gym:
SELECT GymID, GROUP_CONCAT(Type) as EquipmentTypes
FROM Equipment
GROUP BY GymID;

#Find the most expensive subscription type:
SELECT Type, MAX(Price) as MaxPrice
FROM Subscription
GROUP BY Type
ORDER BY MaxPrice DESC
LIMIT 1;

#Find class sessions that are longer than 1 hour:
SELECT ClassSessionID, TIMEDIFF(EndTime, StartTime) as Duration
FROM ClassSession
HAVING Duration > '01:00:00';

#Find gyms with more than one owner:
SELECT GymID, COUNT(OwnerID) as OwnerCount
FROM GymOwner
GROUP BY GymID
HAVING OwnerCount > 1;

#List staff who work at multiple gyms:
SELECT StaffID, COUNT(GymID) as GymCount
FROM StaffGym
GROUP BY StaffID
HAVING GymCount > 1;

#List clients and the number of different gyms they attend:
SELECT C.FullName, COUNT(DISTINCT CG.GymID) as GymCount
FROM ClientGym CG
JOIN Client C ON CG.ClientID = C.ClientID
GROUP BY CG.ClientID;

#Find clients with subscriptions longer than 30 days:
SELECT ClientID, SubscriptionID, DATEDIFF(EndDate, StartDate) as SubscriptionLength
FROM ClientSubscription
WHERE DATEDIFF(EndDate, StartDate) > 30;

#Count how many clients have accessed each type of equipment:
SELECT EquipmentID, COUNT(ClientID) as ClientCount
FROM ClientFacilityAccess
GROUP BY EquipmentID;

#List clients who have registered for more than one class session:
SELECT ClientID, COUNT(ClassSessionID) as SessionCount
FROM ClientClassRegistration
GROUP BY ClientID
HAVING SessionCount > 1;
