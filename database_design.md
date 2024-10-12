## Database  
**Pseudo-code Notes**  
- Assume NOT NULL unless otherwise specified.  
**Database Structure** - The database is based on counties and points of interest.  
- Counties encompass places to live and have some identifying information.  
- Points of interest encompass plots of land or helpful resources.  
- Resource points of interest should link to a land plot in a separate table.  
- Most other tables should link to a county.  
### Counties  
**Purpose** - Store data relating to counties.  
**Attributes**  
- county_id          : INT UNIQUE          - The unique identifier of a county  
- county_name        : VARCHAR(32)         - The name of a county  
- state              : VARCHAR(32)         - The state the county is in  
### Points of Interest  
**Purpose** - Store locational data for land plots and resources.  
- Resources may include feed/hardware stores, gas stations, farmers markets, etc.  
**Attributes**  
- poi_id             : INT UNIQUE          - The unique identifier of a point of interest  
- county_id          : INT                 - The identifier of a county from Counties  
- name               : VARCHAR(32)         - The name of the point of interest  
- poi_type           : VARCHAR(32)         - Short descruption of the point of interest  
- address            : VARCHAR(64)         - The address of the point of interest  
- zip                : CHAR(5)             - The zip code of the point of interest  
- lat                : DECIMAL(9, 6)       - For map plotting  
- lon                : DECIMAL(9, 6)       - For map plotting  
- notes              : VARCHAR(250)        - Notes on point of interest  
### Location Connections
**Purpose** - Link points of interest with each other.  
- Meant to connect resources to land plots.  
**Attributes**  
- connection_id      : INT UNIQUE          - The unique identifier of a location connection  
- homestead_id       : INT                 - The identifier of a land plot from Points of Interest  
- poi_id             : INT                 - The identifier of a resource from Points of Interest  
- distance_miles     : DECIMAL(3, 1)       - The distance between locations in miles  
- distance_minutes   : INT                 - The number of minutes to travel between locations  
