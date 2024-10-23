## Database Design US  
**Pseudo-code Notes**  
- Assume NOT NULL unless otherwise specified.  
**Database Structure** - The database is based on counties and property listings.  
- Counties references states  
- Cities reference counties  
- Listings reference counties and cities (nearest city)  
- Counties and states have tax profiles  
- Demographics, providers, and climate profiles apply to counties  
**Source Notes**  
- Sources that are not highlighted are able to provide data for all attributes in a table.  
- Highlighted sources are not complete or empty.  
### States  
**Purpose** - Store data relating to states.  
- Cost of living  
	- Average energy cost  
- Related tax profile  
**Notes**  
- States will not have a demographic profile b/c demographics vary greatly within states  
==**Source**==
**Attributes**  
- state_id                   : INT UNIQUE                  - The unique identifier of a state  
- tax_id                     : INT                         - The identifier of a tax profile  
- state_abbrev               : CHAR(2)                     - Two-letter abbreviation of the state  
- population                 : INT                         - Population of the state  
- mean_cost_of_living        : 
- mean_power_cost            : DECIMAL(3, 2)               - Mean energy cost per kWh  
- renewable_energy_%         : DECIMAL(4, 2)               - Percentage of power from renewable sources  
### Counties  
**Purpose** - Store data relating to counties.  
- Related tax profile  
- Related demographic profile  
- Many counties to one state  
**Notes**  
**Source** - United States Census Beureau  
- Homepage Link: https://www.census.gov/data/datasets/time-series/demo/popest/2020s-counties-total.html  
- Direct Download: https://www2.census.gov/programs-surveys/popest/tables/2020-2023/counties/totals/co-est2023-pop.xlsx  
- Download Type: .xlsx  
- Retreived: 10/12/2024  
**Attributes**  
- county_id                  : INT UNIQUE                 - The unique identifier of the county  
- tax_id                     : INT                        - The identifier of a tax profile  
- demographic_id             : INT                        - The identifier of a demographic profile  
- state_id                   : INT                        - The identifier of the state the county is in  
- climate_id                 : INT                        - The identifier of a climate profile  
- water_id                   : INT                        - The identifier of a water profile  
- county_name                : VARCHAR(32)                - Name of the county  
- area_square_miles          : INT                        - Area of the county in square miles  
### Cities  
**Purpose** - Store data relating to cities.  
- Many cities to one county  
**Notes**  
==**Source**==  
**Attributes**  
- city_id                    : INT UNIQUE                 - The unique identifier of a city  
- county_id                  : INT                        - The identifier of a county from counties  
- lat                        : DECIMAL(9, 6)              - For map plotting  
- lon                        : DECIMAL(9, 6)              - For map plotting  
- notes                      : VARCHAR(250)               - Notes on the city  
### Listngs  
**Purpose** - Store land sale listings.  
- Many listings to one county  
==**Source**==  
**Attributes**  
- listing_id                 : INT UNIQUE                 - The unique identifier of a listing  
- county_id                  : INT                        - The identifier of a county in counties  
- listing_price              : INT                        - The price of the listing  
- acreage                    : SMALLINT                   - The acreage of the listing  
- price_per_acre             : DECIMAL(6, 2) NULL         - Nullable because this value is calculated from price and acreage  
- listing_date               : DATE                       - The date the listing was created  
- days_on_market             : INT                        - Number of days this property has been on the market  
- water_access               : VARHCAR(25) NULL           - The type of water access (e.g., "Well", "Municipal", "None")  
- well_count                 : TINYINT                    - The number of wells on the property  
- well_installable           : BOOLEAN                    - Whether or not drilling of new wells is allowed  
- water_features             : VARCHAR(50)                - Short description of property water features  
- zoning_category            : VARCHAR(25)                - How the land is zoned (e.g., "Residential", "Commercial", "Agricultural")  
- zoning_code                : VARCHAR(25)                - Zoning code or ordinance identifier (e.g., "R-1" for single-family residential, "C-2" for commercial)  
- land_use_resrtictions      : VARCHAR(250)               - Short description of restrtictions (e.g., conservation, zoning ordinances)  
- septic_system              : BOOLEAN                    - Whether there is a septic tank on the property  
- septice_notes              : VARCHAR(50) NULL           - Condition and notes on septice tank, if applicable  
- electric_access            : VARCHAR(25) NULL           - The type of electrical access  
- road_access                : VARCHAR(25)                - The type of road access  
- structures                 : VARCHAR(250)               - The type and number of structures  
- address                    : VARCHAR(64)                - The address of the listing  
- zip                        : CHAR(5)                    - The zip code of the listing  
- lat                        : DECIMAL(9, 6)              - For map plotting  
- lon                        : DECIMAL(9, 6)              - For map plotting  
- nearest_hosptial_miles     : INT                        - Nearest hospital in miles  
- flood_zone                 : BOOLEAN                    - Whether the property is in a flood zone  
- fire_zone                  : BOOLEAN                    - Whether the property is in a fire hazard zone  
- notes                      : VARCHAR(250)               - Notes on the listing  
### Tax Profiles  
**Purpose** - Comprehensive tax summary for a state or county.  
- Any income tax  
- Any property tax  
- Any sales tax  
- Any other tax  
- One to one association (tax profiles to counties or states)  
==**Source**==  
**Attributes**  
- tax_id                     : INT UNIQUE                 - The unique identifier of a tax profile  
- income_tax_rate            : DECIMAL(4, 2)              - Percentage income tax  
- property_tax_rate          : DECIMAL(4, 2)              - Percentage property tax  
- sales_tax_rate             : DECIMAL(4, 2)              - Percentage sales tax  
- capital_gains_tax_rate     : DECIMAL(4, 2)              - Percentage capital gains tax  
- estate_tax_rate            : DECIMAL(4, 2)              - Percentage estate tax  
- inheritance_tax_rate       : DECIMAL(4, 2)              - Percentage inheritance tax  
- land_transfer_tax_rate     : DECIMAL(4, 2)              - Percentage land transfer tax  
- property_tax_cap           : BOOLEAN                    - Whether there is a cap on property tax increases  
### Incentives  
**Purpose** - Summary of any incentive offered in the area of an associated tax profile.  
- Renewable energy, work from home, tax writeoffs, etc  
- Links to a tax profile  
- Many incentives to one tax profile  
==**Source**==  
**Attributes**  
- incentive_id               : INT UNIQUE                 - The unique identifier of an incentive  
- tax_id                     : INT                        - The identifier of a tax profile from tax profiles  
- incentive_category         : VARCHAR(25)                - The category of the incentive  
- incentive_type             : VARCHAR(25)                - "Deduction" or "Tax Credit"  
- incentive_amount_type      : VARCHAR(15)                - "Percentage" or "Fixed Amount"  
- incentive_value            : DECIMAL(8, 2)              - Monetary value or percentage of the incentive  
- max_amount_claimable       : DECIMAL(8, 2)              - Maximum amount claimable under the incentive  
- incentive_application      : VARCHAR(25)                - Type of tax effected (e.g., "Income", "Property Tax")  
- eligibility_criteria       : VARCHAR(250)               - What's required to receive the incentive  
### Demographic Profiles  
**Purpose** - Comprehensive demographic profile for a given county.  
- Population statistics  
- Income and poverty statistics  
- Crime  
- Healthcare and life expectantcy  
- One demographic profile to one county  
==**Source**==  
**Attributes**  
- demographic_id             : INT UNIQUE                 - The unique identifier of a demographic profile  
- county_id                  : INT                        - The identifier of a county from counties  
- population                 : INT                        - Population of the demographic area  
- population_density         : DECIMAL(6, 2)              - Density of population per square mile  
- mean_age                   : INT                        - Mean age of the population  
- median_income              : INT                        - Median income of the population  
- median_home_value          : INT                        - Key indicator of property values  
- gender_ratio               : DECIMAL(3, 2)              - Ratio of men to women  
- poverty_rate               : DECIMAL(2, 2)              - Percentage of population living below the poverty line  
- homeless_rate              : DECIMAL(2, 2)              - Percentage of population without a home  
- unemployment_rate          : DECIMAL(2, 2)              - Percentage of population unemployed  
- high_school_education      : DECIMAL(2, 2)              - Percentage of population with a high school diploma  
- college_education          : DECIMAL(2, 2)              - Percentage of population with a college education  
- ethnicity_white            : DECIMAL(2, 2)              - Percentage of the population identifying as white  
- ethnicity_black            : DECIMAL(2, 2)              - Percentage of the population identifying as black  
- ethnicity_asian            : DECIMAL(2, 2)              - Percentage of the population identifying as asian  
- ethnicity_hispanic         : DECIMAL(2, 2)              - Percentage of the population identifying as hispanic  
- ethnicity_other            : DECIMAL(2, 2)              - Percentage of the population identifying as none of the above  
- violent_crime_rate_1000    : DECIMAL(4, 2)              - Number of violent crimes per 1000 residents  
- property_crime_rate_1000   : DECIMAL(4, 2)              - Number of property crimes per 1000 residents  
- emergency_response_time    : TINYINT                    - Average emergency response time in minutes  
### Electric Providers  
**Purpose** - Describe available electricity providers within a county  
- Any rates  
	- Average, min, max per kWh  
