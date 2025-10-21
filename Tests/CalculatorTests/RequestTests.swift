@testable import Calculator
import Foundation
import Testing

struct RequestTests {
    @Test(arguments: [
        .init(
            requests: [.term(.init(1))],
            expectedIsClear: true
        ),
        .init(
            requests: [.operator(.subtraction), .term(.init(1))],
            expectedIsClear: true
        ),
        .init(
            requests: [.operator(.subtraction)],
            expectedIsClear: false
        ),
        .init(
            requests: [.term(.init(1)), .operator(.addition)],
            expectedIsClear: false
        ),
        .init(
            requests: [.term(.init(1)), .operator(.addition), .term(.init(1))],
            expectedIsClear: true
        ),
    ] as [IsClearCondition])
    func isClear(_ condition: IsClearCondition) {
        #expect(condition.requests.isClear == condition.expectedIsClear)
    }

    @Test(arguments: [
        .init(
            decimalValue: 0,
            expectedRequests: [.term(.init(0))]
        ),
        .init(
            decimalValue: -1,
            expectedRequests: [.operator(.subtraction), .term(.init(1))]
        ),
        .init(
            decimalValue: 1.2,
            expectedRequests: [.term(.init(1.2))]
        ),
        .init(
            decimalValue: -1.2,
            expectedRequests: [.operator(.subtraction), .term(.init(1.2))]
        ),
    ] as [RequestsCondition])
    func init_from_decimal(_ condition: RequestsCondition) {
        let actual = [Request](decimalValue: condition.decimalValue)
        #expect(actual == condition.expectedRequests)
    }

    @Test(arguments: [
        .init(
            requests: [.term(.init(1)), .operator(.multiplication), .operator(.subtraction), .term(.init(2))],
            at: 1,
            count: 3,
            expectedRequests: [.term(.init(1))]
        ),
        .init(
            requests: [.term(.init(1)), .operator(.multiplication), .operator(.subtraction), .term(.init(2))],
            at: 2,
            count: 1,
            expectedRequests: [.term(.init(1)), .operator(.multiplication), .term(.init(2))]
        ),
    ] as [RemoveCondition])
    func remove(_ condition: RemoveCondition) {
        var actual = condition.requests
        actual.remove(at: condition.at, count: condition.count)
        #expect(actual == condition.expectedRequests)
    }

    @Test(arguments: [
        .init(
            requests: [],
            index: 0,
            expectedSignedTerm: nil
        ),
        .init(
            requests: [],
            index: 1,
            expectedSignedTerm: nil
        ),
        .init(
            requests: [],
            index: -1,
            expectedSignedTerm: nil
        ),
        .init(
            requests: [.term(.init(1))],
            index: 0,
            expectedSignedTerm: nil
        ),
        .init(
            requests: [.operator(.subtraction), .term(.init(1))],
            index: 1,
            expectedSignedTerm: nil
        ),
        .init(
            requests: [.term(.init(1)), .operator(.addition), .term(.init(2))],
            index: 1,
            expectedSignedTerm: .init(value: 1, cost: 1)
        ),
        .init(
            requests: [.operator(.subtraction), .term(.init(1)), .operator(.addition), .term(.init(2))],
            index: 2,
            expectedSignedTerm: .init(value: -1, cost: 2)
        ),
        .init(
            requests: [.term(.init(1)), .operator(.addition), .term(.init(2)), .operator(.addition), .term(.init(3))],
            index: 3,
            expectedSignedTerm: .init(value: 2, cost: 1)
        ),
        .init(
            requests: [.term(.init(1)), .operator(.subtraction), .term(.init(2)), .operator(.addition), .term(.init(3))],
            index: 3,
            expectedSignedTerm: .init(value: -2, cost: 2)
        ),
        .init(
            requests: [.term(.init(1)), .operator(.multiplication), .operator(.subtraction), .term(.init(2))],
            index: 2,
            expectedSignedTerm: nil
        ),
    ] as [SignedTermCondition])
    func signedTerm_before(_ condition: SignedTermCondition) {
        let actual = condition.requests.signedTerm(before: condition.index)
        #expect(actual == condition.expectedSignedTerm)
    }

    @Test(arguments: [
        .init(
            requests: [],
            index: 0,
            expectedSignedTerm: nil
        ),
        .init(
            requests: [],
            index: 1,
            expectedSignedTerm: nil
        ),
        .init(
            requests: [],
            index: -1,
            expectedSignedTerm: nil
        ),
        .init(
            requests: [.term(.init(1))],
            index: 0,
            expectedSignedTerm: nil
        ),
        .init(
            requests: [.term(.init(1)), .operator(.subtraction)],
            index: 0,
            expectedSignedTerm: nil
        ),
        .init(
            requests: [.term(.init(1)), .operator(.addition), .term(.init(2))],
            index: 1,
            expectedSignedTerm: .init(value: 2, cost: 1)
        ),
        .init(
            requests: [.term(.init(1)), .operator(.multiplication), .operator(.subtraction), .term(.init(2))],
            index: 1,
            expectedSignedTerm: .init(value: -2, cost: 2)
        ),
        .init(
            requests: [.term(.init(1)), .operator(.addition), .term(.init(2)), .operator(.addition), .term(.init(3))],
            index: 1,
            expectedSignedTerm: .init(value: 2, cost: 1)
        ),
        .init(
            requests: [.term(.init(1)), .operator(.multiplication), .operator(.subtraction), .term(.init(2))],
            index: 0,
            expectedSignedTerm: nil
        ),
    ] as [SignedTermCondition])
    func signedTerm_after(_ condition: SignedTermCondition) {
        let actual = condition.requests.signedTerm(after: condition.index)
        #expect(actual == condition.expectedSignedTerm)
    }

