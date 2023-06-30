import Foundation
import SwiftUI

extension View {
    func navigation<Destination: View>(
        isActive: Binding<Bool>,
        @ViewBuilder destination: () -> Destination?
    ) -> some View {
        overlay(
            NavigationLink(
                isActive: isActive,
                destination: {
                    if isActive.wrappedValue {
                        destination()
                    }
                },
                label: { Text("") }
            )
            .accessibilityHidden(true)
            .opacity(0)
        )
    }

    func navigation<Item, Destination: View>(
        item: Binding<Item?>,
        @ViewBuilder destination: (Item) -> Destination?
    ) -> some View {
        let isActive = Binding(
            get: { item.wrappedValue != nil },
            set: { value in
                if !value {
                    item.wrappedValue = nil
                }
            }
        )
        return navigation(isActive: isActive) {
            item.wrappedValue.map(destination)
        }
    }
}

struct Flow<Content: View, NextView: View, Action: Identifiable>: View {

    @Binding var item: FlowItem<Action>?
    var content: () -> Content
    var nextView: (Action) -> NextView

    init(item: Binding<FlowItem<Action>?>, @ViewBuilder content: @escaping () -> Content, @ViewBuilder nextView: @escaping (Action) -> NextView) {
        self.content = content
        self.nextView = nextView
        self._item = Binding(projectedValue: item)
    }

    var body: some View {
        content()
            .navigation(item: .filter($item, is: .navigation)) { action in
                nextView(action)
            }
            .sheet(item: .filter($item, is: .modal), onDismiss: item?.onDissmiss) { action in
                nextView(action)
            }
            .sheet(item: .filter($item, is: .bottomSheet), onDismiss: item?.onDissmiss) { action in
                nextView(action)
                    .presentationDetents([.medium, .large])
            }
            .fullScreenCover(item: .filter($item, is: .fullscreen), onDismiss: item?.onDissmiss) { action in
                nextView(action)
            }
    }
}

private extension Binding {
    enum ItemType: Equatable {
        case navigation
        case bottomSheet
        case modal
        case fullscreen
    }

    static func filter<Action>(_ binding: Binding<FlowItem<Action>?>, is itemType: ItemType) -> Binding<Action?> {
        return Binding<Action?>(
            get: {
                guard let value = binding.wrappedValue else { return nil }

                switch value {
                case .navigate:
                    guard itemType == .navigation else { return nil }
                    return binding.wrappedValue?.action
                case .bottomSheet:
                    guard itemType == .bottomSheet else { return nil }
                    return binding.wrappedValue?.action
                case .modal:
                    guard itemType == .modal else { return nil }
                    return binding.wrappedValue?.action
                case .fullscreen:
                    guard itemType == .fullscreen else { return nil }
                    return binding.wrappedValue?.action
                }
            }, set: { value in
                if value == nil && binding.wrappedValue != nil {
                    switch binding.wrappedValue {
                    case .navigate(_, let onDissmiss):
                        DispatchQueue.main.async {
                            onDissmiss?()
                        }
                    default:
                        break
                    }
                    binding.wrappedValue = nil
                }
            }
        )
    }
}

enum FlowItem<Action: Identifiable> {
    case navigate(Action, onDissmiss: (() -> Void)? = nil)
    case modal(Action, onDissmiss: (() -> Void)? = nil)
    case bottomSheet(Action, onDissmiss: (() -> Void)? = nil)
    case fullscreen(Action, onDissmiss: (() -> Void)? = nil)

    var action: Action {
        switch self {
        case .navigate(let action, _), .modal(let action, _), .bottomSheet(let action, _), .fullscreen(let action, _):
            return action
        }
    }

    var onDissmiss: (() -> Void)? {
        switch self {
        case .bottomSheet(_, let onDismiss):
            return onDismiss
        case .fullscreen(_, let onDissmiss):
            return onDissmiss
        case .navigate(_, let onDissmiss):
            return onDissmiss
        case .modal(_, let onDissmiss):
            return onDissmiss
        }
    }
}

@main
struct BestNavigationApp: App {

    @State var destinationFlow: FlowItem<FlowAction>?

    @State var int = 0
    var body: some Scene {
        WindowGroup {
            NavigationView {
                Flow(
                    item: $destinationFlow,
                    content: {
                        ContentView(action: { destinationFlow = flowItem(from: $0, onDismiss: $1) } )
                    },
                    nextView: { action in FollowingView(text: "\(action)") })
            }
        }
    }

    func flowItem(from action: FlowAction, onDismiss: (() -> Void)?) -> FlowItem<FlowAction> {
        switch action {
        case .one:
            return .navigate(action, onDissmiss: onDismiss)
        case .two:
            return .bottomSheet(action, onDissmiss: onDismiss)
        case .three:
            return .fullscreen(action, onDissmiss: onDismiss)
        case .four:
            return .modal(action, onDissmiss: onDismiss)
        }
    }
}

protocol ActionFlow: RawRepresentable, Identifiable {}
extension ActionFlow where RawValue == Int {
    var id: Int { rawValue }
}

enum FlowAction: Int, ActionFlow {

    case one
    case two
    case three
    case four
}

struct ContentView: View {

    var action: (FlowAction, _ onDismiss: (() -> Void)?) -> Void

    var body: some View {
        VStack(spacing: 16) {
            Button("one") { action(.one, { action(.two, { action(.three, { action(.four, { action(.one, printa) }) }) }) }) }
            Button("two", action: { action(.two, { action(.three, printa) }) })
            Button("three", action: { action(.three, { action(.four, printa) }) })
            Button("four", action: { action(.four, { action(.one, printa) }) })
        }
    }

    func printa() {
        print("onDismiss")
    }
}

struct FollowingView: View {
    @Environment(\.dismiss) private var dismiss

    var text: String

    var body: some View {
        VStack(spacing: 16) {
            Text(text)
            Button("Close") {
                dismiss()
            }
        }
    }
}
