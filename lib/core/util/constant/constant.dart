class Constant {

  // ASSETS
  static String baseAsset = "assets/lottie/";
  static String networkErrorAsset = baseAsset + "network-error.json";
  static String emptyAsset = baseAsset + "9091-empty-sad-shopping-bag.json";
  static String failureAsset = baseAsset + "error-screen.json";

  // ROUTER
  static String homePage = "/";
  static String shoppingCartPage = "/ShoppingCartPage";

  // MAIN
  static String appTitle=  "Shopping cart";

  // HOME
  static String appBarTitle =  "Choose a food to cart";
  static String didSaveItemAlertTitle = "Congratulations !!";
  static String didSaveItemAlertMessage = "Item added to the shopping cart";
  static String netWorkFailureMessage = "Please, verify your internet connection";
  static String defaultErrorMessage = "Something wrong";
  static String retryButtonTitle = "retry";

  // SHOPPING_CART
  static String shoppingCartTitle =  "Shopping Cart";
  static String clearAllButtonTitle =  "Clear all";

  // API
  static String token =  "";
  static final String authorization = "Authorization";
  static final String applicationJson = "application/json";
  static final String bearer = "Bearer ";
  static final String baseUrl = "https://api.flaticon.com/v2";
  static final String authenticationUrl = baseUrl + "/app/authentication";
  static final String apiKey= "b8d616c26924b27bb4dc3a4f4237d5cb0c24cdac";
  static final String apiParametersCategoryId = "categoryId=1";
  static final String apiParametersColor = "color=2";
  static final String apiParametersPage = "page=";
  static final String getIconsUrl = baseUrl + "/items/icons?" + apiParametersCategoryId + "&" + apiParametersColor + "&" + apiParametersPage;
  static final int pageONe = 1;

  // BOX
  static final String box = "icons";
}