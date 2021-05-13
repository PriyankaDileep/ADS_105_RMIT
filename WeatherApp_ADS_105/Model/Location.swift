

import Foundation
// Priya: Added codable equatable
struct Location: Codable, Equatable {
    var name: String
    var latitude: String
    var longitude: String
    //Priya: Added below code
    static func stored() -> Location? {
        guard let data = UserDefaults.standard.data(forKey: "cityName") else {
             return nil
        }
        return try? JSONDecoder().decode(Location.self, from: data)
    }

    var data: Data? {
        return try? JSONEncoder().encode(self)
    }
}

