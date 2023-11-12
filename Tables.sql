CREATE TABLE Gym (
    GymID INT AUTO_INCREMENT PRIMARY KEY,
    GymName VARCHAR(100) NOT NULL,
    StreetAddress VARCHAR(255) NOT NULL,
    City VARCHAR(50) NOT NULL,
    PostalCode VARCHAR(10) NOT NULL,
    OperatingHours VARCHAR(100) NOT NULL
);

CREATE TABLE Owner (
    OwnerID INT AUTO_INCREMENT PRIMARY KEY,
    FullName VARCHAR(100) NOT NULL,
    VATNumber VARCHAR(20) NOT NULL UNIQUE
);

CREATE TABLE Staff (
    StaffID INT AUTO_INCREMENT PRIMARY KEY,
    FullName VARCHAR(100) NOT NULL,
    ContactNumber VARCHAR(15) NOT NULL,
    DateOfBirth DATE NOT NULL,
    HomeAddress VARCHAR(255) NOT NULL,
    Role SET('administrative', 'trainer') NOT NULL,
    Specialization VARCHAR(100)
);

CREATE TABLE Client (
    ClientID INT AUTO_INCREMENT PRIMARY KEY,
    FullName VARCHAR(100) NOT NULL,
    ContactNumber VARCHAR(15) NOT NULL,
    DateOfBirth DATE NOT NULL,
    HomeAddress VARCHAR(255) NOT NULL,
    RegistrationType VARCHAR(50) NOT NULL UNIQUE
);


CREATE TABLE Equipment (
    EquipmentID INT AUTO_INCREMENT PRIMARY KEY,
    GymID INT,
    Type SET('free_weights', 'machines', 'group_programs', 'martial_arts', 'locker_room') NOT NULL,
    Description VARCHAR(255),
    FOREIGN KEY (GymID) REFERENCES Gym(GymID)
);


CREATE TABLE Subscription (
    SubscriptionID INT AUTO_INCREMENT PRIMARY KEY,
    Type SET('reduced', 'regular', 'equipment_based') NOT NULL,
    Price DECIMAL(10, 2) NOT NULL,
    Duration VARCHAR(50) NOT NULL
);

# In order to schedule the class sessions (group programs and martial arts)

CREATE TABLE ClassSession (
    ClassSessionID INT AUTO_INCREMENT PRIMARY KEY,
    EquipmentID INT,
    StartTime DATETIME NOT NULL,
    EndTime DATETIME NOT NULL,
    FOREIGN KEY (EquipmentID) REFERENCES Equipment(EquipmentID)
);

##### Tables to create an Entity - Relationship Diagram (ERD) in MySQL Workbench #####

# For Gym owners owning multiple Gyms and multiple Gyms being owned by multiple owners

CREATE TABLE GymOwner (
    GymID INT,
    OwnerID INT,
    PRIMARY KEY (GymID, OwnerID),
    FOREIGN KEY (GymID) REFERENCES Gym(GymID),
    FOREIGN KEY (OwnerID) REFERENCES Owner(OwnerID)
);

# For staff working at multiple gyms

CREATE TABLE StaffGym (
    StaffID INT,
    GymID INT,
    PRIMARY KEY (StaffID, GymID),
    FOREIGN KEY (StaffID) REFERENCES Staff(StaffID),
    FOREIGN KEY (GymID) REFERENCES Gym(GymID)
);

# For Clients that can attend multiple Gyms

CREATE TABLE ClientGym (
    ClientID INT,
    GymID INT,
    PRIMARY KEY (ClientID, GymID),
    FOREIGN KEY (ClientID) REFERENCES Client(ClientID),
    FOREIGN KEY (GymID) REFERENCES Gym(GymID)
);

# For Clients that can have different subscriptions
CREATE TABLE ClientSubscription (
    ClientID INT,
    SubscriptionID INT,
    StartDate DATE NOT NULL,
    EndDate DATE NOT NULL,
    PRIMARY KEY (ClientID, SubscriptionID, StartDate),
    FOREIGN KEY (ClientID) REFERENCES Client(ClientID),
    FOREIGN KEY (SubscriptionID) REFERENCES Subscription(SubscriptionID)
);


# For clients that can use various equipment and classes
CREATE TABLE ClientFacilityAccess (
    ClientID INT,
    EquipmentID INT,
    PRIMARY KEY (ClientID, EquipmentID),
    FOREIGN KEY (ClientID) REFERENCES Client(ClientID),
    FOREIGN KEY (EquipmentID) REFERENCES Equipment(EquipmentID)
);

# To connect Clients with classes (group_programs, martial_arts). 
# At least one Client should use the classes in order for them to exist.

CREATE TABLE ClientClassRegistration (
    ClientID INT,
    ClassSessionID INT,
    PRIMARY KEY (ClientID, ClassSessionID),
    FOREIGN KEY (ClientID) REFERENCES Client(ClientID),
    FOREIGN KEY (ClassSessionID) REFERENCES ClassSession(ClassSessionID)
);
