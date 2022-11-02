# RecipeAppChallenge
Recipe application challenge.

## `Execution Guide`
1. git clone git@github.com:Sgiraldo10/RecipeAppChallenge.git
2. cd RecipeAppChallenge
3. pod install
4. open workspace: EmpowermentsLabsChallenge.xcworkspace

## `Environment stack`
- iOS SDK  14
- Swift 5.0
- Xcode 13.4.1
- CocoaPods 1.10.1

## `Architecture`
 Used architecture was a mix between MVP + Clean Architecure concepts + Coordinator Pattern for navigation + Modular.
 [Reference to MVP + Clean Architecture](https://medium.com/tiendeo-tech/ios-mvp-clean-architecture-in-tiendeo-app-a8a597c49bb9)

 ### Architecture Diagram:

 <img width="703" alt="Screen Shot 2022-11-02 at 2 11 52" src="https://user-images.githubusercontent.com/47761311/199423833-1d277bf9-a773-427f-a8fd-e7bf4801f847.png">

 
 
 There are 3 basic modules:
 1. Network Module: Has all refered to networking. 
 2. Core Module: Has all referd to shared resources such as: Bases and reusable code. 
 3. Main Module: 
      - Has all about the differents modules to being showed: Sush as List and Detail views. 
      - Has is own layer architecture based on Clean Architecture: Data, Domain and Presentation layers.
      - Presentation layer apply the MVP architecture to interact between entities. 
      - Coordinator patter which is in charge of navigation. 

### Layer Architecture Diagram:

<img width="770" alt="Screen Shot 2022-11-02 at 2 12 14" src="https://user-images.githubusercontent.com/47761311/199423961-a7c34074-63b7-4c69-a5d6-daf63211516f.png">

## `Design Patterns, OOP Concepts & Good Programming Practices` 
  * UseCases.
  * Repository.
  * Modules.
  * Low copling.
  * SOLID Principles.
  * Dependency Injection.
  * Inversion of control.
  * Inheritance.
  * Coordinator pattern.
  * Views by code.
  * Generics.

## `Features`

### Proxy Screen:

Initial screen to make whatever logic that the app require before to show something. Is used to create some required entities as well.

### Error Handler:

All error are handled and the code is open to allow custom the message in the Domain Module to avoid the ncessity to do it in Presentation Layer. Actually there is a `InterfaceError` that allow pass a custom message wich is showed to de user.

Error handler is created to allow scale how errors are showed to the user. 


### Pagination:

Recipe challenge allow infinite scroll to fetch more information. 


### Unitary Test:

Unitary test has being developed unider Test Stunt / Test Double methodology wich allow to run all test in a local environment.
This methodology is based on five entities:

1. Stub -> Used.
2. Spy -> Used.
3. Fake -> Not used.
4. Mock -> Not used.
5. Dummy -> Not used.

To more information: 
- [Article from Martin Fowler](https://martinfowler.com/bliki/TestDouble.html)
- [Platform XUnitPatterns](http://xunitpatterns.com/Test%20Double.html)


## `Drawbacks`
- Test combine async code.
  There´s a class called: BaseUseCase wich is used to make an abstraction about UseCase Patter. As the usecase code could be done in background treaths in   an async way I decided to use Combine Framework. 
  
  Combine has a method called: receive(on: Scheduler), in that escenary we put DispatchQueue.main as a Scheduler. So far all looks fine. 

  Where the problems come up? When we want to do Unitary Test. Async test is more complicated that sync test. 
  So when I was doing the unitary test for UseCases this become in a problem, because test are in a sync way and arrive to the BaseUseCase wich handle it     with in a background treath, this made that unitary test fail.

  The solution at the end was to create a TestableBaseUseCase that override and change the DispatchQueue.man to ImmediateScheduler.shared. :white_check_mark:

  I tried another approach much more easy: Inject the Scheduler but, Scheduler is a Protocol with associated types and not allow to did it.

- Crash appliying pagination.
  
  To allow apply pagination we need to keep the first set of data while we request another set. This look fine when we are goint for different data, but I   made an error because if the user search the same recipe then the request will bring the same data and as I was using Diffables to handle Collection       data, then the UIID that I was passing to the datasource was the id of the products, and how those were repeted then app crash by same UUID in Diffable     datasource.
