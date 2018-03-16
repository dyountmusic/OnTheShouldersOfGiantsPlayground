/*:
*Gravity - the force that attracts a body toward the center of the earth, or toward any other physical body having mass.*
 # The discovery of Gravity by Isaac Newton in 1687 was revolutionary to our understanding of the world and the physics behind it at the time.
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
