import UIKit
import POPDataSource

class MenuViewController: UITableViewController {
    
    var hiddenCellIds: [String: IndexPath] = [:]
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationController = segue.destination as? TableViewController {
            switch segue.identifier! {
            case "showGenres":
                let dataSourceLoader: PagingDataSource.Loader = { result in
                    let deadlineTime = DispatchTime.now() + .seconds(3)
                    DispatchQueue.main.asyncAfter(deadline: deadlineTime) {
                        result(false, [AlbumsDataSource()])
                    }
                }
                let albums = AlbumsDataSource()
                let dataSource = PagingDataSource([albums], dataSourceLoader)
                destinationController.shim = TableViewDataSourceShim(dataSource)

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
//                albums.header?.on(.custom(Actions.Album.onSection)) {
//                    [weak controller = destinationController, unowned albums] (header, index) in
//                    if albums.open {
//                        controller?.tableView.collapse(albums)
//                    } else {
//                        controller?.tableView.expand(albums)
//                    }
//                }
                destinationController.shim = TableViewDataSourceShim(albums)
                
            case "showFilterable":
//                let composed = ComposedDataSource([createDataSource(destinationController: destinationController),
//                                                   createDataSource(destinationController: destinationController),
//                                                   createDataSource(destinationController: destinationController)])
                
                let composed = ComposedDataSource([])
                destinationController.shim = TableViewDataSourceShim(composed)
            default:
                fatalError("not implemented")
            }
        }
    }
    
    // MARK: - Filter logic

    
    func createDataSource(destinationController: TableViewController) -> AlbumsDataSource {
        let dataSource = AlbumsDataSource()
        
        dataSource.cellConfigurator?.on(.custom(Actions.Album.onButton)) { [weak dataSource, weak destinationController] cell, index, item in
            guard let ds = dataSource else { return }

            destinationController?.tableView.filter(ds, at: index.section) {
                dataSource?.toggleState(for: item, at: index)
            }
        }
        
        dataSource.header?.on(.custom(Actions.Album.onSection)) { [weak dataSource, weak destinationController] header, index in
            guard let ds = dataSource else { return }
            
            destinationController?.tableView.filter(ds, at: index) {
                dataSource?.showAll()
            }
        }
        return dataSource
    }
    
}

extension Album {
    
    var id: String {
        return "\(name)_\(artistName)"
    }
}

extension DataFilterable {
    
    func toggleState(for item: Item, at index: IndexPath) {
        if let index = hiddenItems.firstIndex(of: item) {
            hiddenItems.remove(at: index)
        } else {
            hiddenItems.append(item)
        }
    }
    
    func showAll() {
        hiddenItems.removeAll()
    }
}