- Any incentives  
	- Renewable energy, leasing property for generation  
- Many providers to one county  
**Attributes**  
- provider_id                : INT UNIQUE                 - The unique identifier of a provider  
- county_id                  : INT                        - The identifier of a county from counties  
- provider_name              : VARCHAR(50)                - The name of the electric provider  
### Water Providers  
**Purpose** - Describe available water providers.  
- Many providers to one county  
==**Source**==  
**Attributes**  
- provider_id                : INT UNIQUE                 - The unique identifier of a water provider  
- county_id                  : INT                        - The identifier of a county from counties  
- provider_name              : VARCHAR(50)                - The name of the water provider  
### Internet Providers  
**Purpose** - Describe available internet providers.  
- Many providers to one county  
==**Source**==  
**Attributes**  
- provider_id                : INT UNIQUE                 - The unique identifier of an internet provider  
- county_id                  : INT                        - The identifier of a county from counties  
- provider_name              : VARCHAR(50)                - The name of the internet provider  
### Healthcare Providers  
**Purpose** - Describe available healthcare providers  
- Many providers to one county   
==**Source**==  
**Attributes**  
- provider_id                : INT UNIQUE                 - The unique identifier of a healthcare provider  
- county_id                  : INT                        - The identifier of a county from counties  
### Climate Profiles  
**Purpose** - Describe the climate of a county.  
- One climate profile to one county  
==**Source**==  
**Attributes**  
- climate_id                 : INT UNIQUE                 - The unique identifier of a climate profile  
- county_id                  : INT                        - The identifier of a county from counties  
### Water Profiles  
**Purpose** - Describe water access in a county.  
- Watershed data  
- Cost and availability of water  
- One water profile to one county  
==**Source**==  
**Attributes**  
- water_id                   : INT UNIQUE                 - The unique identifier of a water profile  
- county_id                  : INT                        - The identifier of a county from counties  
- average_water_cost         : DECIMAL(6, 2)              - Average cost of water per gallon  
- water_source_type          : VARCHAR(50)                - Type of water source (e.g., "Aquifer", "Reservoir", "River")  
- watershed_name             : VARCHAR(50)                - Name of the watershed servicing the area  
### Soil Profile  
**Purpose** - Describe soil quality in a county or listing.  
==**Source**==  
**Attributes**  
- soil_id                    : INT UNIQUE                 - The unique identifier of a soil profile  