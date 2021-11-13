PVector complexMul(PVector v1, PVector v2)
{
  return new PVector(
    v1.x * v2.x - v1.y * v2.y,
    v1.x * v2.y + v1.y * v2.x
  );
}

PVector eulerIdentity(float x)
{
  return new PVector(
    cos(x),
    sin(x)
  );
}
