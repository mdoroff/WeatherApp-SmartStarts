#  Error handling Best Practices


Some operations won’t always complete execution or produce output. When an operation fails, understanding what caused the failure is helpful so that users can respond accordingly.

We can have enum listing out the types of errors and a description.

enum ErrorWrapper: Error {
    case sessionExpired
    case lostConnectivity
    case timeOut
}

# Propagating Errors Using Throwing Functions

To indicate that a function, method, or initializer can throw an error, you write the throws keyword in the function’s declaration after its parameters. A function marked with throws is called a throwing function.
Throwing an error lets you indicate that something unexpected happened and the normal flow of execution can’t continue. 

func validate() throws {
        if !isValid {
            throw ValidationError.sessionExpired
        }
    }
# Handling Errors Using Do-Catch

You use a do-catch statement to handle errors by running a block of code. If an error is thrown by the code in the do clause, it’s matched against the catch clauses to determine which one of them can handle the error.

do {
    try session.validate()
} catch {
    self.showError(error: error)
}


For conditions that are likely to occur but might trigger an exception, consider handling them in a way that will avoid the exception. 

# Converting Errors to Optional Values
You use try? to handle an error by converting it to an optional value. If an error is thrown while evaluating the try? expression, the value of the expression is nil. 


When we face an error we should handle it and show it to the user. 
We can opt many ways to show the error to user.

•    We can present an alert based on a thrown error.

struct ErrorAlert: Identifiable {
    var id = UUID()
    var message: String
    var dismissAction: (() -> Void)?
}

class ErrorHandling: ObservableObject {
    @Published var currentAlert: ErrorAlert?

    func handle(error: ErrorWrapper) {
        currentAlert = ErrorAlert(message: error.localizedDescription)
    }
}



•    We can create a new view that displays an error to the user. The view presents a description of the error.

struct ErrorView: View {
    let errorWrapper: ErrorWrapper
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            VStack {
                Text("An error has occurred!")
                    .font(.title)
                    .padding(.bottom)
                Text(errorWrapper.localizedDescription)
                    .font(.headline)
            
                Spacer()
            }
            .padding()
            .background(.ultraThinMaterial)
            .cornerRadius(16)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Dismiss") {
                        dismiss()
                    }
                }
            }
        }
    }
}


# Error handling SwifUI + Combine

To turn the result of a publisher into a Result type, 
 
extension Publisher {
  func asResult() -> AnyPublisher<Result<Output, Error>, Never> {
    self
      .map(Result.success)
      .catch { error in
          Just(.failure(error))
      }
      .eraseToAnyPublisher()
  }
}


private lazy var isUsernameAvailablePublisher: AnyPublisher<Result<Bool, Error>, Never> = {
    $username
  
      .flatMap { username -> AnyPublisher<Result<Bool, Error>, Never> in
<!-- Calling the API to check if username available 
        func checkUserNameAvailablePublisher(userName: String) -> AnyPublisher<Bool, Error>  {} 
-->
self.checkUserNameAvailablePublisher(userName: username)
          .asResult()
      }
      .receive(on: DispatchQueue.main)
      .share()
      .eraseToAnyPublisher()
  }()


isUsernameAvailablePublisher
      .map { result in
        switch result {
        case .failure(let error):
            return error.localizedDescription
        case .success(let isAvailable):
          return isAvailable ? "" : "This username is not available"
        }
      }
      .assign(to: &$usernameMessage)



