# PaymentWallTask

Architecture: VIPER with rxswift.

Design patterns: singleton, protocol oridented programming, Obsever pattern and reactive programming pattern.

Database: realm.

Other technologies that I used in this project:

Keychain for storing the logged in account.

RxRealm So when a when a record in database changed The application get the updates.

I used branches and pull requests in every feature.

I made Unit tests for sevral modules and interactors with mocks and stubs as an example.

I applied ui tests for one transaction history modules (WalletTransaction) as an example.

I made signup validation with so clean and smart way.

-------------------------------------------------------------------------------------------------------------------

QR Codes:

Here's the link for the three different cucrrencies generated qr codes:

https://drive.google.com/drive/folders/10flCQxoz4ZlK0Rq_TTdprX3G5_HmpSFF

In Order To genrate a new one, go to any qr code on line generator for example:

https://www.the-qrcode-generator.com

And in Text section add it in JSON for for example:

{
"paymentAmount": 1000,
"businessName": "Amazon Product 2",
"currency": "GBP"
}

Note: Balance and Currency are random for every new user.

---------------------------------------------------------------------------------------------------------------------

To Run To simulator or device:

1- open terminal and change directory with cd then the path of project folder, for example cd desktop/PaymentWallTask 

2- run "pod install" command 

3- build and run.



