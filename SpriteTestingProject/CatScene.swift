//
//  CatScene.swift
//  SpriteTestingProject
//
//  Created by David Chung on 2025/11/7.
//

import SpriteKit

class CatScene: SKScene {
    private var cat: SKSpriteNode?   // ✅ 改成可選型別，避免強制解包 crash
    private var currentAction: String = "IDLE"

    // 註冊所有貓咪動畫（幀數）
    private let animations: [String: Int] = [
        "IDLE": 8,
        "WALK": 12,
        "RUN": 8,
        "ATTACK 1": 8,
        "RUNNING JUMP": 3,
        "JUMP": 3,
        "HURT": 4,
    ]

    override func didMove(to view: SKView) {
        backgroundColor = .black

        // 初始化角色
        if cat == nil {
            cat = SKSpriteNode(imageNamed: "IDLE.png")
            cat?.xScale = 0.5
            cat?.yScale = 2.5 * (80.0 / 64.0) // 保持正確比例
            cat?.position = CGPoint(x: frame.midX, y: frame.midY)
            cat?.texture?.filteringMode = .nearest
            addChild(cat!)
        }

        // 預設播放 IDLE
        playAnimation(named: "IDLE")
    }

    // MARK: - 播放任意動畫
    func playAnimation(named name: String, timePerFrame: TimeInterval = 0.1) {
        guard let frameCount = animations[name.uppercased()] else {
            print("⚠️ 找不到動畫 \(name)")
            return
        }
        currentAction = name.uppercased()
        playSpriteSheet(named: currentAction, frameCount: frameCount, timePerFrame: timePerFrame)
    }

    // MARK: - 播放 Sprite Sheet
    func playSpriteSheet(named name: String, frameCount: Int, timePerFrame: TimeInterval) {
        guard let image = UIImage(named: "\(name).png"),
              let cgImage = image.cgImage else {
            print("❌ 無法載入圖片 \(name).png")
            return
        }

        let frameWidth = cgImage.width / frameCount
        let frameHeight = cgImage.height
        var frames: [SKTexture] = []

        for i in 0..<frameCount {
            let rect = CGRect(x: i * frameWidth, y: 0, width: frameWidth, height: frameHeight)
            if let cropped = cgImage.cropping(to: rect) {
                let frame = SKTexture(cgImage: cropped)
                frame.filteringMode = .nearest
                frames.append(frame)
            }
        }

        guard !frames.isEmpty else {
            print("⚠️ 沒切出任何 frame for \(name)")
            return
        }

        // ✅ 使用安全可選呼叫
        cat?.removeAllActions()
        cat?.texture = frames.first
        let animation = SKAction.repeatForever(SKAction.animate(with: frames, timePerFrame: timePerFrame))
        cat?.run(animation, withKey: "animation")
    }

    // MARK: - 觸控事件：切換動作
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let keys = Array(animations.keys).sorted()
        guard let currentIndex = keys.firstIndex(of: currentAction) else { return }

        let nextIndex = (currentIndex + 1) % keys.count
        let nextAction = keys[nextIndex]
        print("🐾 切換動作 → \(nextAction)")
        playAnimation(named: nextAction)
    }

    // MARK: - 螢幕旋轉或尺寸變更
    override func didChangeSize(_ oldSize: CGSize) {
        super.didChangeSize(oldSize)
        cat?.position = CGPoint(x: size.width / 2, y: size.height / 2)
    }
}
