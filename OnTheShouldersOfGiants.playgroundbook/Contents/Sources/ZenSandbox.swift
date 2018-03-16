import UIKit

public class ZenSandbox: UIView {
    
    private let colors: [UIColor]
    private var marbles: [UIView] = []
    
    private var animator: UIDynamicAnimator?
    private var snapBehavior: UISnapBehavior?
    
    public let collisionBehavior: UICollisionBehavior
    public let gravityBehavior: UIGravityBehavior
    public let itemBehavior: UIDynamicItemBehavior
    
    
    public init() {
        colors = [#colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1), #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1), #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1), #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1), #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1), #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1), #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1), #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)]
        
        collisionBehavior = UICollisionBehavior(items: [])
        gravityBehavior = UIGravityBehavior(items: [])
        itemBehavior = UIDynamicItemBehavior(items: [])
        
        marblePadding = 2.0
        itemBehavior.resistance = 2
        useSquaresInsteadOfBalls = true
        gravityEnabled = false
        
        super.init(frame: CGRect(x: 0, y: 0, width: 480, height: 320))
        
        backgroundColor = .white
        fillBackground()
        
        animator = UIDynamicAnimator(referenceView: self)
        collisionBehavior.translatesReferenceBoundsIntoBoundary = true
        animator?.addBehavior(gravityBehavior)
        animator?.addBehavior(itemBehavior)
        animator?.addBehavior(collisionBehavior)
        
        
        createMarbles()
    }
    
    public init(colors: [UIColor]) {
        self.colors = colors
        
        collisionBehavior = UICollisionBehavior(items: [])
        gravityBehavior = UIGravityBehavior(items: [])
        itemBehavior = UIDynamicItemBehavior(items: [])
        gravityEnabled = false
        
        super.init(frame: CGRect(x: 0, y: 0, width: 480, height: 320))

        backgroundColor = .white
        
        fillBackground()
        
        animator = UIDynamicAnimator(referenceView: self)
        animator?.addBehavior(collisionBehavior)
        animator?.addBehavior(gravityBehavior)
        animator?.addBehavior(itemBehavior)
        
        
        createMarbles()
    }
    
    func createBase() {
        let base = UIView()
        
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        for marble in marbles {
            marble.removeObserver(self, forKeyPath: "center")
        }
    }
    
    public var useSquaresInsteadOfBalls:Bool = false {
        didSet {
            for marble in marbles {
                if useSquaresInsteadOfBalls {
                    marble.layer.cornerRadius = 0
                }
                else {
                    marble.layer.cornerRadius = marble.bounds.width / 2.0
                    marble.clipsToBounds = true
                }
            }
        }
    }
    
    public var gravityEnabled: Bool {
        didSet {
            if gravityEnabled {
                for marble in marbles {
                    gravityBehavior.addItem(marble)
                }
            } else {
                for marble in marbles {
                    gravityBehavior.removeItem(marble)
                }
            }
        }
    }
    
    func fillBackground() {
        super.backgroundColor = .white
    }
    
    func createMarbles() {
        for marbleColor in colors {
            let ballMarble = UIView(frame: CGRect.zero)
            
            ballMarble.addObserver(self, forKeyPath: "center", options: NSKeyValueObservingOptions.init(rawValue: 0), context: nil)
            
            ballMarble.backgroundColor = marbleColor
            
            addSubview(ballMarble)
            marbles.append(ballMarble)
            
            layoutMarbles()
            
        }
    }
    
    func layoutMarbles() {
        let requiredWidth = CGFloat(marbles.count) * (marbleSize.width + CGFloat(marblePadding))
        
        for (index, marble) in marbles.enumerated() {
            collisionBehavior.removeItem(marble)
            itemBehavior.removeItem(marble)
            
            let marbleXOrigin = ((bounds.width - requiredWidth) / 1.5) + (CGFloat(index) * (marbleSize.width + CGFloat(marblePadding)))
            marble.frame = CGRect(x: marbleXOrigin, y: bounds.midY, width: marbleSize.width, height: marbleSize.height)
            
            collisionBehavior.addItem(marble)
            itemBehavior.addItem(marble)
            
            switch index {
            case 0:
                // W
                if let maskImage = UIImage(named: "W@3x.png") {
                    let maskImageSized = imageWithImage(image: maskImage, scaledToSize: marbleSize)
                    marble.mask = UIImageView(image: maskImageSized)
                }
            case 1:
                // W
                if let maskImage = UIImage(named: "W@3x.png") {
                    let maskImageSized = imageWithImage(image: maskImage, scaledToSize: marbleSize)
                    marble.mask = UIImageView(image: maskImageSized)
                }
            case 2:
                // D
                if let maskImage = UIImage(named: "D@3x.png") {
                    let maskImageSized = imageWithImage(image: maskImage, scaledToSize: marbleSize)
                    marble.mask = UIImageView(image: maskImageSized)
                }
            case 3:
                // C
                if let maskImage = UIImage(named: "C@3x.png") {
                    let maskImageSized = imageWithImage(image: maskImage, scaledToSize: marbleSize)
                    marble.mask = UIImageView(image: maskImageSized)
                }
            case 4:
                // 2
                if let maskImage = UIImage(named: "2@3x.png") {
                    let maskImageSized = imageWithImage(image: maskImage, scaledToSize: marbleSize)
                    marble.mask = UIImageView(image: maskImageSized)
                }
            case 5:
                // 0
                if let maskImage = UIImage(named: "0@3x.png") {
                    let maskImageSized = imageWithImage(image: maskImage, scaledToSize: marbleSize)
                    marble.mask = UIImageView(image: maskImageSized)
                }
            case 6:
                // 1
                if let maskImage = UIImage(named: "1@3x.png") {
                    let maskImageSized = imageWithImage(image: maskImage, scaledToSize: marbleSize)
                    marble.mask = UIImageView(image: maskImageSized)
                }
            case 7:
                // 8
                if let maskImage = UIImage(named: "8@3x.png") {
                    let maskImageSized = imageWithImage(image: maskImage, scaledToSize: marbleSize)
                    marble.mask = UIImageView(image: maskImageSized)
                }
            default:
                // no mask
                print()
            }
            
        }
    }
    
    public var marbleSize: CGSize = CGSize(width: 50, height: 50) {
        didSet {
            layoutMarbles()
        }
    }
    
    public var marblePadding: Double = 0.0 {
        didSet {
            layoutMarbles()
        }
    }
    
    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let touchLocation = touch.location(in: superview)
            for marble in marbles {
                if (marble.frame.contains(touchLocation)) {
                    snapBehavior = UISnapBehavior(item: marble, snapTo: touchLocation)
                    animator?.addBehavior(snapBehavior!)
                }
            }
        }
    }
    
    override public func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let touchLocation = touch.location(in: superview)
            if let snapBehavior = snapBehavior {
                snapBehavior.snapPoint = touchLocation
            }
        }
    }
    
    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let snapBehavior = snapBehavior {
            animator?.removeBehavior(snapBehavior)
        }
        snapBehavior = nil
    }
    
    public override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if (keyPath == "center") {
            setNeedsDisplay()
        }
    }
    
    func imageWithImage(image: UIImage, scaledToSize newSize: CGSize) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0);
        image.draw(in: CGRect(origin: CGPoint.zero, size: CGSize(width: newSize.width, height: newSize.height)))
        let newImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return newImage
    }
    
}
