/*:
 
 # On The Shoulders of Giants
 
 ---
 
 "_If I have seen further than others, it is by standing upon the shoulders of giants._"
 -Isaac Newton, 1675
 
 ---
 
 The triumphs of humanity is founded in the history of our past.
 
 We owe all of our understanding of modern science and technology to the discoveries of the great 👩🏻‍🔬👨🏽‍🔬👨🏼‍🏫👩🏽‍🏫 and thinkers we continue to stand tall upon to this day.
 
 *This playground celebrates the giants of our past and takes a look towards our future. A future that you and I can build.*
 
 Expand the live view and tap "Run My Code" to begin.
 */
//#-hidden-code
import UIKit
import PlaygroundSupport
let space = UIView()
let starView = UIImageView()
starView.image = UIImage(named: "starview.png")
starView.frame = CGRect(x: -250, y: -250, width: 2089, height: 1412)
starView.clipsToBounds = true

func showStars(_ bool: Bool) {
    if bool {
        
        UIView.animate(withDuration: 2, delay: 0.5, options: .transitionCrossDissolve, animations: {
            starView.alpha = 0.0
            space.addSubview(starView)
            starView.alpha = 1.0
        }, completion: nil)
        
    } else {
        starView.removeFromSuperview()
    }
}

func twinkleStars(speed: Double) {
    UIView.animate(withDuration: speed, delay: 0, options: [.repeat, .autoreverse, .transitionCrossDissolve], animations: {
        starView.alpha = 0.6
        starView.alpha = 1.0
        
    }, completion: nil)
}

//#-end-hidden-code
//: Let's start with some basics to get you familiar with the way to interact with this playground
//: * Try changing the background color property to change the color of space
//: * Dont forget to **run** your program!
space.backgroundColor = /*#-editable-code placeholder text*/.black/*#-end-editable-code*/
//: Something is missing though... Ah! The stars.
//: * Set the value passed into addStars() to **true**
//: * **Run** your program to see the magic ✨
showStars(/*#-editable-code placeholder text*/false/*#-end-editable-code*/)
//: Stars would hardly be stars if they didn't twinkle! Let's make that happen.
//: * What happens if you change the speed?
twinkleStars(speed: /*#-editable-code placeholder text*/0.0/*#-end-editable-code*/)
//#-hidden-code
PlaygroundPage.current.liveView = space
//#-end-hidden-code
//: [Next Page](@next)
