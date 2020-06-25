# PaymentWallTask

Architecture: VIPER with rxswift.

Design patterns: singleton, protocol oridented programming, Obsever pattern and reactive programming pattern.

Database: realm.

Other technologies that I used in this project:

Keychain for storing the logged in account.

RxRealm So when a when a record in database changed The application get the updates.


----------------------------------------------------------------------------------------------------------------

QR Codes:

here's the link for the three different cucrrencies generated qr codes

https://drive.google.com/drive/folders/10flCQxoz4ZlK0Rq_TTdprX3G5_HmpSFF

In Order To genrate a new on go to any qr code on line generator for example:

https://www.the-qrcode-generator.com

And in Text section add it in JSON for for example:

{
"paymentAmount": 1000,
"businessName": "Amazon Product 2",
"currency": "GBP"
}
