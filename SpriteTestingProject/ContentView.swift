//
//  ContentView.swift
//  SpriteTestingProject
//
//  Created by David Chung on 2025/11/7.
//

import SwiftUI
import SpriteKit

struct ContentView: View {
    var body: some View {
        GeometryReader { geometry in
            SpriteView(scene: {
                let scene = CatScene()
                scene.size = geometry.size    // ✅ 改這裡
                scene.scaleMode = .resizeFill
                return scene
            }())
            .ignoresSafeArea()
        }
    }
}

#Preview {
    ContentView()
}
