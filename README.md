# Shopping Cart
<div style="text-align: center">
    <table>
        <tr>
            <td style="text-align: center">
                    <img src="https://github.com/Hugo-Coutinho/hg_shopping_cart/blob/master/assets/readme/gifs/Opening.gif?raw=true" width="200" height="350"/>
                </a>
            </td>            
            <td style="text-align: center">
                    <img src="https://github.com/Hugo-Coutinho/hg_shopping_cart/blob/master/assets/readme/gifs/Scrolling.gif?raw=true" width="200" height="350"/>
                </a>
            </td>            
            <td style="text-align: center">
                    <img src="https://github.com/Hugo-Coutinho/hg_shopping_cart/blob/master/assets/readme/gifs/Searching.gif?raw=true" width="200" height="350"/>
                </a>
            </td>            
        </tr>
        <tr>
            <td style="text-align: center">
                    <img src="https://github.com/Hugo-Coutinho/hg_shopping_cart/blob/master/assets/readme/gifs/Adding.gif?raw=true" width="200" height="350"/>
                </a>
            </td>            
            <td style="text-align: center">
                    <img src="https://github.com/Hugo-Coutinho/hg_shopping_cart/blob/master/assets/readme/gifs/Listing.gif?raw=true" width="200" height="350"/>
                </a>
            </td>            
            <td style="text-align: center">
                    <img src="https://github.com/Hugo-Coutinho/hg_shopping_cart/blob/master/assets/readme/gifs/Killing.gif?raw=true" width="200" height="350"/>
                </a>
            </td>            
        </tr>
        <tr>
            <td style="text-align: center">
                    <img src="https://github.com/Hugo-Coutinho/hg_shopping_cart/blob/master/assets/readme/gifs/Bad_network.gif?raw=true" width="200" height="350"/>
                </a>
            </td>            
            <td style="text-align: center">
                    <img src="https://github.com/Hugo-Coutinho/hg_shopping_cart/blob/master/assets/readme/gifs/Retrying.gif?raw=true" width="200" height="350"/>
                </a>
            </td>            
            <td style="text-align: center">
                    <img src="https://github.com/Hugo-Coutinho/hg_shopping_cart/blob/master/assets/readme/gifs/bad_request.gif?raw=true" width="200" height="350"/>
                </a>
            </td>            
        </tr>
    </table>
</div>



## About this Project

The idea of the App is:

" *To provide an easy way to create the shopping cart, just need click on the representing icon of what to want to buy. Simple as that!* ".


## Why?

This project is part of my personal portfolio, so, I'll be happy if you could provide me any feedback about the project, code, structure or anything that you can report that could make me a better developer!

Email-me: hugocoutinho2011@gmail.com

