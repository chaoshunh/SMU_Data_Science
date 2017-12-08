// Initial connection configuration to connect to Twitter Streaming API

static String OAuthConsumerKey = "iOoS0uFu5hxVEqMIKL7uIcEII";
static String OAuthConsumerSecret = "WaO15YMNYUI49vDdnWa4TQ2BVmMejPTZXowWJlHUwcSEOlmu7W";
static String AccessToken = "245857029-NJNb4PpmjRoYgvN7WpZ3JTKefrsmi43d6X1gFU8k";
static String AccessTokenSecret = "Tp6eVg1kWIck6REHYUFCHeBA7H6iY9BtfHZpTVZEJcxCG";

ConfigurationBuilder connect(){
    ConfigurationBuilder cb = new ConfigurationBuilder();
    cb.setDebugEnabled(true);
    cb.setOAuthConsumerKey(OAuthConsumerKey);
    cb.setOAuthConsumerSecret(OAuthConsumerSecret);
    cb.setOAuthAccessToken(AccessToken);
    cb.setOAuthAccessTokenSecret(AccessTokenSecret);
  return cb;
}
