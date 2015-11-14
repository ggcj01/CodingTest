#Coding Assessment Guidelines

To validate a candidates skills in developing for mobile applications, we would like you to create a small application. We anticipate this challenge should take no more that 1-2 hours.

The task we would like you to complete is to create a basic app that makes a call to a weather (RESTful) web service, and display the data that is returned in the response on the screen of the mobile app, changing the interface (UI) according to the forecast being returned (clear, sunny, raining, etc.). The app only needs to make a single call at launch, and design skills are not being assessed. 

Some key elements we will be looking for in the application are:
*	Use of suitable design patterns, and a strict separation of concerns when developing a mobile application. 
*	UI interaction and data binding principals.
*	Management of User Interface.
*	Correct use of the application life cycle, management of the UI thread, and async development principals when displaying data and making network calls. 
*	Unit tests/mocks to demonstrate the code is testable. 

##Getting Started
*	Register for a free API key at: https://developer.forecast.io/
*	The API to query is https://api.forecast.io/forecast/{Your API key here}/{latitude},{longitude}. We would like you to obtain the geolocation using the API’s available from the mobile operating system. 
*	Submissions for the Android platform may only use third party libraries or open source code for the purpose of unit testing.
*	For other platforms the use of frameworks, libraries, and open-source code is allowed – but please reference their use in comments in the code. Please use package management for open source dependencies where suitable. 
*	When complete, please fork this repository, commit your code via the GIT tools, and send us a pull request. 

##About the Code

Contact
*   Joseph Lee @ joseph9413@hotmail.com

Project 3rd party pods used:
*   AFNetworking -> https://github.com/AFNetworking/AFNetworking 
*   Mantle -> https://github.com/Mantle/Mantle
*   MBProgressHUD -> https://github.com/jdg/MBProgressHUD

##Code Guide and Explanation 

Code Explanation
*   ForecastKit is the extraction of the forecast functionality. The ForecastMapView class handles all the map UI, locating user location, and retrieving/displaying of the forecast.
*   ForecastMapView allows delegation methods for customization using it's protocol

UI Explanation
*   GPS location and forecast preduction is automatically fetched when location services have been authorized
*   Refresh button at bottom right requests for forecast at current user location. It removes previous map forecast annotations

Concerns
*   The requirement was to launch a single call at application launch. However this didn't quite fit into the 'separation of concerns'. My application required locating the user's gps location and displaying a corresponding MapView UI when forecast has been retrieved. Fufilling this requirement and delegating coding in the AppDelegate did not make sense. 
