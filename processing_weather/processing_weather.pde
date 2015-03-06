//For Maia
//Based on using http://www.wunderground.com/ API

String API_key = "Your_Key";

float diameter;

void setup() {
  size(300, 300);

  getRemoteWeatherJSON();

  diameter = getPressure();
  diameter = diameter - 1000; 
  diameter = map(diameter, 0, 30, 0, 255 );

  ellipse(width/2, height/2, diameter, diameter);
}


//Based on example from Processing.org 
//For reference
void loadFruitJSON() {
  JSONObject json_to_read;
  json_to_read = loadJSONObject("data.json");

  int count = json_to_read.getInt("count");
  float weight = json_to_read.getFloat("weight");
  String name = json_to_read.getString("name");
  boolean isFruit = json_to_read.getBoolean("isFruit");

  println(count + ", " + weight + ", " + name + ", " + isFruit);
}

//Based on example from Processing.org
void createFruitJSON() {
  JSONObject json_to_write;
  json_to_write = new JSONObject();
  json_to_write.setInt("count", 0);
  json_to_write.setString("name", "apple");
  json_to_write.setFloat("weight", 1.13);
  json_to_write.setBoolean("isFruit", true);

  saveJSONObject(json_to_write, "data/data.json");
}

//load remote file (can't get real data until you have an API key)
void fetchRemoteWeatherJSON() {
  JSONObject json_to_read;
  //json_to_read = loadJSONObject("fakeweather.json");
  String query = "http://api.wunderground.com/api/" + API_key + "/conditions/q/CA/San_Francisco.json";
  json_to_read = loadJSONObject(query);
  //Start Prove that it worked
  JSONObject new_observations = json_to_read.getJSONObject("response");
  String version_number = new_observations.getString("version");
  //int numberOfElements = results.length();
  println(version_number);
  //END Prove that it worked
  saveJSONObject(json_to_read, "data/new_data.json");
}

//read the local file and return the atmospheric 
//pressure in a usable way
float getPressure() {
  JSONObject json_to_read;
  json_to_read = loadJSONObject("fakeweather.json");
  JSONObject new_observations = json_to_read.getJSONObject("current_observation");
  String millibars = new_observations.getString("pressure_mb");
  //println(millibars);
  return float(millibars);
}

