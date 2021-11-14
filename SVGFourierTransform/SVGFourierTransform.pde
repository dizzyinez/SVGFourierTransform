import geomerative.*;
RPoint[] points;

PGraphics graphic;

float t = 0;
PVector[] constants;
final int WIDTH = 1200;
final int HEIGHT = 1200;
final float TIME_SCALE = 0.04;

float deltaTime;
long time;

PVector prev_point_graphic = null;
  
void settings()
{
  size(WIDTH,HEIGHT);
}

void setup()
{
  time = millis();
  
  RG.init(this);
  RShape s = RG.loadShape("ltcemoji.svg");
  points = s.getPoints();
  constants = DiscreteFourierTransform(points, 1500);
  
  frameRate(600);
  graphic = createGraphics(WIDTH,HEIGHT);
}

void draw()
{
  long currentTime = millis();
  deltaTime = (currentTime - time) * 0.001f;
  time = currentTime;
  
  
  background(0);
  image(graphic,0,0);
  graphic.beginDraw();
  graphic.scale(2);
  scale(2);
  //translate(WIDTH/2,HEIGHT/2);
  graphic.noFill();
  graphic.stroke(255);
  noFill();
  stroke(220,10,50,100);
  
  t += 0.01666 * TIME_SCALE;
  PVector prev_point = new PVector(0,0);
  PVector cur_point = new PVector(0,0);
  for (int i = 0; i < constants.length; i++)
  {
    prev_point.x = cur_point.x;
    prev_point.y = cur_point.y;
    
    int freq = idToFrequency(i);
    
    PVector offset = complexMul(eulerIdentity(freq * t * 2.f * PI), constants[i]);
    cur_point.x += offset.x;
    cur_point.y += offset.y;
    
    float d = 2*mag(offset.x,offset.y);
    line(prev_point.x, prev_point.y, cur_point.x, cur_point.y);
    ellipse(prev_point.x,prev_point.y,d,d);
  }
  if (prev_point_graphic != null)
    graphic.line(prev_point_graphic.x, prev_point_graphic.y, cur_point.x, cur_point.y);
  else
    prev_point_graphic = new PVector(0,0);
  prev_point_graphic.x = cur_point.x;
  prev_point_graphic.y = cur_point.y;
    
  scale(0.5);
  //graphic.ellipse(cur_point.x,cur_point.y,1,1);
  graphic.endDraw();
}
