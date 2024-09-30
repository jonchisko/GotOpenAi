extends OpenAiRequestBase

class_name DisplayRequest

func request_data(url: String, headers: PackedStringArray, method: HTTPClient.Method, request_data: Dictionary) -> void:
	print("URL: " + url)
	print("Headers: {headers}".format({"headers": headers}))
	print("Method: {method}".format({"method": method}))
	print("DATA: " + JSON.stringify(request_data))
