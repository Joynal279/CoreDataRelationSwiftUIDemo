//
//  ContentView.swift
//  CoreDataRelationSwiftUIDemo
//
//  Created by Joynal Abedin on 4/3/23.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    @State var name: String = ""
    @State var quantity: String = ""
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(entity: Product.entity(), sortDescriptors: [NSSortDescriptor(key: "name", ascending: true)])
    private var products: FetchedResults<Product>
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Product name", text: $name)
                TextField("Product quantity", text: $quantity)
                
                HStack {
                    Spacer()
                    Button("Add") {
                        addProduct()
                    }
                    Spacer()
                    //search product
                    NavigationLink(destination: ResultsView(name: name, viewContext: viewContext)) {
                        Text("Find")
                    }
                    Spacer()
                    Button("Clear") {
                        name = ""
                        quantity = ""
                    }
                    Spacer()
                }
                .padding()
                .frame(maxWidth: .infinity)
                
                List {
                    ForEach(products) { product in
                        HStack {
                            Text(product.name ?? "Not found")
                            Spacer()
                            Text(product.quantity ?? "Not found")
                        }
                    }
                    .onDelete(perform: deleteProduct)
                }
                .navigationTitle("Product Database")
            }
            .padding()
            .textFieldStyle(RoundedBorderTextFieldStyle())
        }
    }
    
    //Add product
    private func addProduct(){
        withAnimation {
            let product = Product(context: viewContext)
            product.name = name
            product.quantity = quantity
            saveContext()
        }
    }
    
    //Save Product
    private func saveContext(){
        do {
            try viewContext.save()
        } catch let error {
            fatalError("An error occured \(error)")
        }
    }
    
    //Delete Product
    private func deleteProduct(offsets: IndexSet){
        withAnimation {
            offsets.map{ products[$0] }.forEach(viewContext.delete)
            saveContext()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
