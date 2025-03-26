// ContentView.swift
// penn-dining-hunt
//
// Created by Michelle Chang on 3/14/25.
//

import SwiftUI
import CoreLocation


struct ContentView: View {
    @EnvironmentObject var diningHallViewModel: DiningHallViewModel  // Use EnvironmentObject for shared state

    var body: some View {
        NavigationStack {
            List {
                ForEach(diningHallViewModel.diningHalls) { (diningHall: DiningHall) in
                    NavigationLink(destination: DiningHallView(diningHall: diningHall)) {
                        HStack {
                            Image(diningHall.image)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 60, height: 60)
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                            
                            VStack(alignment: .leading) {
                                Text(diningHall.name)
                                    .font(.headline)
                                Text(diningHall.description)
                                    .font(.subheadline)
                                    .lineLimit(1)
                                    .truncationMode(.tail)
                            }
                            
                            Spacer()
                            
                            if diningHallViewModel.isCollected(diningHall) {
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundColor(.green)
                                    .font(.title2)
                            } else {
                                Image(systemName: "circle")
                                    .foregroundColor(.gray)
                                    .font(.title2)
                            }
                        }
                        .padding(.vertical, 8)
                    }
                }
            }
            .navigationTitle("Penn Dining Hunt")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Text("Collected: \(diningHallViewModel.progress())")
                        .font(.subheadline)
                        .padding(6)
                        .background(Color.blue.opacity(0.1))
                        .cornerRadius(8)
                }
            }
        }
    }
}

//// PreviewProvider for SwiftUI Preview
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//            .environmentObject(DiningHallViewModel())
//    }
//}
