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
- county_id                  : INT UNIQUE                  - The unique identifier of a county  
- county_name                : VARCHAR(32)                 - The name of a county  
- state                      : VARCHAR(32)                 - The state the county is in  
### Locations  
**Purpose** - Store locational data for land plots and resources.  
- Resources may include feed/hardware stores, gas stations, farmers markets, etc.  
**Attributes**  
- location_id                : INT UNIQUE                  - The unique identifier of a location  
- county_id                  : INT                         - The identifier of a county from Counties  
- name                       : VARCHAR(32)                 - The name of the location  
- location_type              : VARCHAR(32)                 - Short descruption of the location  
- address                    : VARCHAR(64)                 - The address of the location  
- zip                        : CHAR(5)                     - The zip code of the location  
- lat                        : DECIMAL(9, 6)               - For map plotting  
- lon                        : DECIMAL(9, 6)               - For map plotting  
- notes                      : VARCHAR(250)                - Notes on the location  
### Location Location  
**Purpose** - Link locations with each other.  
- Meant to connect resources to land plots.  
**Attributes**  
- connection_id              : INT UNIQUE                  - The unique identifier of a location connection  
- homestead_id               : INT                         - The identifier of a land plot from Locations  
- resource_id                : INT                         - The identifier of a resource from Locations  
- distance_miles             : DECIMAL(3, 1)               - The distance between locations in miles  
- distance_minutes           : INT                         - The number of minutes to travel between locations    
### Listng  
**Purpose** - Store land sale listings.  
**Attributes**  
- listing_id                 : INT UNIQUE                 - The unique identifier of a listing
- homestead_id               : INT                        - The identifier of a land plot from Locations  
- listing_price              : INT                        - The price of the listing  
- acreage                    : SMALLINT                   - The acreage of the listing  
- price_per_acre             : DECIMAL(6, 2) NULL         - Nullable because this value is calculated from price and acreage  
- listing_date               : DATE                       - The date the listing was created  
- days_on_market              : INT                         - Number of days this property has been on the market  
- water_access               : VARHCAR(25) NULL           - The type of water access (well, municipal, none)  
- well_count                 : TINYINT                    - The number of wells on the property  
- well_installable           : BOOLEAN                    - Whether or not drilling of new wells is allowed  
- water_features             : VARCHAR(50)                - Short description of property water features  
- zoning                     : VARCHAR(25)                - How the land is zoned  
- land_type                  : VARCHAR(25)                - Forest, farm, waterfront, etc.  
- parcel_number              : 
- land_use_resrtictions      : VARCHAR(250)               - (conservation, zoning ordinances)  
- septic_system              : BOOLEAN                    - Whether there is a septic tank on the property  
- septice_notes              : VARCHAR(50) NULL           - Condition and notes on septice tank, if applicable  
- electric_access            : VARCHAR(25) NULL           - The type of electrical access
- road_access                : VARCHAR(25)                - The type of road access
- structures                 : VARCHAR(250)               - The type and number of structures  
### Electric Provider
**Purpose** - Describe available electricity providers  
**Attributes**  
- provider_id
- 
### Electric Location
**Purpose** - Link electricity providers to locations in a many to many relationship.  
*Attributes**