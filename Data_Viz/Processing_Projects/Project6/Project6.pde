// create a twitter streaming feed object instance
// set up hashtags we are interested in, global variables
String keywords[] = {"#Trump2016", "#ChooseCruz", "#FeelTheBern", "#Hillary2016"};
int gopCount, demsCount;
PImage img1, img2;

// connect and open a streaming object
ConfigurationBuilder connection = connect();
TwitterStream twitter = new TwitterStreamFactory(connection.build()).getInstance();

void setup()
{  
  // add listener and array of filters to track key hashtags
  twitter.addListener(listener);
  twitter.filter(new FilterQuery().track(keywords));
  prepareOnExitHandler();
  size(1000, 800);
  background(color(255));
}


void draw()
{
  fill(255, 2);
  rect(0, 0, width, height);
  
  float gopRadius = gopCount*5;
  float demRadius = demsCount*5;

  //set maxRadius at an instance of the draw
  // push pictures out as virus grows
  float maxRadius = 0;

  if ( demRadius > gopRadius)
  {
    maxRadius = demRadius;
  } else
  {
    maxRadius = gopRadius;
  }

  float xLeft=random(0, width/2 - maxRadius);
  float yLeft=random(height);
  float xRight=random(width/2 + maxRadius, width);
  float yRight=random(height);

  if (yRight > height)
  {
    yRight = height - img1.height;
  }

  if (xRight > width)
  {
    xRight = width - img2.width;
  }

  if (yLeft > height)
  {
    yLeft = height - img2.height;
  }

  if (img1 != null) 
  {
    image(img1, xLeft, yLeft);
  }
  if (img2 != null)
  {
    image(img2, xRight, yRight);
  } 

  translate(width/2, height/2);
  // draw curve vertex with randomization, radius determining size, political colors
  // void curveCircle(int pts, float radius, float tightness, color fillColor)
  curveCircle(int(random(1, 10)), gopRadius, random(1, 5), color(255, 0, 0));
  curveCircle(int(random(1, 10)), demRadius, random(1, 5), color(0, 0, 255));
}
