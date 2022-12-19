import SwiftUI

struct LoginCredentials {
    let email: String = "dummy@gmail.com"
    let password: String = "@Ab123456"
}

struct ContentView: View {
    @StateObject private var viewModel = {
        let rules: [ValidationRule] = [ClosureValidationRule { $0.count >= 8 ? .success: .failed(reason: "Must be at least 8 characters(a-Z with at least 1 number, 1 special character")},
                                       ClosureValidationRule { $0.count <= 10 ? .success: .failed(reason: "Must be less than 10 characters")}]
        return LoginViewModel(withValidationRules: rules)
    }()
    
    var credentials = LoginCredentials()
    @State var showError = true
    @State var status = ""
    @State private var emailBorderColor: Color = .gray
    @State private var passwordBorderColor: Color = .gray
    var body: some View {
        NavigationView {
            Form {
                VStack(alignment: .center) {
                    Text("Template Version: \("\n" + AppInfo.versionString())").lineLimit(nil)
                        .multilineTextAlignment(.center)
                }.frame(maxWidth: .infinity,
                        maxHeight: 100,
                        alignment: .center)
                .listRowBackground(Color.clear)
                .listRowSeparator(.hidden)
                
                Spacer().listRowBackground(Color.clear)
                    .listRowSeparator(.hidden)
                Spacer().listRowBackground(Color.clear)
                    .listRowSeparator(.hidden)
                
                // Email Text
                VStack(alignment: .leading, spacing: 5) {
                    Group {
                        Text("Email Address*")
                        TextField("", text: $viewModel.emailObj.email)
                            .modifier(RoundRectTextField())
                            .keyboardType(.emailAddress)
                            .overlay(
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(emailBorderColor, lineWidth: 1)
                            )
                            .onChange(of: viewModel.emailObj.email, perform: { _ in
                                validateEmail()
                            })
                        Text(viewModel.emailObj.error ?? "")
                            .modifier(ErrorText())
                    }
                    // Password Text
                    Group {
                        Text("Password*")
                        SecureInputView("", text: $viewModel.passwordObj.password).modifier(RoundRectTextField())
                            .overlay(
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(passwordBorderColor, lineWidth: 1)
                            )
                            .onChange(of: viewModel.passwordObj.password, perform: { _ in
                                validatePassword()
                            })
                        Text(viewModel.passwordObj.error ?? "")
                            .modifier(ErrorText())
                    }
                    
                    // ZipCode Text
                    Group {
                        Text("ZIP")
                        TextField("", text: $viewModel.zipCodeObj.zipCode)
                            .onChange(of: viewModel.zipCodeObj.zipCode, perform: { _ in
                                let result = viewModel.zipCodeObj.zipCode.formatUSZipOrPhoneNumber(type: "zip")
                                viewModel.zipCodeObj.zipCode = result
                                validateEmail()
                            })
                            .modifier(RoundRectTextField())
                            .keyboardType(.phonePad)
                            .overlay(
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(.gray, lineWidth: 1)
                            )
                        Text(viewModel.zipCodeObj.error ?? "")
                            .modifier(ErrorText())
                    }
                    Group {
                        Text("Phone Number")
                        TextField("", text: $viewModel.phoneObj.phone)
                            .onChange(of: viewModel.phoneObj.phone, perform: { _ in
                                let result = viewModel.phoneObj.phone.formatUSZipOrPhoneNumber(type: "phone")
                                viewModel.phoneObj.phone = result
                            })
                            .modifier(RoundRectTextField())
                            .keyboardType(.phonePad)
                            .overlay(
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(.gray, lineWidth: 1)
                            )
                        Text(viewModel.phoneObj.error ?? "")
                            .modifier(ErrorText())
                    }
                }.listRowBackground(Color.clear)
                    .listRowSeparator(.hidden)
                
                VStack(alignment: .center) {
                    // Login Button
                        Button(
                            "Sign In",
                            action: {
                                viewModel.emailObj.error = viewModel.emailObj.email == credentials.email && viewModel.emailObj.error == nil ? nil : "Email address not found. Try again or Create new account."
                                
                                viewModel.passwordObj.error = viewModel.passwordObj.password == credentials.password && viewModel.passwordObj.error == nil ? nil : "Invalid password.Try again or Reset Password."
                                validateEmail()
                                validatePassword()
                            }).modifier(LoginButton())
                            .disabled(checkForValidCredentials())
                }.listRowBackground(Color.clear)
                    .listRowSeparator(.hidden)
                    .frame(maxWidth: .infinity,
                            alignment: .center)
            }
        }
    }
    
    private func checkForValidCredentials() -> Bool {
        return viewModel.emailObj.error != nil || viewModel.passwordObj.error != nil || viewModel.emailObj.email.isEmpty || viewModel.passwordObj.password.isEmpty
    }
    
    private func validateEmail() {
        if viewModel.emailObj.error != nil {
            emailBorderColor = .red
        } else {
            emailBorderColor = .gray
        }
    }
    
    private func validatePassword() {
        if viewModel.passwordObj.error != nil {
            passwordBorderColor = .red
        } else {
            passwordBorderColor = .gray
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
