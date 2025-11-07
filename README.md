# 🐾 SpriteTestingProject

A SwiftUI + SpriteKit demo showcasing how to load and animate **pixel-art sprite sheet**–based 2D characters (e.g. cat character) with multiple animations, scaling, and rotation support.  
Designed for learning how to integrate `SpriteKit` scenes inside SwiftUI apps.

---

## 🚀 Features

✅ **SwiftUI + SpriteKit integration** using `SpriteView`  
🎨 **Sprite Sheet animation player** (supports multiple frame counts per action)  
📱 **Responsive layout** — automatically repositions on device rotation  
🧭 **Tap interaction** — cycle through different animations dynamically  
🧱 **Pixel-perfect rendering** — uses `.nearest` filtering for retro style  

---

## 🐈‍⬛ Demo Preview

| Action | Frame Count |
|---------|--------------|
| IDLE | 8 |
| WALK | 12 |
| RUN | 8 |
| ATTACK 1 | 8 |
| RUNNING JUMP | 3 |
| JUMP | 3 |
| HURT | 4 |

> 💡 Tap anywhere on the screen to switch between animations cyclically.

---

## 🧩 Project Structure
SpriteTestingProject/
├── Sprites/
│   ├── IDLE.png
│   ├── WALK.png
│   ├── RUN.png
│   ├── ATTACK 1.png
│   ├── RUNNING JUMP.png
│   ├── JUMP.png
│   └── HURT.png
├── CatScene.swift          // SpriteKit animation logic
├── ContentView.swift       // SwiftUI + SpriteKit integration
└── SpriteTestingProjectApp.swift

---

## 🧠 Core Implementation

### 🪄 SwiftUI Integration (`ContentView.swift`)
```swift
import SwiftUI
import SpriteKit

struct ContentView: View {
    var body: some View {
        GeometryReader { geometry in
            SpriteView(scene: {
                let scene = CatScene()
                scene.size = geometry.size
                scene.scaleMode = .resizeFill
                return scene
            }())
            .ignoresSafeArea()
        }
    }
}
```

🧰 Requirements
	•	macOS 14+
	•	Xcode 16+
	•	iOS 17 or newer
	•	Swift 5.9+

🐙 License

MIT License © 2025 David Chung

⸻

🧡 Built with SwiftUI & SpriteKit — a fun pixel-art playground for learning 2D animation in Swift.
