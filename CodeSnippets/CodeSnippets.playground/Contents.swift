import Foundation

var x = 5
var y = 5
var xlock = NSLock()
DispatchQueue.concurrentPerform(iterations: 5) { _ in
    
    var yCopy = y
    yCopy += 1
    y = yCopy
    
    xlock.lock()
    var xCopy = x
    xCopy += 1
    x = xCopy
    xlock.unlock()
}

print("x: \(x), y: \(y)")
