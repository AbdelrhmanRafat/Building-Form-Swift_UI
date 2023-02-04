//
//  Display Order.swift
//  Building Form Swift_UI
//
//  Created by Macbook on 04/02/2023.
//

import Foundation

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
}

final class SettingStore {
    var defaults : UserDefaults
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
