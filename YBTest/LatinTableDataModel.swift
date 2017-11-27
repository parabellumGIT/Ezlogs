/// An example `BasicTableDataModel` that provides "lorem ipsum" text.
struct LatinTableDataModel: BasicTableDataModel {
    
    /// A collection of textual elements composed of a variable number of words that follow an initial "title" word.
    let data = [
        "Nunc iaculis posuere viverra pretium lacus imperdiet",
        "Ut viverra arcu non dapibus fermentum nec massa eu nulla tempor ullamcorper eu quis massa",
        "Donec nec turpis euismod vehicula nunc congue lorem quisque augue",
        "Nam elit interdum vestibulum lectus sit amet mollis est maecenas mattis varius eros non sagittis nisi",
        "Quisque commodo purus varius posuere donec finibus nisi ligula bibendum sodales"
    ]
    
    
    // MARK: - Basic Table Data Model
    
    /// The number of word groupings.
    var numSections: Int {
        return data.count
    }
    
    
    /// Returns the number of words in the requested `section`.
    func numItems(forSection section: Int) -> Int {
        return data[section].split(separator: " ").count - 1
    }
    
    
    /// Returns the title of the requested `section`.
    func title(forSection section: Int) -> String? {
        let index = data[section].index(of: " ")!
        return String(data[section].prefix(upTo: index))
    }
    
    
    /// Returns the `item`-indexed word within the requested `section`.
    func text(forSection section: Int, item: Int) -> String? {
        let items = data[section].split(separator: " ").map(String.init)
        return String(items[item + 1])
    }
}
