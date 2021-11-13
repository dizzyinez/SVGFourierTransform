int idToFrequency(int id)
{
  return ((id+1) / 2) * ((id % 2 == 0) ? 1 : -1);
}
