import POPDataSource

struct Actions {
    struct Album {
        static let onButton = "onButton"
        static let onSection = "onSection"
    }
}


struct GenresDataSource:
    TableViewDataSource,
    DataContainable,
    CellContainable,
    CellConfigurator,
    EditableCellDataSource,
    CellSelectable
{
    /**
     *  Data Containable protocol
     */
    var data: [Genre] = LedZeppelin.genres
    
    /**
     *  Setup Cell
     */
    func reuseIdentifier() -> String {
        return "genreAlbumCell"
    }
    
    var selectors: [DataSource
        .Action: (UITableViewCell, IndexPath, Genre) -> ()] = [:]
    
    func leadingActions() -> [EditAction] {
        return []
        
    }
    
    func trailingActions() -> [EditAction] {
        return [EditAction(action: .select, title: "Edit", color: .red, image: nil),
                EditAction(action: .edit, title: "Edit", color: .yellow, image: nil)]
    }
    
    func configurateCell(_ cell: UITableViewCell, item: Genre, at indexPath: IndexPath) {
        cell.textLabel?.text = item.name
        cell.detailTextLabel?.text = "\(item.albums.count) albums"
    }
}



extension Artist:
    TableViewDataSource,
    DataContainable,
    CellContainable,
    CellConfigurator,
    HeaderContainable,
    SectionConfigurator
{
    /**
     *  Data Containable protocol
     */
    var data: [Album] {
        return self.albums
    }
    
    /**
     *  Setup Section
     */
    func section() -> HeaderFooterView<EmptyView> {
        return .title(self.name)
    }
    
    /**
     *  Setup Cell
     */
    func reuseIdentifier() -> String {
        return "genreAlbumCell"
    }
 
    func configurateCell(_ cell: UITableViewCell, item: Album, at indexPath: IndexPath) {
        cell.textLabel?.text = item.name
        cell.detailTextLabel?.text = "\(item.trackCount) tracks"
    }
}

class AlbumsDataSource:
    TableViewDataSource,
    DataContainable,
//    Collapsible,
    CellContainable,
    HeaderContainable,
    DataFilterable
{
    /**
     *  Setup Collapsible protocol
     */
//    var open = true
    
    /**
     *  Setup Data Containable protocol
     */
    var data: [Album] = LedZeppelin.albums
    
    /**
     *  Section
     */
    var header: AlbumsSection? = AlbumsSection()
    
    /**
     *  Cell
     */
    var cellConfigurator: AlbumsCellConfigurator? = AlbumsCellConfigurator()
    
    /**
     *  Setup Data Filterable protocol
     */
    var hiddenItems: [Item] = []
}

struct AlbumsCellConfigurator: CellConfigurator, CellSelectable {
    /**
     *  Setup Selectors
     */
    var selectors: [DataSource
    .Action: (CustomeCell, IndexPath, Album) -> ()] = [:]

    /**
     *  Setup Cell
     */
    func reuseIdentifier() -> String {
        return "albumCell"
    }
    
    func configurateCell(_ cell: CustomeCell, item: Album, at indexPath: IndexPath) {
        cell.title?.text = item.name
        cell.button1?.actionHandle(.touchUpInside) { [unowned cell] in
            let selector = self.invoke(.custom(Actions.Album.onButton))
            selector?(cell, indexPath, item)
        }
    }
}

struct AlbumsSection: SectionConfigurator, SectionSelectable {
    /**
     *  Setup Selectors
     */
    var selectors: [DataSource
        .Action: (CustomeSection, Int) -> ()] = [:]

    /**
     *  Setup Section
     */
    func section() -> HeaderFooterView<CustomeSection> {
        return .view() { footer, index in
            footer.title!.text = "Section"
            footer.contentView.backgroundColor = .lightGray
            footer.button?.actionHandle(.touchUpInside) { [unowned footer] in
                let selector = self.invoke(.custom(Actions.Album.onSection))
                selector?(footer, index)
            }
        }
    }
}
