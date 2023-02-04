//
//  SettingView.swift
//  Building Form Swift_UI
//
//  Created by Macbook on 01/02/2023.
//

import SwiftUI

struct SettingView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var SelectedOrder = DisplayOrderType.alphabetical
    var settingStore : SettingStore
    @State private var showCheckInOnly = false
    @State private var maxPriceLevel = 5
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Sort Prefrence")){
                    Picker(selection: $SelectedOrder, label: Text("Display order")){
                        ForEach(DisplayOrderType.allCases, id : \.self) { orderType in
                            Text(orderType.text)
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
        // This will be loaded when the Setting View Appears.
        .onAppear{
            self.SelectedOrder = self.settingStore.displayOrder
            self.maxPriceLevel = self.settingStore.maxPriceLevel
            self.showCheckInOnly = self.settingStore.showCheckInOnly
        }
        .overlay(
            HStack {
                VStack {
                    Button(action: {
                        self.presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Text("Cancel")
                            .foregroundColor(.black)
                    })
                    .padding(.top,20)
                    .padding(.leading,10)
                    Spacer()
                }
                Spacer()
                VStack {
                    Button(action: {
                        self.settingStore.showCheckInOnly = self.showCheckInOnly
                        self.settingStore.displayOrder = self.SelectedOrder
                        self.settingStore.maxPriceLevel =
                            self.maxPriceLevel
                        self.presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Text("Save")
                            .foregroundColor(.black)
                    })
                    .padding(.top,20)
                    .padding(.trailing,10)
                    Spacer()
                }
            }
        )
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView(settingStore: SettingStore())
    }
}
