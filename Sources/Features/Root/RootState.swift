//
//  RootState.swift
//  merchant
//
//  Created by adam on 2025/7/29.
//

import Foundation
import ComposableArchitecture

struct RootState {
    @BindingState var navigationPath: [String] = []
}
