void proces_json(char *json_data)
{
  int port = 666, value = 666, p_mode =666, inp = 666;
  StaticJsonBuffer<512> jsonBuffer;
  JsonObject& root = jsonBuffer.parseObject(json_data);
  if (!root.success())
  {
    Serial.println("parseObject() failed");
    return;
  }
  if (root["get_id"] == 1)
  {
    get_id();
    return;
  }
  if (int(root["module"]) != module_id)
  {
    return;
  }
  if (root.containsKey("port") == true)  port = int(root["port"]);
  if (root.containsKey("value") == true)  value = int(root["value"]);
  if (root.containsKey("p_mode") == true)  p_mode = int(root["p_mode"]);
  if (root.containsKey("inp") == true)  inp = int(root["inp"]);
  Serial.println(port);
}

void  get_id(void)
{
  Serial.println("get_id");
  StaticJsonBuffer<256> jsonBuffer;
  JsonObject& root = jsonBuffer.createObject();
  root["module"] =  module_id;
  size_t len = root.measureLength() + 1;
  char bufferr[len];
  root.printTo(bufferr, sizeof(bufferr));
  send_udp(bufferr);
}
