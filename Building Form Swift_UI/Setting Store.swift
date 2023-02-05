//
//  Display Order.swift
//  Building Form Swift_UI
//
//  Created by Macbook on 04/02/2023.
//

import Foundation
import Combine
enum DisplayOrderType : Int,CaseIterable {
    case alphabetical = 0
    case favouriteList = 1
    case checkInFirst = 2
    init(type : Int) {
        switch type {
        case 0:
            self = .alphabetical
        case 1:
            self = .favouriteList
        case 2:
            self = .checkInFirst
        default:
            self = .alphabetical
        }
    }
    var text : String {
        switch self {
        case .alphabetical:
            return "Alphabetial"
        case .favouriteList:
            return "Show Favourite First"
        case .checkInFirst:
            return "Show Check-in First"
        }
    }
    func predicate() -> ((Restaurant,Restaurant) -> Bool) {
        switch self {
        case .alphabetical:
            return { $0.name < $1.name }
        case .favouriteList:
            return { $0.isFavorite && !$1.isFavorite }
        case .checkInFirst:
            return { $0.isCheckIn && !$1.isCheckIn }
        }
    }
}

//Observable Object this is a protocol of combine framework when you declare a property as an enviroment object the type of that property must implement this protocol

final class SettingStore : ObservableObject {
   @Published var defaults : UserDefaults // @Published is a property wrapper that works along with ObservableObject, when a property is prefixed with @Published this inform that the publisher should inform all subscribers whenever the property's value is changed.
    init(defaults : UserDefaults = .standard) {
        self.defaults = defaults
        defaults.register(defaults: ["view.preferences.showCheckInOnly" : false,
                                     "view.preferences.displayOrder" : 0,
                                     "view.preferences.maxPriceLevel" : 5])
    }
    var showCheckInOnly : Bool {
        get {
            defaults.bool(forKey: "view.preferences.showCheckInOnly")
        }
        set {
            defaults.setValue(newValue, forKey: "view.preferences.showCheckInOnly")
        }
    }
    var displayOrder : DisplayOrderType {
        get {
            DisplayOrderType(type:defaults.integer(forKey: "view.preferences.displayOrder"))
        }
        set {
            defaults.setValue(newValue.rawValue, forKey: "view.preferences.displayOrder")
        }
    }
    var maxPriceLevel : Int {
        get {
            defaults.integer(forKey: "view.preferences.maxPriceLevel")
        }
        set {
            defaults.setValue(newValue, forKey: "view.preferences.maxPriceLevel")
        }
    }
}
