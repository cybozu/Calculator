import SwiftUI

public struct Cell: Identifiable {
    public var id = UUID()
    public var area: Area
    public var role: Role
}
