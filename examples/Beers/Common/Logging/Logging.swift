//
//  Logging.swift
//  Template
//
//  Created by Vargese, Sangeetha on 11/17/22.
//

import Foundation
import os.log

enum LogLevel {
    case info
    case debug
    case error
    case notice
    case trace
    case warning
    case fault
    case critical
}

protocol LoggingOutput {
    func send(_ message: String, logLevel: LogLevel)
    func send(_ error: Error, logLevel: LogLevel)
}

class CommonLoggingMethod {
    let outputs: [LoggingOutput]
    init(outputs: [LoggingOutput]) {
        self.outputs = outputs
    }
    
    func send(_ message: String, logLevel: LogLevel) {
        for output in self.outputs {
            output.send(message, logLevel: logLevel)
        }
    }
    
    func send(_ message: Error, logLevel: LogLevel) {
        for output in self.outputs {
            output.send(message.localizedDescription, logLevel: logLevel)
        }
    }
}

class OSLoggerLogOutput: LoggingOutput {
    let logger: Logger
    
    init(logger: Logger = OSLoggerLogOutput.createLogObject()) {
        self.logger = logger
    }
    
    private static func createLogObject() -> Logger {
        let subsystem = Bundle.main.bundleIdentifier!
        let logger = Logger(
            subsystem: subsystem,
            category: "TemplateProject"
        )
        return logger
    }
    
    func send(_ message: String, logLevel: LogLevel) {
        switch logLevel {
        case .info:
            logger.info("\(message)")
        case .debug:
            logger.debug("\(message)")
        case .error:
            logger.error("\(message)")
        case .notice:
            logger.notice("\(message)")
        case .trace:
            logger.trace("\(message)")
        case .warning:
            logger.warning("\(message)")
        case .fault:
            logger.fault("\(message)")
        case .critical:
            logger.critical("\(message)")
        }
    }
    
    func send(_ error: Error, logLevel: LogLevel) {
        let message = error.localizedDescription
        switch logLevel {
        case .info:
            logger.info("\(message)")
        case .debug:
            logger.debug("\(message)")
        case .error:
            logger.error("\(message)")
        case .notice:
            logger.notice("\(message)")
        case .trace:
            logger.trace("\(message)")
        case .warning:
            logger.warning("\(message)")
        case .fault:
            logger.fault("\(message)")
        case .critical:
            logger.critical("\(message)")
        }
    }
}

class GlobalLogger {
    static let sharedLogger = CommonLoggingMethod(outputs: [AppLoggers.object])
}

class AppLoggers {
    static let object = OSLoggerLogOutput()
}

func DLog(_ message: String, using logger: CommonLoggingMethod = GlobalLogger.sharedLogger) {
    logger.send(message, logLevel: .debug)
}

func ELog(_ error: Error, using logger: CommonLoggingMethod = GlobalLogger.sharedLogger) {
    logger.send(error.localizedDescription, logLevel: .error)
}

func ELog(_ error: String, using logger: CommonLoggingMethod = GlobalLogger.sharedLogger) {
    logger.send(error, logLevel: .error)
}

func ILog(_ message: String, using logger: CommonLoggingMethod = GlobalLogger.sharedLogger) {
    logger.send(message, logLevel: .info)
}
