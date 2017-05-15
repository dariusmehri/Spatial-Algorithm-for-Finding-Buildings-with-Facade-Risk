Structurally comprised building facades can be dangerous to New York City residents. Every year dozens of incidents of material falling from facades are reported to the Department of Buildings. Building owners who own buildings considered high risk (higher than 6 floors) are required to provide evidence their building facade is meeting the safety standards according to the Façade Inspection and Safety Program. However, many buildings that should comply with this law are unknown to the DOB.
With Christian Camiolo, I developed an algorithm in Python that mined archival data from the early 20th century to find these buildings.  The dataset was composed of easements and addresses that were mined, cleaned and then validated as to whether they still exist. In addition, the dataset contained the original owner and architect, and information about the materials used in the building. This additional data could be used to develop a risk model to predict unsafe facades.

### Data
This analysis incorporated three datasets. The archival data from the Office of Metropolitan History, the PLUTO dataset and NYC street intersection latitude and longitude coordinates. 

### Easements
The major technical challenge was finding addresses based on easements (before the building had an official address) and matching addresses created in the early 20th century with current addresses.
Easements posed a challenge because they did not contain the address, but a location from an intersection, for example, many had this format:

114th st, s s, 150 e Manhattan av

This easement states that there is an address on the south side of 114th street, 150 feet east of the intersection with Manhattan Avenue. The technical challenge is to find the current address from this easement. 


### Algorithm for Easements
1.	Clean and transform data.
2.	Extract the historical street and avenue, east/west direction, and whether south side or north side.
3.	Use the historical street and avenue data to subset the PLUTO dataset into 4 blocks (Northeast, Northwest, Southeast and Southwest)
4.	Use the direction (east or west) and the lat/lon coordinates to subset the data into two blocks (east or west blocks). 
5.	Use the south side/north side indicator to subset the data into a single north or south side block.
6.	Use the PLUTO dataset to count the number of feet from the corner of the block until a building is found (i.e. is there  a building on the south side of 114th street, 150 feet east of Manhattan Ave?)
7.	When a building is found, pull the address from the PLUTO dataset and validate using an error function and current building characteristics.

### Algorithm for Addresses
1.	Inspecting and cleaning of initial archival dataset by identifying data patterns and using fuzzy logic to map archival to current addresses.
2.	Drawing comparisons between multiple datasets to validate addresses.
3.	Creating a map to show addresses found from the archival dataset compared to currently known addresses.


### Results
The algorithm categorized the easements into categories of existence. This included “exists”, “probably demolished” and “unknown.” Out of 2110 easements processed, 875 (41.5%) were likely to exist while 1235 (58.5%) were probably demolished.

An interactive map with address popups was created using the R Leaftlet package that generates maps and automatically exports in D3 (see folder). Images of the map are shown below, as can be seen, the highest density of buildings that "exist" are located in the Washington Heights region of the City, and the lowest is located in lower Manhattan:

![capture wash heights](https://cloud.githubusercontent.com/assets/11237613/26074385/a3bf09f6-397f-11e7-8692-dd703754226f.PNG)

