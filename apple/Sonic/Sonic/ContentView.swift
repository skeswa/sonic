//
//  ContentView.swift
//  Sonic
//
//  Created by Sandile Keswa on 10/8/22.
//

import HealthKit
import SwiftUI

struct ContentView: View {
  private let healthStore = HKHealthStore()
  private let objectTypes: Set<HKObjectType> = [
    HKObjectType.activitySummaryType()
  ]
  
  var body: some View {
    VStack(alignment: .leading, spacing: 4.0) {
      Button("Do the thing") {
        healthStore.requestAuthorization(toShare: nil, read: objectTypes) { (success, error) in
          if success {
            print("OK it works I think")
            
            let calendar = Calendar.autoupdatingCurrent
            
            var dateComponents = calendar.dateComponents(
              [ .year, .month, .day ],
              from: Date()
            )
            
            // This line is required to make the whole thing work
            dateComponents.calendar = calendar
            
            let predicate = HKQuery.predicateForActivitySummary(with: dateComponents)
            
            let query = HKActivitySummaryQuery(predicate: predicate) { (query, summaries, error) in
              
              guard let summaries = summaries, summaries.count > 0
              else {
                print("Hmmmm")
                dump(summaries?.count)
                dump(error)
                // No data returned. Perhaps check for error
                return
              }
              
              // Handle the activity rings data here
              print("Yeahboi")
              dump(summaries)
            }
            healthStore.execute(query)
          }
        }
      }
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
