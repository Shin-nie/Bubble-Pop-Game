//
//  BubblePopGameApp.swift
//  BubblePopGame
//
//  Created by Hang Vu on 8/4/2024.
//

import SwiftUI

@main
struct BubblePopGameApp: App {
    var body: some Scene {
        WindowGroup {
            //  PUT MENUVIEW TO NAVIGATE
            NavigationStack {
                MenuView()
            }
        }
    }
}
#Preview {
    NavigationStack {
        MenuView()
    }
}
