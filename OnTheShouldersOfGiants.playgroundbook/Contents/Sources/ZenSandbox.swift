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
        colors = [#colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)]
        
        collisionBehavior = UICollisionBehavior(items: [])
        gravityBehavior = UIGravityBehavior(items: [])
        itemBehavior = UIDynamicItemBehavior(items: [])
        
        marblePadding = 2.0
        itemBehavior.resistance = 2
        useSquaresInsteadOfBalls = true
        gravityEnabled = false
        
        super.init(frame: CGRect(x: 0, y: 0, width: 480, height: 320))
        
        backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        //fillBackground()
        
        animator = UIDynamicAnimator(referenceView: self)
        collisionBehavior.translatesReferenceBoundsIntoBoundary = true
        animator?.addBehavior(gravityBehavior)
        animator?.addBehavior(itemBehavior)
        animator?.addBehavior(collisionBehavior)
        
        let treeView = UIImageView(image: UIImage(named: "treeColored.png"))
        treeView.frame = CGRect(x: ((super.bounds.maxX/2)-250) , y: super.bounds.maxY + 50, width: 500, height: 500)
        
        self.addSubview(treeView)
        
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
            
            //let marbleXOrigin = ((bounds.width - requiredWidth) / 1.5) + (CGFloat(index) * (marbleSize.width + CGFloat(marblePadding)))
            marble.frame = CGRect(x: bounds.midX + 50, y: bounds.maxY + 135, width: marbleSize.width, height: marbleSize.height)
            
            collisionBehavior.addItem(marble)
            itemBehavior.addItem(marble)
            
            if let maskImage = UIImage(named: "applemask.png") {
                let maskImageSized = imageWithImage(image: maskImage, scaledToSize: marbleSize)
                marble.mask = UIImageView(image: maskImageSized)
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
