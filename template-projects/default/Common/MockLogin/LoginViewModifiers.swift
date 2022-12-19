//
//  LoginViewModel.swift
//  login
//
//  Created by Vargese, Sangeetha on 11/10/22.
//

import SwiftUI

struct RoundRectTextField: ViewModifier {
    func body(content: Content) -> some View {
        content
            .textFieldStyle(.plain)
            .autocapitalization(.none)
            .padding(.all)
            .clipShape(RoundedRectangle(cornerRadius: 5.0))
    }
}

struct LoginButton: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.headline)
            .padding()
            .frame(width: 152, height: 48)
            .background(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(lineWidth: 2)
            )
    }
}

struct SecureInputView: View {
    @Binding private var text: String
    @State private var isSecured: Bool = true
    private var title: String
    
    init(_ title: String, text: Binding<String>) {
        self.title = title
        self._text = text
    }
    
    var body: some View {
        ZStack(alignment: .trailing) {
            Group {
                if isSecured {
                    SecureField(title, text: $text)
                } else {
                    TextField(title, text: $text)
                }
            }.padding(.trailing, 32)
            
            Button(action: {
                isSecured.toggle()},
                   label: {
                Image(systemName: self.isSecured ? "eye.slash" : "eye")
                .accentColor(.gray)})
        }
    }
}

struct ErrorText: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.callout)
            .foregroundColor(Color.red)
            .frame(maxWidth: .infinity, alignment: .center)
            .multilineTextAlignment(.center)
    }
}
