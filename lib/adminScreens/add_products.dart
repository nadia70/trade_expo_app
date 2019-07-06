import 'dart:io';
import 'package:expo_app/tools/app_methods.dart';
import 'package:expo_app/tools/firebase_methods.dart';
import 'package:flutter/material.dart';
import 'package:expo_app/tools/app_data.dart';
import 'package:expo_app/tools/app_tools.dart';
import 'package:image_picker/image_picker.dart';

class AddProducts extends StatefulWidget {
  @override
  _AddProductsState createState() => _AddProductsState();
}

class _AddProductsState extends State<AddProducts> {
  List<DropdownMenuItem<String>> dropDownColors;
  String selectedColor;
  List<String> colorList = new List();

  List<DropdownMenuItem<String>> dropDownSizes;
  String selectedSize;
  List<String> sizeList = new List();

  List<DropdownMenuItem<String>> dropDownCategories;
  String selectedCategory;
  List<String> categoryList = new List();

  Map<int, File> imagesMap = new Map();

  TextEditingController prodcutTitle = new TextEditingController();
  TextEditingController prodcutPrice = new TextEditingController();
  TextEditingController prodcutDesc = new TextEditingController();
  TextEditingController prodRating = new TextEditingController();

  final scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    colorList = new List.from(localColors);
    sizeList = new List.from(localSizes);
    categoryList = new List.from(localCatgeories);
    dropDownColors = buildAndGetDropDownItems(colorList);
    dropDownSizes = buildAndGetDropDownItems(sizeList);
    dropDownCategories = buildAndGetDropDownItems(categoryList);
    selectedColor = dropDownColors[0].value;
    selectedSize = dropDownSizes[0].value;
    selectedCategory = dropDownCategories[0].value;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: scaffoldKey,
      backgroundColor: Theme.of(context).primaryColor,
      appBar: new AppBar(
        title: new Text("Add Products"),
        centerTitle: false,
        elevation: 0.0,
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: new RaisedButton.icon(
                color: Colors.green,
                shape: new RoundedRectangleBorder(
                    borderRadius:
                    new BorderRadius.all(new Radius.circular(15.0))),
                onPressed: () => pickImage(),
                icon: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                label: new Text(
                  "Add Images",
                  style: new TextStyle(color: Colors.white),
                )),
          )
        ],
      ),
      body: new SingleChildScrollView(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new SizedBox(
              height: 10.0,
            ),
            MultiImagePickerList(
                imageList: imageList,
                removeNewImage: (index) {
                  removeImage(index);
                }),
            new SizedBox(
              height: 10.0,
            ),
            productTextField(
                textTitle: "Expo Title",
                textHint: "Enter Product Title",
                controller: prodcutTitle),
            new SizedBox(
              height: 10.0,
            ),
            productTextField(
                textTitle: "Expo Price",
                textHint: "Enter Product Price",
                textType: TextInputType.number,
                controller: prodcutPrice),
            new SizedBox(
              height: 10.0,
            ),
            productTextField(
                textTitle: "Expo Rating",
                textHint: "Enter Rating",
                textType: TextInputType.number,
                controller: prodRating),
            new SizedBox(
              height: 10.0,
            ),
            productTextField(
                textTitle: "Expo Description",
                textHint: "Enter Description",
                controller: prodcutDesc,
                height: 180.0),
            new SizedBox(
              height: 10.0,
            ),
            productDropDown(
                textTitle: "Expo Category",
                selectedItem: selectedCategory,
                dropDownItems: dropDownCategories,
                changedDropDownItems: changedDropDownCategory),
            new SizedBox(
              height: 10.0,
            ),

            new SizedBox(
              height: 20.0,
            ),
            appButton(
                btnTxt: "Add Product",
                onBtnclicked: addNewProducts,
                btnPadding: 20.0,
                btnColor: Theme.of(context).primaryColor),
          ],
        ),
      ),
    );
  }



  void changedDropDownCategory(String selectedSize) {
    setState(() {
      selectedCategory = selectedSize;
    });
  }

  void changedDropDownSize(String selected) {
    setState(() {
      selectedSize = selected;
      selectedSize = selected;
    });
  }

  List<File> imageList;

  pickImage() async {
    File file = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (file != null) {
      //imagesMap[imagesMap.length] = file;
      List<File> imageFile = new List();
      imageFile.add(file);
      //imageList = new List.from(imageFile);
      if (imageList == null) {
        imageList = new List.from(imageFile, growable: true);
      } else {
        for (int s = 0; s < imageFile.length; s++) {
          imageList.add(file);
        }
      }
      setState(() {});
    }
  }

  removeImage(int index) async {
    //imagesMap.remove(index);
    imageList.removeAt(index);
    setState(() {});
  }

  AppMethods appMethod =new FirebaseMethods();

  addNewProducts() async{
    if (imageList == null || imageList.isEmpty) {
      showSnackBar("Product Images cannot be empty", scaffoldKey);
      return;
    }

    if (prodcutTitle.text == "") {
      showSnackBar("Product Title cannot be empty", scaffoldKey);
      return;
    }

    if (prodcutPrice.text == "") {
      showSnackBar("Product Price cannot be empty", scaffoldKey);
      return;
    }

    if (prodcutDesc.text == "") {
      showSnackBar("Product Description cannot be empty", scaffoldKey);
      return;
    }

    if (selectedCategory == "Select Product category") {
      showSnackBar("Please select a category", scaffoldKey);
      return;
    }
    displayProgressDialog(context);

//get info from the controllers
    Map<String, dynamic> newProduct = {
      productTitle: prodcutTitle.text,
      productPrice: prodcutPrice.text,
      productDesc: prodcutDesc.text,
      productCat: selectedCategory,
      productRating: prodRating.text,
    };

//adding info to firebase
    String productID = await appMethod.addNewProduct(newProduct: newProduct);


    //uploading images
    List<String> imagesURL = await appMethod.uploadProductImages(docID: productID, imageList: imageList);

    if(imagesURL.contains(error)){
      closeProgressDialog(context);
      showSnackBar("image upload Error", scaffoldKey);
      return;
    }
    bool result = await appMethod.updateProductImages(docID: productID, data: imagesURL);
    if (result != null && result == true) {
      closeProgressDialog(context);
      resetEverything();
      showSnackBar("Expo added Successfully", scaffoldKey);
    } else {
      closeProgressDialog(context);
      showSnackBar("An Error occurred Check database", scaffoldKey);
    }
  }

  void resetEverything() {
    prodcutTitle.text= "";
    prodcutDesc.text="";
    prodcutPrice.text="";
    imageList.clear();
    selectedCategory = "Select Expo Category";

  }
}