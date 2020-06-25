//
//  QRCodeScannerLocalizatedStrings.swift
//  PaymentWallTask
//
//  Created SAMEH on 6/23/20.
//
//

import Foundation

struct QRCodeScannerLocalization {
    
    var ok: String {
        return "Ok"
    }
    
    var cancel: String {
        return "Cancel"
    }
    
    var paymentTitle: String {
        return "Are you sure to proceed with payment for "
    }
    
    var scanningNotSupportedTitle: String {
        return "Scanning not supported"
    }
    
    var scanningNotSupportedMessage: String {
        return "Your device does not support scanning a code from an item. Please use a device with a camera."
    }
    
    var parsingError: String {
        return "Parsing Error"
    }
    
    var wrongFormattedQRCode: String {
        return "This QR Code is in wrong format. Try another one"
    }
}
