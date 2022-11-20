//
//  ContentView.swift
//  Notes
//
//  Created by Danijel Kecman on 11/20/22.
//

import SwiftUI

struct Home: View {
  var body: some View {
    NavigationView {
      List(0..<9) { index in
        Text("we are at \(index)")
          .padding()
      }
      .navigationTitle("Notes")
      .navigationBarItems(trailing: Button(action: {
        print("Add a note")
      }, label: {
        Text("Add")
      }))
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    Home()
  }
}
