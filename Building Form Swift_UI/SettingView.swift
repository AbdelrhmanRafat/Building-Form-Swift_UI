//
//  SettingView.swift
//  Building Form Swift_UI
//
//  Created by Macbook on 01/02/2023.
//

import SwiftUI

struct SettingView: View {
    private var displayOrders = ["Alphabetical", "Show Favorite First", "Show Check-in First"]
    @State private var SelectedOrder = 0
    @State private var showCheckInOnly = false
    @State private var maxPriceLevel = 5
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Sort Prefrence")){
                    Picker(selection: $SelectedOrder, label: Text("Display order")){
                        ForEach(0..<displayOrders.count, id : \.self) {
                            Text(self.displayOrders[$0])
                        }
                    }
                }
                Section(header: Text("Filter Prefrence")){
                    Toggle(isOn: $showCheckInOnly){
                        Text("Show Check-in Only")
                    }
                    Stepper(
                        onIncrement: {
                            if self.maxPriceLevel >= 5 {
                                self.maxPriceLevel = 5
                            }
                            else {
                                self.maxPriceLevel += 1
                            }
                        },
                        onDecrement: {
                            if self.maxPriceLevel <= 1 {
                                self.maxPriceLevel = 1
                            }
                            else {
                                self.maxPriceLevel -= 1
                            }
                        })
                    {
                        Text("Show \(String(repeating: "$", count: maxPriceLevel)) or below")
                    }
                }
            }
            .navigationTitle("Settings")
        }
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}
