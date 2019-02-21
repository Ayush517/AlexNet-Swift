import TensorFlow
import Foundation

let batchSize: Int32 = 128
let classCount = 1000

let fakeImageBatch = Tensor<Float>(zeros: [batchSize, 227, 227, 3])
let fakeLabelBatch = Tensor<Int32>(zeros: [batchSize])

let learningPhaseIndicator = LearningPhaseIndicator()
var alexNet = AlexNet(classCount: classCount, learningPhaseIndicator: learningPhaseIndicator)
let optimizer = SGD<AlexNet, Float>(learningRate: 0.1, momentum: 0.9)

print("Start of training process")

let startTime = NSDate()
for batchNumber in 0..<5 {
    let gradients = gradient(at: alexNet) { model in
        loss(model: model, images: fakeImageBatch, labels: fakeLabelBatch)
    }
    optimizer.update(&alexNet.allDifferentiableVariables, along: gradients)
    print("Completed batch \(batchNumber)")
}
let endTime = -startTime.timeIntervalSinceNow

print("End of training process, took \(endTime)s")
