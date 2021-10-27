# Weather Forecast Assigment - iOS - MVP + Clean Architecture

### Description
*Weather Forecast Assigment* is an iOS application built to highlight __MVP (Model View Presenter)__ and __Clean Architecture__ concepts

### Run Requirements

* Xcode 12+
* Swift 5

### High Level Layers

#### MVP Concepts
##### Presentation Logic
* `View` - delegates user interaction events to the `Presenter` and displays data passed by the `Presenter`
* `Presenter` - contains the presentation logic and tells the `View` what to present
* `Configurator` - injects the dependency object graph into the scene (view controller)
#### Clean Architecture Concepts
##### Application Logic

* `UseCase / Interactor` - contains the application / business logic for a specific use case in application
* `Entity` - plain `Swift` classes / structs

##### Gateways & Framework Logic

* `Gateway` - contains actual implementation of the protocols defined in the `Application Logic` layer
* `Persistence / API Entities` - contains framework specific representations

### Assignment Application Details
* Overview what I have to do in the assignment application:
  * Load data weather, display on view.
  * Check search input to make sure the keywords more than three characters berfore trigger search request.
  * Check if search request have from Cache (CoreData) before request to the server. This to prevent the request calling to the server at the same time with same request.
  * Make new search request to get newest data from server.
  * Hande error from server response.
  * Store the request & response to CoreData.  
  * Accessibility supports:
    * Scaling text if supported to change the font size.
    * The screen reader is enable by VoiceOver.   
* Following MVP-Clean Architecture, I have been written:
  * `WeatherPresenter` - Return weather data to display on screen, valid input,...
  * `SearchWeatherUserCase` - Referenced with `WeatherPresenter` to process the search weather by city name feature, it manipulates `Weathers Entity` and comunicates with `WeatherGateway` to retrive / persist the weathers entity.   
  * `WeatherGateway` - Implementation of the protocols defined from Use Cases layer.
    * `ApiWeatherGateway` - Using URLSession to request data from server.
    * `LocalPersitenceWeatherGateway` -  Using CoreData to fetch weather data storaged.
  * `Weather` entity - Contains specific representations, includes: `ApiWeatherRequest`, `ApiWeatherResponse`, `Weather Entity` from CoreData.

### ToDo
* Unit Tests
* UI Tests

### Check List
* [x] The application is a simple iOS application that is written by Swift.
* [x] The application is able to retrieve the weather information from OpenWeatherMaps API. 
* [x] The application is able to allow user to input the searching term.
* [x] The application is able to proceed searching with a condition of the search term length must be from 3 characters or above.
* [x] The application is able to render the searched results as a list of weather items.
* [x] The application is able to support caching mechanism so as to prevent the app from generating a bunch of API requests.
* [x] The application is able to manage caching mechanism & lifecycle.  
* [x] The application is able to handle failures.
* [x] The application is able to support the disability to scale large text for who can't see the text clearly
* [x] The application is able to support the disability to read out the text using VoiceOver controls.
