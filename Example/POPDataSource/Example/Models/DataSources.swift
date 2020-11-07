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
    
    var selectors: [Action: (TableViewCell, IndexPath, Genre) -> ()] = [:]
    
    func leadingActions() -> [EditAction] {
        return []
    }
    
    func trailingActions() -> [EditAction] {
        return [EditAction(action: .select, title: "Edit", color: .red, image: nil),
                EditAction(action: .edit, title: "Edit", color: .yellow, image: nil)]
    }
    
    func configurateCell(_ cell: TableViewCell, for tableView: UITableView, at indexPath: IndexPath, item: Genre) {
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
    
    func configure(_ section: EmptyView, for tableView: UITableView, at index: Int) {

    }
    /**
     *  Setup Cell
     */
 
    func configurateCell(_ cell: TableViewCell, for tableView: UITableView, at indexPath: IndexPath, item: Album) {
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
    var selectors: [Action: (CustomeCell, IndexPath, Album) -> ()] = [:]

    /**
     *  Setup Cell
     */
    
    func configurateCell(_ cell: CustomeCell, for tableView: UITableView, at indexPath: IndexPath, item: Album) {
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
    var selectors: [Action: (CustomeSection, Int) -> ()] = [:]

    /**
     *  Setup Section
     */
    func configure(_ section: CustomeSection, for tableView: UITableView, at index: Int) {
        section.title!.text = "Section"
        section.contentView.backgroundColor = .lightGray
        section.button?.actionHandle(.touchUpInside) { [unowned section] in
            let selector = self.invoke(.custom(Actions.Album.onSection))
            selector?(section, index)
        }
    }
}
