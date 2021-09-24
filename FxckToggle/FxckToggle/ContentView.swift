//
//  ContentView.swift
//  FxckToggle
//
//  Created by KAWRANTIN LE GOFF on 24/09/2021.
//

import SwiftUI

struct ContentView: View {
    @State private var keepData = true
    @State private var wantsPremium = false
    @State private var like = true
    
    var body: some View {
        VStack {
            Toggle("Can we keep your data?", isOn: $keepData)
                .toggleStyle(FxckToggleStyle())
            
            Toggle("Do you want premium features?", isOn: $wantsPremium)
                .toggleStyle(FxckToggleStyle())
            
            Toggle("Do you like this toggle?", isOn: $like)
                .toggleStyle(FxckToggleStyle())
        }
        .padding(.horizontal)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
