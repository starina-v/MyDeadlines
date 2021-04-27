import Foundation
import Moya

protocol TargetTypeExtension: TargetType {

    var sampleApiResult: Encodable { get }
}

extension TargetTypeExtension {

    var sampleApiResult: Encodable {
        EmptyApiResult()
    }

    var sampleData: Data {
        makeSampleData { sampleApiResult }
    }

    private func makeSampleData(from encodableProvider: () -> (Encodable)) -> Data {
        do {
            return try encodableProvider().encode()
        } catch {
            print("Failed to make sample data for target: \(self) with error: \(error)")
            return Data()
        }
    }
}
