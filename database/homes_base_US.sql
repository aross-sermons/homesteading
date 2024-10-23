DROP DATABASE IF EXISTS HOMESTEAD;
CREATE TABLE HOMESTEAD;
USE HOMESTEAD;

CREATE TABLE locations (
	location_id INT UNIQUE NOT NULL,
    common_name VARCHAR(50) NOT NULL, # Store/business name, homestead, etc.
    location_type VARCHAR(50) NOT NULL, # Feed store, hardware store, homestead land, etc.
    address VARCHAR(250) NOT NULL,
    city VARCHAR(50) NOT NULL, # Longest US city name is allegedly 45 letters long (AI generated answer)
    state VARCHAR(27) NOT NULL, # Longest US state name is 27 characters long (Commonwealth of Massachusetts, if you're wondering)
	zip VARCHAR(5) NOT NULL,
    latitude DECIMAL(8, 6) NOT NULL, # For map plotting
    longitude DECIMAL(9, 6) NOT NULL, # For map plotting
    PRIMARY KEY(location_id)
);

CREATE TABLE location_connections (
	connection_id INT UNIQUE NOT NULL,
    homestead_id INT NOT NULL,
    resource_id INT NOT NULL,
    distance_miles FLOAT NOT NULL,
    distance_minutes INT NOT NULL,
    PRIMARY KEY(connection_id),
    FOREIGN KEY(homestead_id) REFERENCES locations(location_id),
    FOREIGN KEY(resource_id) REFERENCES locations(location_id)
);

CREATE TABLE land (
	land_id INT UNIQUE NOT NULL,
    homestead_id INT NOT NULL,
    acreage INT NOT NULL,
    price DECIMAL(9, 2) NOT NULL,
    price_per_acre DECIMAL(6, 2) NOT NULL,
    zoned VARCHAR(25) NOT NULL,
    PRIMARY KEY(land_id),
    FOREIGN KEY(homestead_id) REFERENCES locations(location_id)
);

CREATE TABLE power_provider (
	provider_id INT UNIQUE NOT NULL,
    homestead_id INT NOT NULL,
    common_name VARCHAR(50) NOT NULL,
    rate_kwh DECIMAL(3, 2) NOT NULL,
    energy_tax DECIMAL(3, 2) NOT NULL,
    website VARCHAR(250) NOT NULL,
    PRIMARY KEY(provider_id),
    FOREIGN KEY(homestead_id) REFERENCES locations(location_id)
);