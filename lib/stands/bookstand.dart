import 'package:expo_app/stands/stand_pay.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'stands.dart';
import 'checkout.dart';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'api_caller.dart';





class BookStand extends StatefulWidget {
  String itemName;
  String itemImage;
  String itemLocation;
  String itemPrice;
  String itemRating;
  String itemStatus;

  BookStand(
      {this.itemName,
        this.itemImage,
        this.itemRating,
        this.itemPrice,
        this.itemLocation,
        this.itemStatus,});
  @override
  _BookStandState createState() => _BookStandState();
}

class _BookStandState extends State<BookStand> {



  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: new AppBar(
        iconTheme: new IconThemeData(color: Colors.white),
        title: new Text("Item Detail"),
        centerTitle: false,
      ),


      body: new Stack(
        alignment: Alignment.topCenter,
        children: [
          Stack(
          children: <Widget>[

          new Container(
            height: 300.0,
            decoration: new BoxDecoration(
              color: Colors.grey.withAlpha(50),
              borderRadius: new BorderRadius.only(
                bottomRight: new Radius.circular(100.0),
                bottomLeft: new Radius.circular(100.0),
              ),
            ),
          ),
          new SingleChildScrollView(
            padding: const EdgeInsets.all(8.0),
            child: new Column(
              children: <Widget>[
                new SizedBox(
                  height: 50.0,
                ),
                new Card(
                  child: new Container(
                    width: screenSize.width,
                    margin: new EdgeInsets.only(left: 20.0, right: 20.0),
                    child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        new SizedBox(
                          height: 10.0,
                        ),
                        new Text(
                          widget.itemName,
                          style: new TextStyle(
                              fontSize: 18.0, fontWeight: FontWeight.w700),
                        ),
                        new SizedBox(
                          height: 10.0,
                        ),
                        new Text(
                            widget.itemLocation,
                          style: new TextStyle(
                              fontSize: 14.0, fontWeight: FontWeight.w400),
                        ),
                        new SizedBox(
                          height: 10.0,
                        ),
                        new Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            new Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                new Icon(
                                  Icons.star,
                                  color: Colors.blue,
                                  size: 20.0,
                                ),
                                new SizedBox(
                                  width: 5.0,
                                ),
                                new Text(
                                  "${widget.itemRating}",
                                  style: new TextStyle(color: Colors.black),
                                )
                              ],
                            ),
                            new Text(
                              "KSH.${widget.itemPrice}",
                              style: new TextStyle(
                                  fontSize: 20.0,
                                  color: Colors.red[500],
                                  fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                        new SizedBox(
                          height: 10.0,
                        ),
                      ],
                    ),
                  ),
                ),
                new Card(
                  child: new Container(
                    width: screenSize.width,
                    margin: new EdgeInsets.only(left: 20.0, right: 20.0),
                    child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        new SizedBox(
                          height: 10.0,
                        ),
                        new Text(
                          "Description",
                          style: new TextStyle(
                              fontSize: 18.0, fontWeight: FontWeight.w700),
                        ),
                        new SizedBox(
                          height: 10.0,
                        ),
                        new Text(
                          "An exhibition, in the most general sense, is an organised presentation and display of a selection of items. In practice, exhibitions usually occur within a cultural or educational setting such as a museum, art gallery, park, library, exhibition hall, or World's fairs. Exhibitions can include many things such as art in both major museums and smaller galleries, interpretive exhibitions, natural history museums and history museums, and also varieties such as more commercially focused exhibitions and trade fairs.",
                          style: new TextStyle(
                              fontSize: 14.0, fontWeight: FontWeight.w400),
                        ),
                        new SizedBox(
                          height: 10.0,
                        ),
                    const SizedBox(height: 30),
                    RaisedButton(
                      onPressed: () {

                              Navigator.of(context).push(new CupertinoPageRoute(

                                  builder: (BuildContext context) => new PayStand()
                              ));

                      },
                      textColor: Colors.white,
                      padding: const EdgeInsets.all(0.0),
                      child: Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: <Color>[
                              Color(0xFF0D47A1),
                              Color(0xFF1976D2),
                              Color(0xFF42A5F5),
                            ],
                          ),
                        ),
                        padding: const EdgeInsets.all(10.0),
                        child:
                        const Text('Book and pay now', style: TextStyle(fontSize: 20)),
                      ),
                    ),
                      ],
                    ),
                  ),
                ),

              ],
            ),
          ),
          ],
          ),
      ],
    ),
    );
  }

}