    @Test(arguments: [
        .init(
            requests: [],
            expectedRequests: nil
        ),
        .init(
            requests: [.term(.init(1))],
            expectedRequests: nil
        ),
        .init(
            requests: [.operator(.subtraction)],
            expectedRequests: nil
        ),
        .init(
            requests: [.operator(.subtraction), .term(.init(1))],
            expectedRequests: nil
        ),
        .init(
            requests: [.term(.init(1)), .operator(.addition), .term(.init(1))],
            expectedRequests: [.term(.init(2))]
        ),
        .init(
            requests: [.term(.init(1)), .operator(.subtraction), .term(.init(1))],
            expectedRequests: [.term(.init(0))]
        ),
        .init(
            requests: [.term(.init(2)), .operator(.multiplication), .term(.init(3))],
            expectedRequests: [.term(.init(6))]
        ),
        .init(
            requests: [.term(.init(6)), .operator(.division), .term(.init(3))],
            expectedRequests: [.term(.init(2))]
        ),
        .init(
            requests: [.term(.init(3)), .operator(.modulus), .term(.init(2))],
            expectedRequests: [.term(.init(1))]
        ),
        .init(
            requests: [.term(.init(3.5)), .operator(.modulus), .term(.init(2))],
            expectedRequests: [.term(.init(1.5))]
        ),
        .init(
            requests: [.operator(.subtraction), .term(.init(3.5)), .operator(.modulus), .term(.init(2))],
            expectedRequests: [.term(.init(0.5))]
        ),
        .init(
            requests: [.term(.init(3.5)), .operator(.modulus), .operator(.subtraction), .term(.init(2))],
            expectedRequests: [.operator(.subtraction), .term(.init(0.5))]
        ),
        .init(
            requests: [.operator(.subtraction), .term(.init(3.5)), .operator(.modulus), .operator(.subtraction), .term(.init(2))],
            expectedRequests: [.operator(.subtraction), .term(.init(1.5))]
        ),
    ] as [CalculatedCondition])
    func calculated_simple_expression(_ condition: CalculatedCondition) throws {
        let actual = try condition.requests.calculated()
        #expect(actual == condition.expectedRequests)
    }

    @Test(arguments: [
        .init(
            requests: [.term(.init(1)), .operator(.division), .term(.init(0))],
            expectedRequests: []
        ),
        .init(
            requests: [.term(.init(1)), .operator(.modulus), .term(.init(0))],
            expectedRequests: []
        ),
    ] as [CalculatedCondition])
    func calculated_taboo(_ condition: CalculatedCondition) throws {
        #expect(throws: CalculatorError.undefined) {
            try condition.requests.calculated()
        }
    }

    @Test(arguments: [
        .init(
            requests: [.term(.init(1)), .operator(.addition), .term(.init(1)), .operator(.addition), .term(.init(1)), .operator(.addition), .term(.init(1))],
            expectedRequests: [.term(.init(4))]
        ),
        .init(
            requests: [.term(.init(1)), .operator(.subtraction), .term(.init(1)), .operator(.subtraction), .term(.init(1)), .operator(.subtraction), .term(.init(1))],
            expectedRequests: [.operator(.subtraction), .term(.init(2))]
        ),
        .init(
            requests: [.term(.init(2)), .operator(.multiplication), .term(.init(3)), .operator(.multiplication), .term(.init(4)), .operator(.multiplication), .term(.init(5))],
            expectedRequests: [.term(.init(120))]
        ),
        .init(
            requests: [.term(.init(300)), .operator(.division), .term(.init(10)), .operator(.division), .term(.init(5)), .operator(.division), .term(.init(2))],
            expectedRequests: [.term(.init(3))]
        ),
        .init(
            requests: [.term(.init(80)), .operator(.modulus), .term(.init(50)), .operator(.modulus), .term(.init(20)), .operator(.modulus), .term(.init(3))],
            expectedRequests: [.term(.init(1))]
        ),
    ] as [CalculatedCondition])
    func calculated_easy_expression(_ condition: CalculatedCondition) throws {
        let actual = try condition.requests.calculated()
        #expect(actual == condition.expectedRequests)
    }

    @Test(arguments: [
        .init(
            requests: [
                .term(.init(10)),
                .operator(.addition),
                .term(.init(5)),
                .operator(.multiplication),
                .operator(.subtraction),
                .term(.init(6)),
                .operator(.division),
                .operator(.subtraction),
                .term(.init(3)),
                .operator(.addition),
                .term(.init(2))
            ],
            expectedRequests: [.term(.init(22))]
        ),
        .init(
            requests: [
                .term(.init(123.45)),
                .operator(.modulus),
                .term(.init(3)),
                .operator(.multiplication),
                .term(.init(100)),
                .operator(.division),
                .term(.init(9)),
                .operator(.subtraction),
                .term(.init(7)),
                .operator(.addition),
                .term(.init(2))
            ],
            expectedRequests: [.term(.init(0))]
        ),
    ] as [CalculatedCondition])
    func calculated_complicated_expression(_ condition: CalculatedCondition) throws {
        let actual = try condition.requests.calculated()
        #expect(actual == condition.expectedRequests)
    }
}

struct IsClearCondition {
    var requests: [Request]
    var expectedIsClear: Bool
}

struct RequestsCondition {
    var decimalValue: Decimal
    var expectedRequests: [Request]
}

struct RemoveCondition {
    var requests: [Request]
    var at: Int
    var count: Int
    var expectedRequests: [Request]
}

struct SignedTermCondition {
    var requests: [Request]
    var index: Int
    var expectedSignedTerm: SignedTerm?
}

struct CalculatedCondition {
    var requests: [Request]
    var expectedRequests: [Request]?
}
