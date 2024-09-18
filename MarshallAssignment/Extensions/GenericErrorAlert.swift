//
//  GenericErrorAlert.swift
//  MarshallAssignment
//
//  Created by Abhishek Babladi on 2024-09-13.
//

import Foundation
import SwiftUI

// MARK: Generic alertview which can be utilised on any view as a modifier
extension View {
    func errorAlert(errorMessage: Binding<String?>, buttonTitle: String = "OK") -> some View {
        self.alert(isPresented: .constant(errorMessage.wrappedValue != nil)) {
            Alert(
                title: Text("Information"),
                message: {
                    Text(errorMessage.wrappedValue ?? "An error occurred")
                }(),
                dismissButton: .default(Text(buttonTitle)) {
                    errorMessage.wrappedValue = nil
                }
            )
        }
    }
}

