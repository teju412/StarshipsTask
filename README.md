# StarshipsTask
# Contents
- [Features](#features)
- [FolderStructure](#folder-structure)
- [ScreenShots](#screenshots)



# Features
- Load Collection  of starship from API - [Link to API](http://swapi.dev/api/starships)
- User can  able to “favourite” starships from both screens.
- user can  click on a starship to view more details about it.
- Used third-party libraries like Alamofire, PromiseKit, SwiftyGif
- if API call fails there be alert.


# Folder Structure

```
Starships
├─ Modules
│  └─ StarshipList
│     ├─ Cells
│     │  └─ StarshipTableViewCell
│     ├─ Views
│     │  └─ StarshipListViewController
│     ├─ ViewModel
│     │  ├─ StarshipListViewModel
│     └─ StarShipDetails
│     │    ├─ Views
│     │    │    ├─ StarshipDetailsViewController
│     │    └─ ViewModel
│     │           ├─ StarshipDetailsViewModel
│     ├─ ViewModel
│     │     ├─ StarshipsModel
│     ├─ Repositories
│           ├─ StarshipApiRepository
│ 
└─ Library
   ├─ Util
   │  └─ gif
   │      └─ Observable
   ├─ Constants
       └─ URL
   
```

# Screenshots

<img src="https://user-images.githubusercontent.com/18598946/141728226-f8278832-3656-47f0-8019-d45ba857af61.gif" width="300" height="600"/>

