INSERT INTO Gym (GymID, GymName, StreetAddress, City, PostalCode, OperatingHours)
VALUES (001, 'Max Gym', 'Dagkli 15', 'Kavala', '12345', '06:00-22:00'),
       (002, 'Fitness Gym', 'Korah 18', 'Ioannina', '678908', '08:00-23:00');

INSERT INTO Owner (OwnerID, FullName, VATNumber)
VALUES (01, 'Ioannis Papaxristou', '182036'),
       (02, 'Anna Karagianni', '168923');

INSERT INTO Staff (StaffID, FullName, ContactNumber, DateOfBirth, HomeAddress, Role, Specialization)
VALUES (11, 'Michalis Mitsis', '694051', '1995-04-12', 'Komninon 58', 'administrative', 'None'),
       (12, 'Giorgos Panou', '694185', '1992-07-23', 'Averof 25', 'trainer', 'Personal Training');

INSERT INTO Client (ClientID, FullName, ContactNumber, DateOfBirth, HomeAddress, RegistrationType)
VALUES (201, 'Panos Theodorou', '694023', '1995-02-17', 'Pavlou 39', 'Regular - Full'),
       (202, 'Dimitra Yiannou', '697089', '1998-11-08', 'Triantafillidi 11', 'Student - 50% Reduced');

INSERT INTO Equipment (EquipmentID, Type, Description)
VALUES (901, 'free_weights', 'Dumbbells and Barbells'),
       (902, 'machines', 'Treadmills and Bikes');

INSERT INTO Subscription (SubscriptionID, Type, Price, Duration)
VALUES (101, 'regular', 30.00, '1 month'),
       (102, 'reduced', 15.00, '1 month');

INSERT INTO ClassSession (ClassSessionID, EquipmentID, StartTime, EndTime)
VALUES (501, 1, '2023-09-21 10:00:00', '2023-09-21 11:00:00'),
       (502, 2, '2023-10-11 12:00:00', '2023-10-11 13:00:00');

INSERT INTO GymOwner (GymID, OwnerID)
VALUES (001, 01),
       (002, 02);

INSERT INTO StaffGym (StaffID, GymID)
VALUES (11, 001),
       (12, 002);

INSERT INTO ClientGym (ClientID, GymID)
VALUES (201, 001),
       (202, 002);

INSERT INTO ClientSubscription (ClientID, SubscriptionID, StartDate, EndDate)
VALUES (201, 101, '2023-09-21', '2023-10-21'),
       (202, 102, '2023-10-11', '2023-11-11');

INSERT INTO ClientFacilityAccess (ClientID, EquipmentID)
VALUES (201, 901),
       (202, 902);

INSERT INTO ClientClassRegistration (ClientID, ClassSessionID)
VALUES (201, 501),
       (202, 502);

