import geomerative.*;
RPoint[] points;

PGraphics graphic;

float t = 0;
PVector[] constants;
final int WIDTH = 800;
final int HEIGHT = 800;
final float TIME_SCALE = 0.01;

float deltaTime;
long time;

void settings()
{
  size(WIDTH,HEIGHT);
}

void setup()
{
  //constants = new PVector[2];
  //constants[0] = new PVector(7.07,7.07);
  //constants[1] = new PVector(7.07,7.07);
  time = millis();
  
  RG.init(this);
  RShape s = RG.loadShape("ltcemoji.svg");
  points = s.getPoints();
  constants = DiscreteFourierTransform(points, 2000);
  
  frameRate(600);
  graphic = createGraphics(WIDTH,HEIGHT);
  //graphic.beginDraw();
  //graphic.background(0);
  //graphic.endDraw();
}

void draw()
{
  long currentTime = millis();
  deltaTime = (currentTime - time) * 0.001f;
  time = currentTime;
  
  
  background(0);
  image(graphic,0,0);
  graphic.beginDraw();
  //graphic.scale(2);
  //scale(4);
  //translate(WIDTH/2,HEIGHT/2);
  PVector prev_point = new PVector(0,0);
  PVector cur_point = new PVector(0,0);
  graphic.noFill();
  graphic.stroke(255);
  
  noFill();
  stroke(220,10,50,100);
  
  //t += deltaTime * TIME_SCALE;
  t += 0.01666 * TIME_SCALE;
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
  //scale(0.5);
  graphic.ellipse(cur_point.x,cur_point.y,1,1);
  graphic.endDraw();
}
