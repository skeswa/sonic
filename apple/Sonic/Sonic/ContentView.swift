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
          print("OK looks good", success)
            // Authorization request finished, hopefully the user allowed access!
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
