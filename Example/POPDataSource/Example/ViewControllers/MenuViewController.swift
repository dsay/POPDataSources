import UIKit
import POPDataSource

class MenuViewController: UITableViewController {
    
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
                
            default:
                fatalError("not implemented")
            }
        }
    }
    
}
