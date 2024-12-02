# Auto scrollable header menu - SwiftUI & Combine

[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fswiftuiux%2Ffood-scrollable-menu-list%2Fbadge%3Ftype%3Dplatforms)](https://swiftpackageindex.com/swiftuiux/food-scrollable-menu-list)

## Features
- [x] Auto scrollable up menu while navigating the list up and down
- [x] Navigate to any section from up menu
- [x] Smart detection the active position in the user's field of view
- [x] The menu and category color intensity automatically adjusts depending on color scheme 
    You don't need to set color for every scheme
- [x] Various strategies for the item menu width allocation
- [x] Setting custom colors for the menu
- [x] Customize menu item style [round or square]
- [x] Multiplatform
- [x] Dark and light scheme support

## Required

There are three **required interfaces** that have to be defined

| protocol | description |
| --- | --- |
| IMenuItem | enum - menu categories |
| IListModel | struct - list item model |
| IItemTpl | struct - item view template |

### 1. Enum
Define **enum** that conforming to ```IMenuItem```. Protocol from package **d3_menu_bar**
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
Define **model** that conforms to ```IListModel```.

Add fields that you need in the List line representation

```Swift 
    struct ListModel : IListModel{
        
        let id = UUID()
        
        let category: MenuItems
        
        let title : String
    }
```

### 3. Template 
Define **view** for **2. Model** that conforms to ```IItemTpl```.

All representation of the template is up to you. It was included in component's API on purpose to let easily control List representation via configuration.
```Swift 
    struct ItemTpl: IItemTpl {

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
* `items` - array of data
* `content` - tpl for an item representation

```Swift 
    let data: [ListModel] = //Pass array of data
    ScrollableMenuList(items: data, content: { ItemTpl(item: $0) })
```

## Optional

* `menuBarStrategy` - default strategy for the item menu width allocation is **auto**

| Size strategy | Description |
| --- | --- |
|**fit**| Allocate all affordable space **not scrollable**|
|**auto**| Auto size according the content |
|**flex(CGFloat)**| Set up minimal width|

* `menuBarColor` - default value is **.blue**

* `menuBarStyle` - default style is **square**

| Style | Description |
| --- | --- |
|**round**| rounded corners |
|**square**| squared corners |

[![click to watch expected UI behavior for the example](https://github.com/The-Igor/d3-scrollable-menu-list/blob/main/img/img.png)](https://youtu.be/D0BTNvkSG3U)
[![click to watch expected UI behavior for the example](https://github.com/The-Igor/d3-scrollable-menu-list/blob/main/img/scroll.gif)](https://youtu.be/D0BTNvkSG3U)
## Code example

Take a look on the example preview in [**ScrollableMenuListExample.swift**](https://github.com/The-Igor/d3-scrollable-menu-list/blob/main/Sources/d3-scrollable-menu-list/example/ScrollableMenuListExample.swift) or create a project, add the package and put **ScrollableMenuListExample()** in **ContentView()**

## Documentation(API)
- You need to have Xcode 13 installed in order to have access to Documentation Compiler (DocC)
- Go to Product > Build Documentation or **⌃⇧⌘ D**
