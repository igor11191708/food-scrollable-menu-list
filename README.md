# Auto scrollable header menu (SwiftUI)

## Features
- [x] Auto scroll menu while navigating the list
- [x] The menu and category color intensity automatically adjusts depending on color scheme 
    You don't need to set color for every scheme
- [x] Various strategy for the item menu width allocation
- [x] Setting custom colors for the menu
- [x] Customize menu item style [round or square]
- [x] iOS and macOS support
- [x] Dark and light scheme support

## Required

### 1. Enum
Define enum that is category for menu conforming to ```IMenuItem```

```Swift 
    enum MenuItems: String, IMenuItem {

        case breakfast = "Breakfast"        
        case lunch = "Lunch"        
        case dessert = "Dessert"
    }
```

### 2. Model 
That comforms to ```IListModel```
```Swift 
    struct ListModel : IListModel{
        
        let id = UUID()
        
        let category: MenuItems
        
        let title : String
    }
```

### 3. Template 
That is view for a list item
```Swift 
    struct ItemTpl: View {

        let item: ListModel

        var body: some View {
           Text(item.title)
           Divider().background(getColor).padding(.horizontal)
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


## Code example

Take a look on the example preview in [**ScrollableMenuListExample.swift**](https://github.com/The-Igor/d3-menu-bar/blob/main/Sources/d3-scrollable-menu-list/example/ScrollableMenuListExample.swift) or create a project, add the package and put **ScrollableMenuListExample()** in **ContentView()**
