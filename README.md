# NYCSchoolsFinder Project Overview
This comprehensive project facilitates access to a wealth of information pertaining to New York City schools. 

<h3>Project Author</h3>
<h4>Yoonha Kim</h4>

### Application Features
The NYCSchoolsFinder application, developed utilizing the NYC Open Data API, offers users the capability to effortlessly load and browse through a compilation of New York City schools. Information is neatly organized and displayed within a table view, allowing users to easily interact with and select individual school entries for more detailed information.

### Key Functionalities:
Access to extensive school details including contact information, physical address, and official website.
Intuitive navigation from the general list of schools to specific school details and available SAT score data.
Direct links to Apple Maps for location guidance and to school websites for further exploration.

### Technical Specifications
API Utilization:
The application harnesses the NYC Open Data API to fetch and present up-to-date information regarding NYC schools, 
enriching the user experience with comprehensive data accessibility. Relevant API endpoints include:

General school information: <a href="https://data.cityofnewyork.us/resource/s3k6-pzi2.json">https://data.cityofnewyork.us/resource/s3k6-pzi2.json</a>
Specific school data (accessed using a unique dbnCode): <a href="https://data.cityofnewyork.us/resource/f9bf-2cp4.json?dbn=">https://data.cityofnewyork.us/resource/f9bf-2cp4.json?dbn=</a>


### Architectural and Development Approaches:
Model-View-ViewModel (MVVM) Architecture: Enhances the application's scalability and maintainability by separating the user interface from the business logic.  

Delegation Pattern: Facilitates communication between different components of the application, improving code manageability.  

UIKit: Provides a robust and versatile framework for designing intuitive user interfaces.  
Unit Testing: Ensures the reliability and stability of the application through rigorous testing protocols.  

### User Interface Descriptions
#### NYCSchoolList Screen
![Main](https://github.com/Ghostlun/NYCSchoolsChallenge/blob/master/ScreenGif/nycSchoolListScreen.gif)  

NYCSchoolList Screen: Presents a comprehensive list of NYC schools, from which users can select an institution to view more detailed information.  

#### NYCDetails Screen
![Details](https://github.com/Ghostlun/NYCSchoolsChallenge/blob/master/ScreenGif/nycSchoolDetailsScreen.gif)  

NYCSchoolDetails Screen: Displays in-depth information about the selected school, including SAT scores. Interactive elements allow users to directly access the school's location via Apple Maps or explore the school's official website for further information.  
