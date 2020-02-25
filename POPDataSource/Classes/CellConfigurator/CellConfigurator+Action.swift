import UIKit

public struct DataSource {
    
    public enum Action {
        case select
        case edit
        case delete
        case highlight
        case unhighlight
        case willDisplay
        case willDisplayHeader
        case willDisplayFooter
        case didDisplay
        case didDisplayHeader
        case didDisplayFooter
        case custom(String)
    }
}

extension DataSource.Action: Hashable, Equatable {
    
    public func hash(into hasher: inout Hasher) {
        var hashValue: Int {
            switch self {
            case .select: return 1
            case .edit: return 2
            case .delete: return 3
            case .highlight: return 4
            case .unhighlight: return 5
            case .willDisplay: return 6
            case .willDisplayHeader: return 7
            case .willDisplayFooter: return 8
            case .custom(let x): return 9 + x.hashValue
            }
        }
        hasher.combine(hashValue)
    }
    
    public static func ==(lhs: DataSource.Action, rhs: DataSource.Action) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
}
