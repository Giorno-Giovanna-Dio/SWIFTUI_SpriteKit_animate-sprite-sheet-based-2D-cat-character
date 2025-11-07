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

🎬 [點我觀看 Cat Demo Video](github_2D_cat_demo.mp4)

> 💡 Tap anywhere on the screen to switch between animations cyclically.

---

## 🧩 Project Structure
```
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
```
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
### 🧩 Sprite Scene (`CatScene.swift`)
```swift
import SpriteKit

class CatScene: SKScene {
    private var cat: SKSpriteNode?
    private var currentAction: String = "IDLE"

    // Define available animations and frame counts
    private let animations: [String: Int] = [
        "IDLE": 8, "WALK": 12, "RUN": 8,
        "ATTACK 1": 8, "RUNNING JUMP": 3,
        "JUMP": 3, "HURT": 4
    ]

    override func didMove(to view: SKView) {
        backgroundColor = .black
        if cat == nil {
            cat = SKSpriteNode(imageNamed: "IDLE.png")
            cat?.xScale = 0.5
            cat?.yScale = 2.5 * (80.0 / 64.0)
            cat?.position = CGPoint(x: frame.midX, y: frame.midY)
            cat?.texture?.filteringMode = .nearest
            addChild(cat!)
        }
        playAnimation(named: "IDLE")
    }

    func playAnimation(named name: String, timePerFrame: TimeInterval = 0.1) {
        guard let frameCount = animations[name.uppercased()] else { return }
        guard let image = UIImage(named: "\(name).png"),
              let cgImage = image.cgImage else { return }

        let frameWidth = cgImage.width / frameCount
        let frameHeight = cgImage.height
        var frames: [SKTexture] = []

        for i in 0..<frameCount {
            let rect = CGRect(x: i * frameWidth, y: 0,
                              width: frameWidth, height: frameHeight)
            if let cropped = cgImage.cropping(to: rect) {
                let frame = SKTexture(cgImage: cropped)
                frame.filteringMode = .nearest
                frames.append(frame)
            }
        }

        cat?.removeAllActions()
        cat?.texture = frames.first
        let animation = SKAction.repeatForever(
            SKAction.animate(with: frames, timePerFrame: timePerFrame)
        )
        cat?.run(animation)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let keys = Array(animations.keys).sorted()
        guard let currentIndex = keys.firstIndex(of: currentAction) else { return }
        let nextIndex = (currentIndex + 1) % keys.count
        let nextAction = keys[nextIndex]
        playAnimation(named: nextAction)
    }

    override func didChangeSize(_ oldSize: CGSize) {
        super.didChangeSize(oldSize)
        cat?.position = CGPoint(x: size.width / 2, y: size.height / 2)
    }
}
```

## 🧰 Requirements
	•	macOS 14+
	•	Xcode 16+
	•	iOS 17 or newer
	•	Swift 5.9+

## 🐙 License

MIT License © 2025 David Chung

⸻

## 🧡 Built with SwiftUI & SpriteKit — a fun pixel-art playground for learning 2D animation in Swift.
