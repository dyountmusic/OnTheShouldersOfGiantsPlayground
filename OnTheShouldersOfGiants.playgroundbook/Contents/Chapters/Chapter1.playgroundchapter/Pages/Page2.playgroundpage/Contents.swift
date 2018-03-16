/*:
 Isaac Newton, an English mathematician and physicist, is considered the greatest scientist of all time. Among his many discoveries, the most important is probably his law of universal gravitation. In 1664, Newton figured out that gravity is the force that draws objects toward each other. It explained why things fall down and why the planets orbit around the Sun.
 ---
*/
//#-hidden-code
import PlaygroundSupport
import Foundation
import UIKit
import CoreGraphics

let gravityView = ZenSandbox()
//#-end-hidden-code
//: * Enable gravity!
gravityView.gravityEnabled = /*#-editable-code placeholder text*/false/*#-end-editable-code*/
//: * Change the angle and/or magnitude of gravity to simulate how gravity might behave on different planets.
gravityView.gravityBehavior.angle = CGFloat(/*#-editable-code placeholder text*/Double.pi/2/*#-end-editable-code*/)
gravityView.gravityBehavior.magnitude = /*#-editable-code placeholder text*/1.0/*#-end-editable-code*/

//#-hidden-code
PlaygroundPage.current.liveView = gravityView
//#-end-hidden-code
