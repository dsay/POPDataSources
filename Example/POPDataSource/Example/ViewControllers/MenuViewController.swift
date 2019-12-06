import UIKit
import POPDataSource

class MenuViewController: UITableViewController {
    
    var hiddenCellIds: [String: IndexPath] = [:]
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationController = segue.destination as? TableViewController {
            switch segue.identifier! {
            case "showGenres":
                destinationController.shim = TableViewDataSourceShim(GenresDataSource())
                
            case "showArtists":
                let dataSource = ComposedDataSource(LedZeppelin.artists)
                destinationController.shim = TableViewDataSourceShim(dataSource)
                
            case "showAlbums":
                let dataSource = AlbumsDataSource()
                
                dataSource.cellConfigurator?.on(.willDisplay) { cell, index, item in
                    print("tap on cell")
                }
                
                dataSource.cellConfigurator?.on(.custom(Actions.Album.onButton)) { cell, index, item in
                    print("tap on button in cell")
                }
                
                dataSource.header?.on(.custom(Actions.Album.onSection)) { header, index in
                    print("tap on button in section")
                }
                
                let composed = ComposedDataSource([dataSource, dataSource, dataSource])
                destinationController.shim = TableViewDataSourceShim(composed)
                
            case "showCollapsible":
                let albums = AlbumsDataSource()
                albums.header?.on(.custom(Actions.Album.onSection)) {
                    [weak controller = destinationController, unowned albums] (header, index) in
                    if albums.open {
                        controller?.tableView.collapse(albums)
                    } else {
                        controller?.tableView.expand(albums)
                    }
                }
                destinationController.shim = TableViewDataSourceShim(albums)
                
            case "showFilterable":
                let composed = ComposedDataSource([createDataSource(destinationController: destinationController),
                                                   createDataSource(destinationController: destinationController),
                                                   createDataSource(destinationController: destinationController)])
                destinationController.shim = TableViewDataSourceShim(composed)
            default:
                fatalError("not implemented")
            }
        }
    }
    
    // MARK: - Filter logic
    
    func toggleStateForAlbum(_ album: Album, at index: IndexPath) {
        let id = album.id
        if hiddenCellIds[id] == nil {
            hiddenCellIds[id] = index
        } else {
            hiddenCellIds[id] = nil
        }
    }
    
    func removeFromHiddenAll(in section: Int) {
        hiddenCellIds = hiddenCellIds.filter({ (_, index) -> Bool in
            return index.section != section
        })
    }
    
    func createDataSource(destinationController: TableViewController) -> AlbumsDataSource {
        let dataSource = AlbumsDataSource()
        
        dataSource.cellConfigurator?.on(.willDisplay) { cell, index, item in
            print("tap on cell")
        }
        
        dataSource.cellConfigurator?.on(.custom(Actions.Album.onButton)) { [weak self, weak dataSource, weak destinationController] cell, index, item in
            print("tap on button in cell")
            guard let ds = dataSource else { return }
            self?.toggleStateForAlbum(item, at: index)
            destinationController?.tableView.filter(ds, at: index.section)
        }
        
        dataSource.header?.on(.custom(Actions.Album.onSection)) { [weak self, weak dataSource, weak destinationController] header, index in
            print("tap on button in section header")
            guard let ds = dataSource else { return }
            self?.removeFromHiddenAll(in: index)
            destinationController?.tableView.filter(ds, at: index)
        }
        
        dataSource.filterAction = { [weak self] item in
            guard let sself = self else { return nil }
            let it = sself.hiddenCellIds[item.id] == nil ? item : nil
            return it
        }
        dataSource.filter()
        return dataSource
    }
    
}

extension Album {
    
    var id: String {
        return "\(name)_\(artistName)"
    }
    
}
