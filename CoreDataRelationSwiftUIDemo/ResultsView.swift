//
//  ResultsView.swift
//  CoreDataRelationSwiftUIDemo
//
//  Created by Joynal Abedin on 4/3/23.
//

import SwiftUI
import CoreData

struct ResultsView: View {
    
    var name: String
    var viewContext: NSManagedObjectContext
    @State var matches: [Product]?
    
    var body: some View {
        return VStack {
            List {
                ForEach(matches ?? []) { match in
                    HStack {
                        Text(match.name ?? "Not found")
                        Spacer()
                        Text(match.quantity ?? "Not found")
                    }
                }
            }
            .navigationTitle("Results")
        }
        .task { //This will ensure that search is performed asynchronously and that all of the view’s properties have been initialized before the search is executed.
            let fetchRequest: NSFetchRequest<Product> = Product.fetchRequest()
            
            fetchRequest.entity = Product.entity()
            fetchRequest.predicate = NSPredicate(format: "name CONTAINS %@", name)
            matches = try? viewContext.fetch(fetchRequest)
        }
    }
}

//struct ResultsView_Previews: PreviewProvider {
//    static var previews: some View {
//        ResultsView()
//    }
//}
