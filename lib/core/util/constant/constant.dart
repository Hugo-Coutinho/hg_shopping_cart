class Constant {
  // HOME
  static String appBarTitle =  "Choose a food to cart";

  // API
  static String token =  "";
  static final String authorization = "Authorization";
  static final String bearer = "Bearer ";
  static final String baseUrl = "https://api.flaticon.com/v2";
  static final String authenticationUrl = baseUrl + "/app/authentication";
  static final String apiKey= "b8d616c26924b27bb4dc3a4f4237d5cb0c24cdac";
  static final String apiParametersCategoryId = "categoryId=1";
  static final String apiParametersColor = "color=2";
  static final String apiParametersPage = "page=";
  static final String getIconsUrl = baseUrl + "/items/icons?" + apiParametersCategoryId + "&" + apiParametersColor + "&" + apiParametersPage;
  static final int numberPage = 1;

  // BOX
  static final String box = "icons";
}