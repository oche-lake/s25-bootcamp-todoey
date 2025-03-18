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
    @State private var title = ""
    @State private var change = false
    @State private var updatecolor : Color = .yellow
    var body: some View {
        ZStack{
            Color.black
                .ignoresSafeArea()
            VStack(alignment: .leading){
                Text("Todoey")
                    .font(.system(size: 40))
                    .foregroundColor(updatecolor)
                    .bold()
                    .padding()
                List {
                    ForEach($todos) { $todo in
                        TodoRowView(todo: $todo)
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
        }
    }
    func remove(at offsets: IndexSet){
        todos.remove(atOffsets: offsets)
    }
    
}
struct TodoRowView : View{
    @Binding var todo: Todo
    var body: some View{
        HStack {
            Button(action: {todo.isDone.toggle()})
            {Image(systemName: todo.isDone ? "checkmark.circle.fill" : "circle")
                .foregroundColor(todo.isDone ? .yellow : .yellow)}
            TextField("Enter task", text: $todo.item)
                .foregroundColor(todo.isDone ? .gray : .white)
        }
    }
}
struct InfoView: View {
    @Binding var title: String
    @Binding var newcolor: Color
    let colors: [Color] = [.red, .green, .yellow, .blue, .orange, .purple]
    let rows = [GridItem(.fixed(50))]

    var body: some View {
        VStack {
            Image(systemName: "list.bullet.circle.fill")
                .foregroundColor(newcolor)
                .padding()
            TextField("Enter Title", text: $title)
                .padding()
            LazyHGrid(rows: rows, alignment: .center) {
                ForEach(colors, id: \.self) { color in
                    Button(action: {newcolor = color
                    }) {
                        Circle()
                            .fill(color)
                            .frame(width: 50, height: 50)
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
