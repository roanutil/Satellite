//
//  ViewStore.swift
//  Satellite
//
//  Created by Andrew Roan on 4/12/21.
//

import Combine
import Foundation
import ReSwift

protocol ViewStore: ObservableObject {
    associatedtype State
    var state: State { get }
    func dispatch(_ action: Action)
}

protocol ComboViewStore: ViewStore, ParentViewStore where State == ParentState {}

final class RootViewStore<State: StateType>: StoreSubscriber, DispatchingStoreType, ObservableObject {
    private var cancellables = [AnyCancellable]()
    private let store: Store<State>
    @Published var state: State

    init(_ store: Store<State>) {
        self.store = store
        self.state = store.state
        store.subscribe(self)
    }

    func dispatch(_ action: Action) {
        if Thread.isMainThread {
            store.dispatch(action)
        } else {
            DispatchQueue.main.async { [store] in
                store.dispatch(action)
            }
        }
    }

    func newState(state: State) {
        self.state = state
    }

    deinit {
        cancellables.forEach { $0.cancel() }
    }
}

extension RootViewStore: ParentViewStore {
    var parentState: Published<State>.Publisher {
        self.$state
    }
}

extension RootViewStore: ViewStore {}

protocol ParentViewStore: DispatchingStoreType {
    associatedtype ParentState: StateType
    var state: ParentState { get }
    var parentState: Published<ParentState>.Publisher { get }
}

final class ChildViewStore<ChildState: StateType, Parent: ParentViewStore>: ObservableObject {
    private var cancellables = [AnyCancellable]()
    private let parent: Parent
    @Published var state: ChildState

    init(parent: Parent, parentState: AnyPublisher<ChildState, Never>, state: ChildState) {
        self.parent = parent
        self.state = state
        parentState.assign(to: \.state, on: self).store(in: &self.cancellables)
    }

    convenience init(parent: Parent, statePath: KeyPath<Parent.ParentState, ChildState>) {
        self.init(
            parent: parent,
            parentState: parent.parentState.map(statePath).eraseToAnyPublisher(),
            state: parent.state[keyPath: statePath]
        )
    }

    convenience init?(parent: Parent, statePath: KeyPath<Parent.ParentState, ChildState?>) {
        if let state = parent.state[keyPath: statePath] {
            self.init(
                parent: parent,
                parentState: parent.parentState.map(statePath).compactMap({ $0 }).eraseToAnyPublisher(),
                state: state
            )
        } else {
            return nil
        }
    }

    func dispatch(_ action: Action) {
        if Thread.isMainThread {
            parent.dispatch(action)
        } else {
            DispatchQueue.main.async { [parent] in
                parent.dispatch(action)
            }
        }
    }

    deinit {
        self.cancellables.forEach { $0.cancel() }
    }
}

extension ChildViewStore: ComboViewStore {
    var parentState: Published<ChildState>.Publisher {
        $state
    }
}
