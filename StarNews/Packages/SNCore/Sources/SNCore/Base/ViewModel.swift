//
//  ViewModel.swift
//  SNCore
//
//  Created by Baher Tamer on 19/06/2025.
//

import Observation

@MainActor
public protocol ViewModel: AnyObject {
    var state: ViewState { get set }
    
    func onInit()
    func onAppear()
    func onDisappear()
    func onRefresh()
    func errorAction()
    func emptyAction()
}

public extension ViewModel {
    func onAppear() {}
    func onDisappear() {}
    func onRefresh() {}
    func errorAction() {}
    func emptyAction() {}
}