void pay() {
  var mpesa = Mpesa(
    clientKey: "hwjt1AQ4c7lRDexArlWwgtjfQYlraMMO",
    clientSecret: "fauvPwIHPhGmUl3E",
    passKey: "bfb279f9aa9bdbcf158e97dd71a467cd2e0c893059b10f78e6b72ada1ed2c919",
    initiatorPassword: "Safaricom007@",
    environment: "sandbox",
  );

  mpesa
      .lipaNaMpesa(
    phoneNumber: "0757615288",
    amount: 1,
    businessShortCode: "174379",
    callbackUrl: "",
  )
      .then((result) {})
      .catchError((error) {});
}

class Mpesa {
  final String _baseUrl;
  final String _clientKey;
  final String _clientSecret;
  final String _environment;
  final String _accessToken;
  final String _passKey;
  String _securityCredential;
  String _globalBusinessShortCode;

  Mpesa({
    @required String clientKey,
    @required String clientSecret,
    @required String environment,
    @required String initiatorPassword,
    @required String passKey,
  })  : assert(clientKey != null),
        assert(clientSecret != null),
        assert(environment != null),
        assert(initiatorPassword != null),
        assert(passKey != null),
        _clientKey = clientKey,
        _clientSecret = clientSecret,
        _environment = environment,
        _passKey = passKey,
        _baseUrl =
        environment == "production" ? Routes.production : Routes.sandbox,
        _accessToken =
        base64Url.encode((clientKey + ":" + clientSecret).codeUnits) {
    // _generateSecurityCredential(password: "", certificatepath: null);
  }

  /// You can use this to set the [businessShortCode] and you won't have to pass it everywhere. If you use this make sure to call it before any other method.
  set setGlobalBusinessShortCode(String shortCode) {
    _globalBusinessShortCode = shortCode;
  }

  Future<String> _authenticate() async {
    try {
      http.Response response = await http.get(
        "$_baseUrl${Routes.oauth}",
        headers: {
          "Authorization": "Basic $_accessToken",
        },
      );
      var data = json.decode(response.body);
      return data["access_token"];
    } catch (e) {
      throw e;
    }
  }

  // _generateSecurityCredential({String password, String certificatepath}) {
  //   var certificate;
  //   final publicKeyFile = File('./keys/sandbox-cert.cer');
  //   final parser = RSAKeyParser();

  //   final RSAPublicKey publicKey =
  //       parser.parse(publicKeyFile.readAsStringSync());
  //   final encrypter = Encrypter(RSA(publicKey: publicKey));
  // }

  /// Triggers a lipa na mpesa stk push and presents user with dialog to input mpesa pin. The method will complete regardless of whether the transaction was successful or not. Results of the transaction are sent to the [callbackUrl] provided. Ensure that the [callbackUrl] provided is publicly accessible. You can use ngrok,localtunnel or serveo for local development.
  ///
  /// `businessShortCode` can be gotten from https://developer.safaricom.co.ke/test_credentials under Lipa Na Mpesa Online Shortcode. You can ignore this if you have already used [setGlobalBusinessShortCode]
  ///
  /// `phoneNumber` is the phone number to be charged. It must be a registered mpesa number and should contain the country code i.e `254`. For example `254712345678`
  ///
  /// `amount` is the amount to be charged. During development/sandbox all money transfered is refunded by safaricom within 24 hours. Please note that this is only applicable if you're using the [businessShortCode] provided by Safaricom and not a real one.
  ///
  /// `callbackUrl` is the url to which Mpesa responses are sent upon success or failure of a transaction. Should be able to receive post requests.
  ///
  /// `accountReference` used with Mpesa paybills,
  ///
  ///  Please see https://developer.safaricom.co.ke/docs#lipa-na-m-pesa-online-payment for more info.
  Future<Map> lipaNaMpesa({
    @required String phoneNumber,
    @required double amount,
    @required String callbackUrl,
    String businessShortCode,
    String transactionType = "CustomerPaybillOnline",
    String accountReference = "account",
    String transactionDescription = "Lipa Na Mpesa",
  }) async {
    try {
      var date = DateTime.now();
      var _paybill = businessShortCode ?? _globalBusinessShortCode;
      var _timestamp =
          "${date.year}${date.month}${date.day}${date.hour}${date.minute}${date.second}";
      var _password =
      base64Url.encode((_paybill + _passKey + _timestamp).codeUnits);

      var token = await _authenticate();

      http.Response response = await http.post(
        "$_baseUrl${Routes.stkpush}",
        body: {
          "BusinessShortCode": _paybill,
          "Password": _password,
          "Timestamp": _timestamp,
          "TransactionType": transactionType,
          "Amount": amount,
          "PartyA": phoneNumber,
          "PartyB": _paybill,
          "PhoneNumber": phoneNumber,
          "CallbackURL": callbackUrl,
          "AccountReference": accountReference,
          "TransactionDesc": transactionDescription
        },
        headers: {
          "Authorization": "Bearer $token",
        },
      );
      return json.decode(response.body);
    } catch (e) {
      throw e;
    }
  }
}

