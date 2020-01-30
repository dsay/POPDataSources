import UIKit

struct Artist {
    var name: String
    var id: Int
    
    var albums = [Album]()
    
    init(_ name: String, _ id: Int) {
        self.name = name
        self.id = id
    }
}

struct Genre {
    var name: String
    var albums = [Album]()
    
    init(_ genre: String) {
        self.name = genre
    }
}

struct Album {
    var name: String
    var releaseDate: Date
    var trackCount: Int
    var genre: String
    var artistName: String
    
    init(_ name: String, _ artistName: String, _ releaseDate: Date, _ trackCount: Int, _ genre: String) {
        self.name = name
        self.artistName = artistName
        self.releaseDate = releaseDate
        self.trackCount = trackCount
        self.genre = genre
    }
}

struct Parser {
    var fileURL: URL

    func parse() -> ([Album], [Artist])? {
        let data = try? Data(contentsOf: fileURL)
        var json: [[String : AnyObject]]? = nil
        do {
            json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? [[String : AnyObject]]
        } catch {
            json = nil
        }
        
        guard let parsed = json else {
            return nil
        }
        
        var albums = [Album]()
        var artists = [Artist]()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        
        for representation in parsed {
            let artist = Artist(representation["artistName"] as! String,
                                representation["artistId"] as! Int)
            artists.append(artist)
            
            let date = representation["releaseDate"] as! String
            let album = Album(representation["collectionName"] as! String,
                              representation["artistName"] as! String,
                              dateFormatter.date(from: date)!,
                              representation["trackCount"] as! Int,
                              representation["primaryGenreName"] as! String)
            albums.append(album)
        }
    
        return (albums, Array(Set(artists)))
    }
}

struct LedZeppelin {
    fileprivate static let parser: Parser = {
        let path = Bundle.main.url(forResource: "Albums", withExtension: "json")
        return Parser(fileURL: path!)
    }()
    
    fileprivate static let data = LedZeppelin.parser.parse()
    
    static let genres: [Genre] = {
        let genreNames = Set(LedZeppelin.data!.0.map { $0.genre })
        return genreNames.map { name -> Genre in
            var genre = Genre(name)
            genre.albums = LedZeppelin.data!.0.filter { $0.genre == name }
            return genre
        }
    }()
    
    static var artists: [Artist] {
        var artists = [Artist]()
        for artist in LedZeppelin.data!.1 {
            var artistWithAlbums = artist
            artistWithAlbums.albums = LedZeppelin.data!.0.filter { $0.artistName == artist.name }
            artists.append(artistWithAlbums)
        }
        
        return artists
    }
    
    static let albums: [Album] = {
        return LedZeppelin.data!.0
    }()
}

func ==(lhs: Album, rhs: Album) -> Bool {
    return (lhs.name == rhs.name) && (lhs.trackCount == rhs.trackCount) &&
        (lhs.genre == rhs.genre) && (lhs.artistName == rhs.artistName) &&
        (lhs.releaseDate == rhs.releaseDate)
}

extension Album: Hashable {
    
    var hashValue: Int {
        return self.artistName.hashValue ^ self.genre.hashValue ^ self.name.hashValue ^ self.releaseDate.hashValue ^ self.trackCount.hashValue
    }
}

func ==(lhs: Artist, rhs: Artist) -> Bool {
    return (lhs.name == rhs.name) && (lhs.id == rhs.id) && (lhs.albums == rhs.albums)
}

extension Artist: Hashable {
    
    var hashValue: Int {
        return self.name.hashValue ^ self.id.hashValue ^ self.albums.count.hashValue
    }
}
