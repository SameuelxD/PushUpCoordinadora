CREATE TABLE Country (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL
);

CREATE TABLE Department (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    idCountryFk INT NOT NULL,
    CONSTRAINT department_idcountryfk_foreign FOREIGN KEY (idCountryFk) REFERENCES Country (id)
);

CREATE TABLE City (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    idDepartmentFk INT NOT NULL,
    CONSTRAINT city_iddepartmentfk_foreign FOREIGN KEY (idDepartmentFk) REFERENCES Department (id)
);

CREATE TABLE Address (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    directionLineOne VARCHAR(100) NOT NULL,
    directionLineTwo VARCHAR(100) NULL,
    idCityFk INT NOT NULL,
    CONSTRAINT address_idcityfk_foreign FOREIGN KEY (idCityFk) REFERENCES City (id)
);

CREATE TABLE TypeEmployee (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL COMMENT 'employee position',
    description VARCHAR(255) NULL
);

CREATE TABLE TypeStatus (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    status VARCHAR(15) NOT NULL,
    description VARCHAR(255) NULL
);

CREATE TABLE TypeTransport (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    category VARCHAR(50) NOT NULL,
    description VARCHAR(255) NOT NULL
);

CREATE TABLE Transport (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    idTypeTransportFk INT NOT NULL,
    name VARCHAR(50) NOT NULL,
    description VARCHAR(255) NOT NULL,
    CONSTRAINT transport_idtypetransportfk_foreign FOREIGN KEY (idTypeTransportFk) REFERENCES TypeTransport (id)
);

CREATE TABLE TrackingPackage (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    idTransportFk INT NOT NULL,
    ubication VARCHAR(255) NOT NULL,
    idTypeStatusFk INT NOT NULL,
    CONSTRAINT trackingpackage_idtransportfk_foreign FOREIGN KEY (idTransportFk) REFERENCES Transport (id),
    CONSTRAINT trackingpackage_idtypestatusfk_foreign FOREIGN KEY (idTypeStatusFk) REFERENCES TypeStatus (id)
);

CREATE TABLE TypePackage (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    category VARCHAR(50) NOT NULL COMMENT 'The category depends on the characteristics of the package',
    description VARCHAR(255) NULL
);

CREATE TABLE Package (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    idTypePackageFk INT NOT NULL,
    name VARCHAR(50) NOT NULL,
    description VARCHAR(255) NULL,
    weight INT NOT NULL,
    high INT NOT NULL,
    idTrackingFk INT NOT NULL,
    CONSTRAINT package_idtrackingfk_foreign FOREIGN KEY (idTrackingFk) REFERENCES TrackingPackage (id),
    CONSTRAINT package_idtypepackagefk_foreign FOREIGN KEY (idTypePackageFk) REFERENCES TypePackage (id)
);

CREATE TABLE TypeAddress (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    idAddressFk INT NOT NULL,
    name VARCHAR(50) NOT NULL COMMENT 'Type of address depending on the user, customer, or employee',
    CONSTRAINT typeaddress_idaddressfk_foreign FOREIGN KEY (idAddressFk) REFERENCES Address (id)
);

CREATE TABLE Contact (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    telephoneNumber INT NOT NULL,
    email VARCHAR(50) NOT NULL
);

CREATE TABLE TypeContact (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    idContactFk INT NOT NULL,
    name VARCHAR(50) NOT NULL COMMENT 'Type of contact depending on the user, customer, or employee',
    CONSTRAINT typecontact_idcontactfk_foreign FOREIGN KEY (idContactFk) REFERENCES Contact (id)
);

CREATE TABLE Employee (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    idTypeEmployeeFk INT NOT NULL,
    idTypeAddressFk INT NOT NULL,
    idTypeContactFk INT NOT NULL,
    CONSTRAINT employee_idtypeaddressfk_foreign FOREIGN KEY (idTypeAddressFk) REFERENCES TypeAddress (id),
    CONSTRAINT employee_idtypeemployeefk_foreign FOREIGN KEY (idTypeEmployeeFk) REFERENCES TypeEmployee (id),
    CONSTRAINT employee_idtypecontactfk_foreign FOREIGN KEY (idTypeContactFk) REFERENCES TypeContact (id)
);

CREATE TABLE Customer (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    idTypeAddressFk INT NOT NULL,
    idTypeContactFk INT NOT NULL,
    CONSTRAINT customer_idtypeaddressfk_foreign FOREIGN KEY (idTypeAddressFk) REFERENCES TypeAddress (id),
    CONSTRAINT customer_idtypecontact_foreign FOREIGN KEY (idTypeContactFk) REFERENCES TypeContact (id)
);

CREATE TABLE Order (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    idCustomerFk INT NOT NULL,
    idPackageFk INT NOT NULL,
    OrderDate DATE NOT NULL,
    estimatedDeliveryDate DATE NOT NULL,
    deliverDate DATE NOT NULL,
    idExitAddress INT NOT NULL,
    idDeliveryAddress INT NOT NULL,
    CONSTRAINT order_idexitaddress_foreign FOREIGN KEY (idExitAddress) REFERENCES TypeAddress (id),
    CONSTRAINT order_iddeliveryaddress_foreign FOREIGN KEY (idDeliveryAddress) REFERENCES TypeAddress (id),
    CONSTRAINT order_idcustomerfk_foreign FOREIGN KEY (idCustomerFk) REFERENCES Customer (id),
    CONSTRAINT order_idpackagefk_foreign FOREIGN KEY (idPackageFk) REFERENCES Package (id)
);