//
//  ContentView.swift
//  Todoey
//
//  Created by Ocean Chen on 3/11/25.
//

import SwiftUI

struct Todo: Identifiable {
    var id = UUID()
    var item: String
    var isDone = false
}

struct ContentView: View {
    @State private var todos: [Todo] = [
        Todo(item: "Clean the house", isDone: false)]
    @State var newtodo = ""
    @State private var title = "Todoey"
    @State private var change = false
    @State private var updatecolor : Color = .yellow
    var body: some View {
        ZStack{
            Color.black
                .ignoresSafeArea()
            VStack(alignment: .leading){
                HStack{
                    Text("\(title)")
                        .font(.system(size: 40))
                        .foregroundColor(updatecolor)
                        .bold()
                        .padding()
                    Spacer()
                    Button(action:{change = true }) {
                        Image(systemName: "info.circle")
                            .foregroundColor(updatecolor)
                            .font(.title)
                            .padding()
                    }
                }
                List {
                    ForEach($todos) { $todo in
                        TodoRowView(todo: $todo,newcolor: updatecolor)
                    }.onDelete(perform: remove)
                    .listRowBackground(Color.black)
                }.listStyle(.plain)
                    .font(.title3)
                Spacer()
                HStack{
                    Button(action:{
                        todos.append(Todo(item: newtodo , isDone: false))
                        newtodo = ""
                    })
                    {HStack{
                        Image(systemName: "plus.circle.fill")
                        Text("New Reminder")
                    }
                    .padding(.horizontal, 15)
                    }
                }
                .foregroundColor(updatecolor)
                .font(.title2)
            }
        }.sheet(isPresented: $change) {
            InfoView(title: $title, newcolor: $updatecolor)}
    }
    func remove(at offsets: IndexSet){
        todos.remove(atOffsets: offsets)
    }
    
}
struct TodoRowView : View{
    @Binding var todo: Todo
    var newcolor : Color
    var body: some View{
        HStack {
            Button(action: {todo.isDone.toggle()})
            {Image(systemName: todo.isDone ? "checkmark.circle.fill" : "circle")
                .foregroundColor(todo.isDone ? newcolor : newcolor)}
            TextField("Enter task", text: $todo.item)
                .foregroundColor(todo.isDone ? .gray : .white)
        }
    }
}
struct InfoView: View {
    @Binding var title: String
    @Binding var newcolor: Color
    let colors: [Color] = [.red, .orange, .yellow, .green,.cyan, .blue, .purple, .white]
    let rows = [GridItem(.fixed(80)),GridItem(.fixed(80))]
    
    var body: some View {
        ZStack{
            Color.black.opacity(0.8)
                .ignoresSafeArea()
            VStack{
                Image(systemName: "list.bullet.circle.fill")
                    .foregroundColor(newcolor)
                    .padding()
                    .font(.system(size:80))
                HStack{
                    Text("New Title: ")
                        .padding()
                    TextField("Enter Title", text: $title)
                        .padding()
                }.background(Color.gray, in: RoundedRectangle(cornerRadius: 8.0))
                LazyHGrid(rows: rows, alignment: .center) {
                    ForEach(colors, id: \.self) { color in
                        Button(action: {newcolor = color})
                        {
                        Circle()
                            .fill(color)
                            .padding(1)
                            
                            }
                        }
                    }
                }
                .padding()
            }
            
        }
    }

#Preview {
    ContentView()
}
