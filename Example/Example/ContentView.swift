//
//  ContentView.swift
//  Example
//
//  Created by ky0me22 on 2025/10/21.
//

import Calculator
import SwiftUI

struct ContentView: View {
    @State var value: String = ""

    var body: some View {
        Calculator(value: $value)
            .border(Color.red)
            .padding()
    }
}

#Preview {
    ContentView()
}
