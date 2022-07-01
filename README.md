# flutter_github_search


### App architecture pattern -> MVVM
<Model View ViewModel> ...
[Model:Holds backend logic,
 View:The user interface where all the visible views and animations are housed.
 This is the layer where users interacts with app like giving user input in this case.
 Viewmodel: It is the ui adapter/controller whic sits in between other two.
 In our case bloc plays the role as viewmodel. 
]

State Management System -> Bloc[Business logic component ...

This is a flutter application where an user can search for popular github repositories...
In case of 'Flutter' keyword The app will fetch top 50 flutter repositories
[based on total star count]from github api.

In the app the clean architecture is maintained...So there is  seperation concerns.
The app is mainly architected into three layers..

1.Data layer (consists of Remote data source,local data source,models and repositories

2.Domain layer (consists of Entities,Repository interface,Use cases)

3.Presentation layer (Bloc,views)

Dependency flow---------->>>>>>>>>>>>

Remote data source--> Local data source--> repositories--> Use cases --> Bloc --> UI  

### Mechanism:

When a user enters any input in the textfield it triggers the onTextChanged event of GithubSearch bloc...
The input is then recieved by use case from bloc which further sends the data to repository.
The rpository then invokes and pass the input remote data source
which is actually responsible for the http requests.Along with the given input it also sends some query parameter such as [sort,order,limit etc].
The limit is set to 50,with the ascending order based on star count as sort parameter.So we can achieve the top 50 most starred flutter
repositories with the given flutter keyword.

After every succesfull api call we get the Json response....In this phase offline caching mechanism takes place.
Whenever there is a new response it is cached by hive database(A lightweight fast NoSql database for flutter which 
stores values by key-value pair where key and value both are strings..In this case the key is set dynamically by user input that
is recieved at remote data source.and The json response received by corresponding user input is set to the corresponding key.
So Even if there is no internet It returns the cached json so no exception is thrown.

After that the json is decoded and converted into dart object models ... Finally the remote data source returns the list of objects that is recieved 
by repository...Which furthermore recieved by use cases.Finally The bloc recieves The result...Based on results The bloc emit new states to views.

If the result is not empty we get a list of repositories.


There is also a onRefreshApi event in the bloc which is implemented by Timer class..
With Timer.periodic()  we invoke the api after certain time.In this case 30 minutes.

Ther is also a sorting button in the home page which sorts the given repository list based on
last updated DateTime.

If user presses any of the repository list item...It will take him to corresponding repository details page where is 
able to see the information of repository owner and repository details.

### <<<<<<<<<<<<< Dependency injection>>>>>>>>>>>>>>>>

In stead of making the classes construct their dependencies directly I've used the <<<<<< service locator >>>>>>>>> design pattern 
where all the dependencies are registered in a centralized place in a method before the app starts.More specifically the method inside
service locator where all the dependencies are registered are called. before runApp() method...Then the dependencies are registered 
before starting the app unless it is registered lazily..In case of lazy singleton or lazy factory the dependencies are called when they are called.

Service locator hides the creation logic of instances and also facilitates unit testing...

We registerd the data sources , repositories and use cases as singletons so that it returns the existing instance everytime it is called 
which reduces memory complexity. But I've registered bloc as factory because registering it as singletons might invove a closed stream which
is disposed in the stateful widgets. 
