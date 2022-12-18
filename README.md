# Marvel Characters

Marvel characters demo app

## Summary
This repository provides a mobile application sources code developed by __Flutter__ for __Android__ and __ios__ devices. Contains The main page presents a list of Marvel Characters and The details page can be reached by clicking on each item.

### Official Marvel API documents : [Marvel Docs](https://developer.marvel.com/docs)

The __BloC__ pattern is used to develop this app. It is one of the most popular patterns to develop Flutter applications. It uses streams but I don't use them to avoid having a complex source but it helps a lot in big projects.

The __Repository__ pattern is used for data access logic, so the source code can be extended without any modification in old classes.

Below are some packages used in the source code :
- __go_router to navigating between screens__
- __flutter_i18next to simplify the i18n process__
- __get_it to handle dependency injection__
- __dio to HTTP requests__
- __flutter_bloc to implement BloC pattern__

and some other packages to make development faster and easier. This set of packages does not mean they are the best, but likes, Pub points and popularity state that they are used in many projects and do their responsibilities.

The source code contains __Unit tests__ for logical parts of it.

The UI could be improved, but due to logical importance and lack of time, I decided to focus on the logic.

In the end, it takes about 24 hours(about 6 hours per a day) to analyze, plan and develop this app and I'm open to receiving comments about how can I make the source code better.

## Tested Environments
- MacOS Monterey
    - Android studio Chipmunk
    - Flutter 3.3.8
    - various ios simulators
    - various Android emulators

- Windows 10
    - Android studio Dolphin
    - Flutter 3.3.0
    - various Android emulators


## Contact
Email : [Mahdi.Mansournia@gmail.com](mahdi.mansournia@gmail.com)
