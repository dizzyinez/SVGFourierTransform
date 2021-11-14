PVector[] DiscreteFourierTransform(RPoint[] rpoints, int resolution)
{
  //int N = rpoints.length;
  //int N = rpoints.length / 2;
  int N = resolution;
  PVector[] ret = new PVector[N];
  for( int k = 0; k < N; k++)
  {
    PVector x_k = new PVector(0,0);
    PVector point = new PVector(0,0); 
    for (int n = 0; n < rpoints.length; n++)
    {
      point.x = rpoints[n].x;
      point.y = rpoints[n].y;
      PVector bit = complexMul(eulerIdentity(2.f * PI * (float)idToFrequency(k) * (float)n / (float)rpoints.length),point);
      x_k.x += bit.x;
      x_k.y += bit.y;
    }
    x_k.x /= (float)rpoints.length;
    x_k.y /= (float)rpoints.length;
    ret[k] = x_k;
  }
  return ret;
}
