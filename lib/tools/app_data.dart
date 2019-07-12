//Databases

import 'package:expo_app/models/fbconn.dart';

class AppData {
  static const String email = "myEmail";
  static const String password = "myPassword";
  static const String phoneNumber = "phoneNumber";
  static const String fullName = "fullName";
  static const String state = "state";
  static const String homeAddress = "homeAddress";
  static const String homeDescription = "homeDescription";
  static const String profileImgURL = "profileImgURL";
  static const String deliveryAddress = "deliveryAddress";
  static const String userID = "userID";
  static const String currentUserID = "currentUserID";
  static const String isAdmin = "isAdmin";
  static const String timeCreated = "timeCreated";
  static const String keyID = "keyID";
  static const String itemQuantity = "itemQuantity";
  static const String isFavorite = "isFavorite";
  static const String messageKeyID = "messageKeyID";
  static const String messageID = "messageID";
  static const String myMessages = "myMessages";
  static const String messageText = "messageText";
  static const String messageImageUrl = "messageImageUrl";
  static const String messageSender = "messageSender";
  static const String messageSenderUID = "messageSenderUID";
  static const String messageReceiverUID = "messageReceiverUID";
  static const String messageSenderEmail = "messageSenderEmail";
  static const String messageSenderName = "messageSenderName";
  static const String messageSenderImage = "messageSenderImage";
  static const String messageRead = "messageRead";
  static const String messageTime = "messageTime";
  static const String messageSeen = "messageSeen";

  static const String orderSenderName = "orderSenderName";
  static const String orderSenderImg = "orderSenderImg";
  static const String orderAmount = "orderAmount";
  static const String noOforders = "noOforders";
  static const String orderType = "orderType";
  static const String orderTime = "orderTime";
  static const String orderStatus = "orderStatus";
  static const String orderSeen = "orderSeen";
  static const String orderRead = "orderRead";
  static const int TYPE_PAYNOW_OUTSIDE_UMUAHIA = 0;
  static const int TYPE_PAYNOW_WITHIN_UMUAHIA = 1;
  static const int TYPE_PAYNOW_ONLY_UMUAHIA = 2;
  static const int STATUS_PENDING = 0;
  static const int STATUS_COMPLETE = 1;
  static const int STATUS_DECLINED = 2;
  static const int STATUS_REJECTED = 3;

  static final String supportUID = "08143733836";
  static const String supportID = "supportID";
  static const String senderID = "senderID";
  static const String receiverID = "senderID";
  static const String partyID = "partyID";
  static const String parties = "parties";
  static const String messageRoomDB = "messageRoomDB";
  static const String conversationsDB = "conversationsDB";

  static const String EMAIL = "myEmail";
  static const String PASSWORD = "myPassword";
  static const String PHONE_NUMBER = 'phoneNumber';
  static const String FULL_NAME = 'fullName';
  static const String APP_NAME = 'appName';
  static const String USER_DB = 'users_db';
  static const String KEY_ID = 'keyId';
  static const String OBJECT_ID = 'objectId';
  static const String USER_ID = 'userId';
  static const String USERNAME = 'userName';
  static const String ERROR_MSG = 'errorMsg';
  static const String PROFILE_IMG_URL = 'profileIMG';
  static const String PROFILE_IMAGES = 'profileImages';
  static const String MENU_ITEMS = 'menuItems';
  static const String MENU_ITEM_TITLE = 'menuTitle';
  static const String MENU_ITEM_IMG = 'menuIMG';
  static const String MENU_ITEM_ICON = 'menuIcon';

  static const String productName = "productName";
  static const String productCategory = "productCategory";
  static const String productCategories = "productCategories";
  static const String categoryImgURL = "categoryImgURL";
  static const String categoryName = "categoryName";
  static const String productPrice = "productPrice";
  static const String productRating = "productRating";
  static const String productImagesURL = "productImageURL";
  static const String productSizesAvailable = "productSizesAvailable";
  static const String productColorsAvailable = "productColorsAvailable";
  static const String productNoInStock = "productNoInStock";
  static const String productDescription = "productDescription";

  static const String userDB = "userDB";
  static const String adminDB = "adminDB";
  static const String cartDB = "cartDB";
  static const String orderNotifyDB = "orderNotifyDB";
  static const String orderHistoryDB = "orderHistoryDB";
  static const String favoriteDB = "favoriteDB";
  static const String messagesDB = "messagesDB";
  static const String userOrdersDB = "userOrdersDB";
  static const String adminOrdersDB = "adminOrdersDB";
  static const String notifyAdminOrderDB = "notifyAdminOrderDB";
  static const String productsDB = "productsDB";
  static const String categoriesDB = "categoriesDB";

  static const String loginStatusMsg = "Login Successfull";
  static const String signStatusMsg = "Account Created Successfully";
  static FbConn boutiqueFbConn;
}

const String usersData = "usersData";
const String appProducts = "appProducts";
//Database Collections
const String userCollection = "userCollection";

//user details
const String userID = "userID";
const String acctFullName = "acctFullName";
const String phoneNumber = "phoneNumber";
const String userEmail = "userEmail";
const String userPassword = "userPassword";
const String photoURL = "photoURL";
const String loggedIN = "loggedIN";

//Expo details
const String productTitle = "productTitle";
const String productPrice = "productPrice";
const String productDesc = "productDesc";
const String productCat = "productCat ";
const String productImages = "productImages";
const String productRating = "productRating";




//app data
const String successful = "successful";
const String error = "error";

List<String> localColors = [
  "Number of items",
  "All Colors",
  "Red",
  "Orange",
  "Yellow",
  "Green",
  "Blue",
  "Indigo",
  "Violet"
];

List<String> localSizes = [
  "Select a size",
  "All Sizes",
  "Small",
  "Meduim",
  "Large",
  "Extra Large"
];

List<String> localCatgeories = [
  "Select Product category",
  "Art and crafts",
  "Fashion",
  "Technology",
  "Architecture",
  "Vehicles",
  "Medicine and health",
  "Make-up"
];