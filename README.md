# Auto scrollable header menu - SwiftUI & Combine

## Features
- [x] Auto scroll menu while navigating the list up and down
- [x] Navigate to any section from up menu
- [x] Smart detection of the section position in the user's field of view
- [x] The menu and category color intensity automatically adjusts depending on color scheme 
    You don't need to set color for every scheme
- [x] Various strategies for the item menu width allocation
- [x] Setting custom colors for the menu
- [x] Customize menu item style [round or square]
- [x] iOS and macOS support
- [x] Dark and light scheme support

## Required

### 1. Enum
Define enum that conforming to ```IMenuItem```. Protocol from package **d3_menu_bar**
It is categories for the menu and list section headers

```Swift 
    import d3_menu_bar

    enum MenuItems: String, IMenuItem {

        case breakfast = "Breakfast"        
        case lunch = "Lunch"        
        case dessert = "Dessert"
    }
```

### 2. Model 
Define model that comforms to ```IListModel```.
Add fields that you need in the List line representation

```Swift 
    struct ListModel : IListModel{
        
        let id = UUID()
        
        let category: MenuItems
        
        let title : String
    }
```

### 3. Template 
Create view for **2. Model**
All representation of the template is up to you. It was included in component's API on purpose to let easily control List representation via configuration.
```Swift 
    struct ItemTpl: View {

        let item: ListModel

        var body: some View {
            VStack{
                Text(item.title)
                Divider()
            }.padding()
        }
    }
```

### 4. Create Auto scrollable header menu

```Swift 
    let data: [ListModel] = //Pass array of data
    ScrollableMenuList(items: data, content: { ItemTpl(item: $0) })
```

## Optional

* `menuBarStrategy` - default strategy for the item menu width allocation is **auto**

| Size strategy | Description |
| --- | --- |
|**fit**| Alocate all affodable space **not scrollable**|
|**auto**| Auto size acoording the content |
|**flex(CGFloat)**| Set up minimal width|

* `menuBarColor` - default value is **.black**

* `menuBarStyle` - default style is **round**

| Style | Description |
| --- | --- |
|**round**| rounded corners |
|**square**| squared corners |

[![click to watch expected UI behavior for the example](https://github.com/The-Igor/d3-scrollable-menu-list/blob/main/Sources/img/img.png)](https://youtu.be/D0BTNvkSG3U)
[![click to watch expected UI behavior for the example](https://github.com/The-Igor/d3-scrollable-menu-list/blob/main/Sources/img/scroll.gif)](https://youtu.be/D0BTNvkSG3U)
## Code example

Take a look on the example preview in [**ScrollableMenuListExample.swift**](https://github.com/The-Igor/d3-scrollable-menu-list/blob/main/Sources/d3-scrollable-menu-list/example/ScrollableMenuListExample.swift) or create a project, add the package and put **ScrollableMenuListExample()** in **ContentView()**