Connect with me at [LinkedIn](https://www.linkedin.com/in/hugo-coutinho-aaa3b0114/).

Also, you can use this Project as you wish, be for study, be for make improvements or earn money with it!
It's free!



## Some Observations about this App

1 - There's no functionality of Login/Register, i don`t feel necessity to create one.



## Clean Architecture & Flutter

More important than the dependency flow - data & call flow. Of course, this is only a high-level overview. i will apply this diagram to the shopping cart app.

<div align="center">
<img src="https://github.com/Hugo-Coutinho/hg_shopping_cart/blob/master/assets/readme/Clean-Architecture-Flutter-Diagram.png?raw=true"/>
</div>

### Presentation
Note that the "Presentation Logic Holder" (Bloc) doesn't do much by itself. It delegates all its work to use cases. The presentation layer handles basic input conversion and validation.

### Domain
Domain it will contain only the core business logic (use cases) and business objects (entities). It should be totally independent of every other layer. 

***Use Cases*** are classes which encapsulate all the business logic of a particular use case of the app.   

So, you are must having questions and asking me something like:

 " *But... How is the domain layer completely independent when it gets data from a Repository, which is from the data layer?* "
And for answer it, i need to explain the letter ***D*** on the ***solid principles*** " *dependency inversion* "

<div align="center">
<img src="https://github.com/Hugo-Coutinho/hg_shopping_cart/blob/master/assets/readme/DIPLayersPattern.png?raw=true"/>
</div>

In object-oriented design, the dependency inversion principle is a specific form of decoupling software modules.

***The principle states:***

***A.*** *High-level modules should not depend on low-level modules. Both should depend on abstractions (usually using the interfaces).*

***B.*** *Abstractions should not depend on details. Details (concrete implementations) should depend on abstractions.*


Knowing that now, backing to the my app Architecture, ***Repository*** is the way of saying that we create an abstract Repository class defining a contract of what the Repository must do. This goes into the ***domain layer***. We then depend on the Repository " *contract* " defined in domain, knowing that the actual implementation of the Repository in the data layer will fullfill this contract.

<div align="center">
<img src="https://github.com/Hugo-Coutinho/hg_shopping_cart/blob/master/assets/readme/domain-layer-diagram.png?raw=true"/>
</div>

### data 
The data layer consists of a Repository implementation (the contract comes from the domain layer) and data sources - one is usually for getting remote (API) data and the other for caching that data.

 Repository is where you decide if you return fresh or cached data, when to cache it and so on.
You may notice that data sources don't return Entities but rather Models. The reason behind this is that transforming raw data (JSON) into Dart objects requires some JSON conversion code. We don't want this JSON-specific code inside the domain Entities - what if we decide to switch to XML? Therefore, we create Model classes which extend Entities and add some specific functionality (toJson, fromJson).


## Consuming API

Using ***flatIcon*** api to request icons

A temporal authentication token is needed to validate the request.

```
http.post(Uri.encodeFull('https://api.flaticon.com/v2/app/authentication'), headers: {
      "Accept": "application/json"
    }, body: {
      "apikey": "b8d616c26924b27bb4dc3a4f4237d5cb0c24cdac"
    });
```

with a valid token, do the request

```
_client.get("https://api.flaticon.com/v2/items/icons?"),
        headers: {"Authorization": "GENERATED TOKEN"})  
```


Documentation [Here](https://developer.flaticon.com/documentation/index.html#icons)


## Structure folder

<div align="center">
<img src="https://github.com/Hugo-Coutinho/hg_shopping_cart/blob/master/assets/readme/App_file_structure.png?raw=true"/>
</div>

***Core:*** Responsable to hold all the app abstractions and leading with the external dependencies logic, creating a layer to take care of it.

***Pages:*** Hold the app pages. Each page need to follow the clean Architecture structure. data/domain/presentation

<div align="center">
<img src="https://github.com/Hugo-Coutinho/hg_shopping_cart/blob/master/assets/readme/App_test_file_structure.png?raw=true"/>
</div>

***Core*** Mock creation. With mock the unit test can be applied.

***Fixtures*** Hold a dart file responsable to get the data from json. Json file is the mock of the flaticon response.

***Pages*** Where the tests happens.



## INSTALLERS   

If you want to test the App, the installers are listed below:
Android .apk installer: ***Soon!***
iOS .ipa installer: ***Soon!***




## Functionalities
- Select items from home list, therefore creating a shopping cart
- Increment the item amount just clicking on the same icon item
- Search items by name
- Shopping Cart
	- Visualize the cart
	- Decrement of the item amount
	- Remove item
	- Clear all the items at once



## Getting Started

### Prerequisites

To run this project, you'll need to have a basic environment to run a Flutter App, that can be found [here](https://flutter.dev/docs/get-started/install).



### Installing

**Cloning the Repository**

```
$ git clone https://github.com/Hugo-Coutinho/hg_shopping_cart.git

$ cd hg_shopping_cart
```

**Installing dependencies**

```
$ flutter pub get
```



### Getting started with Flutter

This project is a starting point for a Flutter application.
A few resources to get you started if this is your first Flutter project:
- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)

- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

  

  For help getting started with Flutter, view they [online documentation](https://flutter.dev/docs), which offers tutorials, samples, guidance on mobile development, and a full API reference.



### Running

With all dependencies installed and the environment properly configured, you can now run the app:

List emulators

```
$ flutter emulators
```

now that you have the emulator id, then run 

```
$ flutter emulators --launch <emulator-id>
```





## Built With

- [get_it](https://pub.dev/packages/get_it) - This is a simple Service Locator. It can be used instead of InheritedWidget or Provider to access objects from your UI
- [flutter_bloc](https://pub.dev/packages/flutter_bloc) - Business Logic Component design pattern (state managment solution)
- [equatable](https://pub.dev/packages/equatable) - Simplify Equality Comparisons objects
- [dartz](https://pub.dev/packages/dartz) - Functional programming thingies
- [json_annotation](https://pub.dev/packages/json_annotation) - To create code for JSON serialization and deserialization
- [data_connection_checker](https://pub.dev/packages/data_connection_checker) - A pure Dart utility library that checks for an internet connection
- [http](https://pub.dev/packages/http) - Easy way to consume HTTP resources.
- [lottie](https://pub.dev/packages/lottie) - Lottie is a mobile library that parses Adobe After Effects animations exported as json with Bodymovin and renders them natively on mobile!
- [scoped_model](https://pub.dev/packages/scoped_model) - Easily way to pass a data Model from a parent Widget down to it's descendants. In addition, it also rebuilds all of the children that use the model when the model is updated
- [logger](https://pub.dev/packages/logger) - Small, easy to use and extensible logger which prints beautiful logs
- [hive](https://pub.dev/packages/hive) - Hive is a NoSQL lightweight fast key-value database written in pure Dart
- [mockito](https://pub.dev/packages/mockito) - Mock library for Dart inspired by Mockito
- [test](https://pub.dev/packages/test) - provides a standard way of writing and running tests in Dart



## Contributing

You can send how many PR's do you want, I'll be glad to analyse and accept them! And if you have any question about the project...

Email-me: hugocoutinho2011@gmail.com

Connect with me at [LinkedIn](https://www.linkedin.com/in/hugo-coutinho-aaa3b0114/)

Check my development techniques: [My personal study annotations](http://bloghugocoutinho.wordpress.com)

Thank you!




