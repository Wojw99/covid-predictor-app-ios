class ServiceHelper {
  bool convertToBool(String json) {
    if (json.toLowerCase() == 'true')
      return true;
    else if (json.toLowerCase() == 'false') return false;
    throw new Exception("Given string cannot be converted to bool!");
  }
}
