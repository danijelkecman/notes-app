//
//  ContentView.swift
//  Notes
//
//  Created by Danijel Kecman on 11/20/22.
//

import SwiftUI

struct Home: View {
  @State var notes = [Note]()
  @State var showAddNote = false
  
  var body: some View {
    NavigationView {
      List(self.notes) { note in
        Text(note.note)
          .padding()
      }
      .sheet(isPresented: $showAddNote, content: {
        AddNoteView()
      })
      .onAppear(perform: {
        fetchNotes()
      })
      .navigationTitle("Notes")
      .navigationBarItems(trailing: Button(action: {
        self.showAddNote.toggle()
      }, label: {
        Text("Add")
      }))
    }
  }
  
  func fetchNotes() {
    guard let url = URL(string: "http://localhost:3000/notes") else { return }
    
    let task = URLSession.shared.dataTask(with: url) { data, res, err in
      guard let data else { return }
      
      do {
        let notes = try JSONDecoder().decode([Note].self, from: data)
        self.notes = notes
      } catch {
        print(error)
      }
    }
    task.resume()
  }
}

struct Note: Identifiable, Codable {
  var id: String { noteId }
  var noteId: String
  var note: String
  
  enum CodingKeys: String, CodingKey {
    case noteId = "_id"
    case note
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    Home()
  }
}
